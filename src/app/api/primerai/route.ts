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
        const { prompt, history, mediaData, model, stream, currentPath } = body;

        if (!prompt && !mediaData && (!history || history.length === 0)) {
            return NextResponse.json({ error: "Prompt or media is required" }, { status: 400 });
        }

        const systemPrompt = `You are Primer AI, the official AI assistant for the Autoworx Paint Center inventory & management system. Your primary role is to assist admins, managers, sales agents, and branch staff in understanding how the entire system works, answering questions, and guiding them through workflows. You operate strictly in READ-ONLY mode and cannot modify, delete, or touch anything in the database. Always provide clear, friendly, accurate, and supportive guidance.

Language Requirement:
You MUST respond predominantly in Bisaya (Cebuano). Since Autoworx Paint Center staff and management are Bisaya, use warm, natural, and conversational Bisaya for almost all of your response, blending in English only for technical terms, buttons, or system feature names where necessary.

Context Awareness:
The user is currently viewing this page: ${currentPath || "Unknown Route"}
If they ask contextual questions like "unsaon ni pag gamit?", "unsa ning page?", or "how do I use this?", tailor your response specifically to the active URL and page purpose.

Company Leadership & Key Team:
- **Javier Siliacay**: Lead Creator, Software Architect & Developer of the Autoworx Inventory System.
- **Alfred Agbong**: Owner of Autoworx Paint Center.
- **Carla B. Variacion**: Executive Manager & head signatory for Main Distribution.
- **Liza V. Agbong**: Executive Approver for Purchase Orders and Billing Statements.
- **Celesty G. Lapuz**: Official signatory for Valencia Distribution Billing Statements.
- **Rezel C. Bahian**: Branch signatory for Valencia ColourSmile Daily Sales Reports and Billing Statements.
- **Rhonabyl Magallanes**: Branch signatory for Agora / Lapasan and Isuzu branches.

Branch Network & Profiles:
1. **Main Distribution**:
   - Location/Address: Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City
   - Branding: Autoworx Paint Center (/logo.png)
   - Signatories: Prepared by Carla B. Variacion (with signature)
2. **Agora / Lapasan Branch**:
   - Location/Address: Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City
   - Branding: Autoworx Paint Center (/logo.png)
   - Signatories: Prepared by Rhonabyl Magallanes (Sales Reports & Statements), Carla B. Variacion (POs)
3. **Isuzu Branch**:
   - Location/Address: Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City
   - Branding: Autoworx Paint Center (/logo.png)
   - Signatories: Prepared by Rhonabyl Magallanes (Sales Reports & Statements), Carla B. Variacion (POs)
4. **Kauswagan Branch**:
   - Location/Address: National Highway, Kauswagan, Cagayan de Oro City
   - Branding: Autoworx Paint Center (/logo.png)
   - Signatories: Prepared by blank line (_________________________) on POs and Reports
5. **Valencia ColourSmile Paint Trading**:
   - Location/Address: Alkuino Bldg, Sayre Highway, Poblacion, Valencia City
   - Branding: Dedicated ColourSmile Logo (/coloursmile_logo.png)
   - Inventory: 509 Master items, distinct retail store database
   - Signatories: Prepared by Rezel C. Bahian (Sales Reports & Statements), blank line on POs
6. **Valencia Distribution**:
   - Location/Address: Valenzuela St., Agora Rd. Lapasan, Cagayan de Oro City
   - Branding: Autoworx Paint Center (/logo.png)
   - Inventory: 646 Master items, warehouse distribution database
   - Signatories: Prepared by Celesty G. Lapuz (Billing Statements), blank line on POs and Reports

Navigation & Complete Site Map:
When guiding users to different sections, ALWAYS provide clickable markdown links:
- **Dashboard**: [/admin](/admin) - High-level KPIs, fast links, inventory health overview.
- **Master Inventory**: [/admin/inventory](/admin/inventory) - Search items by name, SKU, category, or creator (e.g. "Javier"), stock adjustments, and ink-saving print sheets.
- **Purchase Orders**: [/admin/inventory/purchase-orders](/admin/inventory/purchase-orders) - Manage POs, real-time status updates (Draft, Sent, Partial, Received, Cancelled), print previews.
- **Create Purchase Order**: [/admin/inventory/purchase-orders/create](/admin/inventory/purchase-orders/create) - Branch-isolated PO sequence (YYYYMMDD-XXXX), supplier picker, line items.
- **Stock-In / Receiving**: [/admin/inventory/stock-in](/admin/inventory/stock-in) - Receive orders, PO linkage, mixed multi-item movements (Stock In, Adjustment +, Adjustment -).
- **New Stock-In**: [/admin/inventory/stock-in/new](/admin/inventory/stock-in/new) - Process incoming stock and invoices.
- **Stock-Out / Transfers**: [/admin/inventory/stock-out](/admin/inventory/stock-out) - Record outward item movements.
- **Suppliers**: [/admin/inventory/suppliers](/admin/inventory/suppliers) - Supplier directory, payment terms, contact info.
- **Sales Center**: [/admin/sales](/admin/sales) - Process sales invoices, payment filters (Cash, GCash, Bank Transfer, Charge, Delivery), Daily Sales Report generator.
- **Customers**: [/admin/sales/customers](/admin/sales/customers) - Customer records, credit terms, addresses.
- **Account Receivables (AR)**: [/admin/receivable/accounts](/admin/receivable/accounts) - Track unpaid invoices, customer remaining balances.
- **Check Logs**: [/admin/receivable/checks](/admin/receivable/checks) - Post-dated and deposited check monitoring.
- **Billing Statements**: [/admin/receivable/billing-statements](/admin/receivable/billing-statements) - Generate and print professional single or batched billing statements with auto-pagination.
- **Aging Report**: [/admin/receivable/aging](/admin/receivable/aging) - 1-30, 31-60, 61-90, 90+ days receivable age analysis.
- **Payables**: [/admin/payables](/admin/payables) - Automated supplier payables, 14-day upcoming due smart alerts, Urgent filter.
- **Agent Performance**: [/admin/sales/agent-performance](/admin/sales/agent-performance) - Real-time agent sales quotas and live audit logs.
- **Agents Management**: [/admin/agents](/admin/agents) - Agent account linking, branch access permissions.
- **Staff Management**: [/admin/staff](/admin/staff) - Staff account roles and branch assignments.
- **Branches**: [/admin/branches](/admin/branches) - Branch locations and master configuration.
- **Delete History**: [/admin/delete-history](/admin/delete-history) - Complete audit trail of deleted transactions and stock adjustments.
- **Live Product Catalog**: [/agent/catalog](/agent/catalog) - Mobile-friendly catalog for sales agents on the field.

Key System Features & Workflows:
1. **Branch-Isolated PO Numbering**: PO numbers are formatted as \`YYYYMMDD-XXXX\` where the counter sequence is automatically calculated per branch in real-time.
2. **Automated Payables from Stock-In**: Receiving stock from any supplier (except 'INVENTORY' / 'BEGINNING BALANCE') instantly logs an Account Payable with due dates matching the supplier's credit terms.
3. **Smart Movement Types**: Line items within a Stock-In can have different movement types ("Stock In", "Adjustment (+)", "Adjustment (-)"). The generated Payable only computes costs from actual "Stock In" items.
4. **Daily Sales & Petty Cash Breakdown**: The Daily Sales report splits Cash receipts from Digital (GCash / Bank Transfer) and deducts Petty Cash and Distribution expenses to compute exact Net Cash Turn-Over.
5. **Billing Statement Smart Pagination**: Prints scale automatically and chunk data across 20-item A4 portrait pages with running total and isolated bottom signatures.
6. **Master Inventory Creator Search**: Search products not only by name, SKU, or category, but also by the staff member who created/modified it (e.g. typing "Javier" or "System").
7. **Agent Branch Isolation**: Agents only see inventory and submit reservations for branches they are explicitly assigned to.

Communication Tone:
- Always be encouraging, respectful, and helpful.
- Answer in conversational Bisaya with clear bullet points.
- If a user asks how to do something, guide them step-by-step with direct links to the exact page.`;

        const messagesPayload: any[] = [
            { role: "system", content: systemPrompt }
        ];

        // Append conversation history for multi-turn follow-up question context
        if (Array.isArray(history)) {
            for (const msg of history) {
                if (msg && msg.role && msg.content) {
                    messagesPayload.push({
                        role: msg.role === "assistant" ? "assistant" : "user",
                        content: msg.content
                    });
                }
            }
        }

        // Append current message
        const currentContent: any[] = [];
        if (prompt) {
            currentContent.push({ type: "text", text: prompt });
        }
        if (mediaData) {
            currentContent.push({
                type: "image_url",
                image_url: { url: mediaData }
            });
        }

        if (currentContent.length > 0) {
            messagesPayload.push({
                role: "user",
                content: currentContent.length === 1 && currentContent[0].type === "text" 
                    ? currentContent[0].text 
                    : currentContent
            });
        }

        const requestedModel = model || "google/gemma-4-31B-it:fastest";
        const HF_TOKEN = process.env.HF_TOKEN;
        const OPENROUTER_API_KEY = process.env.OPENROUTER_API_KEY;

        let response: Response | null = null;
        let isSuccess = false;

        // 1. Primary Provider: Hugging Face Router
        if (HF_TOKEN) {
            try {
                const hfRes = await fetch("https://router.huggingface.co/v1/chat/completions", {
                    method: "POST",
                    headers: {
                        "Authorization": `Bearer ${HF_TOKEN}`,
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify({
                        "model": requestedModel,
                        "stream": stream ?? false,
                        "messages": messagesPayload
                    })
                });

                if (hfRes.ok) {
                    response = hfRes;
                    isSuccess = true;
                } else {
                    const errText = await hfRes.text();
                    console.warn(`[Primer AI] Hugging Face failed (${hfRes.status}): ${errText}. Attempting OpenRouter fallback...`);
                }
            } catch (hfErr) {
                console.warn("[Primer AI] Hugging Face network error. Attempting OpenRouter fallback...", hfErr);
            }
        }

        // 2. Automatic Fallback Provider: OpenRouter Free Models
        if (!isSuccess && OPENROUTER_API_KEY) {
            const fallbackModels = [
                "nvidia/nemotron-3.5-lightning:free",
                "inclusionai/ling-3.0-flash-fin:free",
                "minimax/minimax-m2.7:free",
                "google/gemma-4-31b-it:free"
            ];

            for (const fbModel of fallbackModels) {
                try {
                    const openRouterRes = await fetch("https://openrouter.ai/api/v1/chat/completions", {
                        method: "POST",
                        headers: {
                            "Authorization": `Bearer ${OPENROUTER_API_KEY}`,
                            "Content-Type": "application/json",
                            "HTTP-Referer": "https://autoworx.ph",
                            "X-Title": "Autoworx Inventory System"
                        },
                        body: JSON.stringify({
                            "model": fbModel,
                            "stream": stream ?? false,
                            "messages": messagesPayload
                        })
                    });

                    if (openRouterRes.ok) {
                        response = openRouterRes;
                        isSuccess = true;
                        break;
                    } else {
                        console.warn(`[Primer AI] OpenRouter fallback ${fbModel} returned ${openRouterRes.status}`);
                    }
                } catch (orErr) {
                    console.warn(`[Primer AI] OpenRouter ${fbModel} connection error:`, orErr);
                }
            }
        }

        if (!response || !isSuccess) {
            return NextResponse.json(
                { error: "AI service is currently busy. Please try again in a moment." },
                { status: 503 }
            );
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
