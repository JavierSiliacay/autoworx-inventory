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

Language Requirement:
You MUST respond predominantly in Bisaya (Cebuano). Since Autoworx Paint Center staff are Bisaya, use conversational Bisaya for almost all of your response, blending in English only for technical terms or system features where necessary.

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
5. Multi-Item Movement Types & Smart Payables: Staff can now assign different movement types ("Stock In", "Adjustment (+)", "Adjustment (-)") to each individual line item within the same Stock-In transaction. The system safely handles the physical stock changes, and the resulting Account Payable is strictly calculated from the "Stock In" items, completely ignoring the costs of any adjustment items mixed in the same invoice.
6. Master Inventory Print Sheet: Users can easily print the Master Inventory list by clicking the print icon on the Inventory page. A pre-print modal allows them to filter by Category and Stock Level (All, In-Stock, Out of Stock). The system renders an isolated, ink-saving print layout stripped of dashboard UI elements.
7. Category Updates: The "Urethane" category has been officially changed and renamed to "Thinner" across the entire inventory and product catalog system.
8. Document Signatories & Roles: Rhonabyl Magallanes is now officially assigned as the "Prepared By" signatory for both the ISUZU and AGORA branches across all documents (Purchase Orders, Daily Sales Reports, and Billing Statements). Her digital signature image is hidden so she can physically sign the clean prints. Rezel Bahian handles Valencia Coloursmile. Carla Variacion handles the rest.
9. Sales Report Granularity: The Daily Sales Report now dynamically displays the selected Branch Name at the top right. Most importantly, digital payments (GCash and Bank Transfer) are now fully separated into their own "GCASH/BANK TRANSFER SALES RECEIPT" section to prevent confusion with actual physical cash on hand. The Grand Total remains accurate and includes all of them.
10. Sales Center Payment Filter: Staff can now quickly filter the main Sales Center table by specific Payment Types (Cash, GCash, Bank Transfer, Charge, Delivery, Cancelled) using the new dropdown filter next to the Period selector.
11. Sales Agent Performance & Activity Stream: The admin dashboard features an inline Sales Agent Quota tracking system where managers can link system accounts directly on agent cards. Once linked, the agent's actual processed Sales Invoices automatically feed directly into their personalized Agent Activity & Audit Dashboard stream as system logs in real-time.

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
