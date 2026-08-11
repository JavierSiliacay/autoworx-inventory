import { NextResponse } from "next/server";

// Simple in-memory rate limiting map (IP -> { count, resetTime })
const rateLimitMap = new Map<string, { count: number; resetTime: number }>();
const RATE_LIMIT_WINDOW_MS = 60 * 1000; // 1 minute
const MAX_REQUESTS_PER_WINDOW = 10;

export async function POST(request: Request) {
    try {
        // --- Rate Limiting Logic ---
        const ip = request.headers.get("x-forwarded-for") ?? "127.0.0.1";
        const now = Date.now();
        let record = rateLimitMap.get(ip);

        if (!record || now > record.resetTime) {
            record = { count: 0, resetTime: now + RATE_LIMIT_WINDOW_MS };
        }

        record.count += 1;
        rateLimitMap.set(ip, record);

        if (record.count > MAX_REQUESTS_PER_WINDOW) {
            return NextResponse.json(
                { error: "Too many requests. Please wait a minute before asking another question." },
                { status: 429 }
            );
        }
        // ---------------------------

        const body = await request.json();
        const { prompt, mediaData, model, stream, currentPath } = body;

        if (!prompt && !mediaData) {
            return NextResponse.json({ error: "Prompt or media is required" }, { status: 400 });
        }

        const requestedModel = model || "google/gemma-4-31B-it:fastest";
        const HF_TOKEN = process.env.HF_TOKEN;

        if (!HF_TOKEN) {
            return NextResponse.json({ error: "HF_TOKEN is not configured in the environment" }, { status: 500 });
        }

        const contentPayload: any[] = [];
        if (prompt) {
            contentPayload.push({ type: "text", text: prompt });
        }
        
        if (mediaData) {
            contentPayload.push({
                type: "image_url",
                image_url: {
                    url: mediaData
                }
            });
        }

        const response = await fetch("https://router.huggingface.co/v1/chat/completions", {
            method: "POST",
            headers: {
                "Authorization": `Bearer ${HF_TOKEN}`,
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                "model": requestedModel,
                "stream": stream ?? false,
                "messages": [
                    {
                        role: "system",
                        content: `You are Primer AI, the official AI assistant for the Autoworx Paint Center inventory & management system. Your primary role is to assist admins, agents, and staff in understanding how the system works. You operate strictly in READ-ONLY mode and cannot modify, delete, or touch anything in the database. Always provide clear, accurate, and supportive guidance.

Context Awareness:
The user is currently viewing this page: ${currentPath || "Unknown Route"}
If they ask contextual questions like "how do I use this page?", answer based on that URL.

Company Leadership & Facts:
- Javier Siliacay is the creator/developer of the system.
- Carla Variacion is the manager.
- Alfred Agbong is the owner of Autoworx.
If users ask about the owner, creator, or manager, provide these exact names.

Navigation & Site Map:
When guiding users to different parts of the system, you MUST use markdown links pointing to the exact routes below:
- Dashboard: /admin
- Master Inventory: /admin/inventory
- Purchase Orders: /admin/inventory/purchase-orders
- Stock-In / Receiving: /admin/inventory/stock-in
- Suppliers: /admin/inventory/suppliers
- Sales Invoice: /admin/sales
- Customers List: /admin/sales/customers
- Account Receivables: /admin/receivable/accounts
- Check Logs: /admin/receivable/checks
- Billing Statements: /admin/receivable/billing-statements
- Aging Report: /admin/receivable/aging
- Agents Management: /admin/agents
- Staff Management: /admin/staff
- Branches: /admin/branches
- Payables: /admin/payables
- Delete History: /admin/delete-history

Recent System Updates & Automations:
You are aware of the newly integrated Payables Automation features:
1. Automated Payables: When staff process a Stock-in (from any supplier except 'INVENTORY' and 'BEGINNING BALANCE'), it automatically creates an Account Payable. If a stock-in is edited or deleted, the payable dynamically updates or deletes itself in real-time.
2. Supplier Terms: The system tracks Payment Terms (e.g., 30 Days, 120 Days). If an admin changes a supplier's terms, the due dates of all pending payables for that supplier automatically recalculate.
3. Smart Notifications: The system features a proactive Notification Bell and a Floating Modal that alerts Main Distribution staff if they have any payables due within the next 14 days to avoid overdue penalties.
4. Urgent Payables Filter: On the Payables Dashboard, there is an "Urgent Only" toggle button. Managers can click this to instantly filter the list to only show overdue payables and payables due within the next 14 days.

Format links clearly, e.g., "You can view that on the [Inventory Page](/admin/inventory)".`
                    },
                    { role: "user", content: contentPayload }
                ]
            })
        });

        if (!response.ok) {
            const errorData = await response.json();
            console.error("HuggingFace Router API error:", errorData);
            return NextResponse.json({ error: "HuggingFace Error: " + JSON.stringify(errorData) }, { status: response.status });
        }

        if (stream && response.body) {
            return new Response(response.body, {
                headers: {
                    "Content-Type": "text/event-stream",
                    "Cache-Control": "no-cache",
                    "Connection": "keep-alive"
                }
            });
        }

        const data = await response.json();
        const content = data.choices?.[0]?.message?.content || "No response";

        return NextResponse.json({ result: content });

    } catch (err) {
        console.error("WorxAI API Error:", err);
        const errorMessage = err instanceof Error ? err.message : "Internal Server Error";
        return NextResponse.json({ error: errorMessage }, { status: 500 });
    }
}
