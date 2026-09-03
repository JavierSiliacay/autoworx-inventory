import { NextResponse } from "next/server";
import { supabase } from "@/lib/supabase";

// Simple in-memory rate limiting map (IP -> { count, resetTime })
const rateLimitMap = new Map<string, { count: number; resetTime: number }>();
const RATE_LIMIT_WINDOW_MS = 60 * 1000; // 1 minute
const MAX_REQUESTS_PER_WINDOW = 10;

/**
 * 🔒 SAFE READ-ONLY LIVE DATABASE LOOKUP HELPER
 * Strictly executes read queries with .select() to give Primer AI real-time awareness
 * without granting any write, update, or delete privileges.
 */
async function fetchSafeLiveContext(
    userPrompt: string, 
    currentPath?: string, 
    selectedBranchId?: string, 
    activeBranchName?: string
): Promise<string> {
    if (!userPrompt) return "";
    const lower = userPrompt.toLowerCase();
    const liveSnippets: string[] = [];

    // Stop words to remove so we extract real entity names (products, customers, banks)
    const stopWords = new Set([
        'pila', 'pilay', 'pila ka', 'ang', 'mga', 'nga', 'naa', 'bay', 'available', 'stock', 'inventory', 
        'tagpila', 'presyo', 'price', 'check', 'cheque', 'cheques', 'tseke', 'sa', 'og', 'si', 
        'ni', 'kang', 'para', 'kay', 'the', 'what', 'how', 'much', 'many', 'for', 
        'where', 'when', 'unsa', 'kinsa', 'diin', 'kanus-a', 'karon', 'ron', 'today', 'now',
        'pa', 'ka', 'ba', 'ta', 'ha', 'mo', 'ko', 'mi', 'siya', 'sila', 'ninyo', 'namo',
        'ato', 'inyo', 'atong', 'inyong', 'namong', 'palihog', 'please', 'tell', 'show',
        'list', 'tanan', 'tanang', 'overall', 'total', 'over', 'is', 'are', 'in', 'at',
        'pending', 'cleared', 'bounced', 'cancelled', 'unpaid', 'paid', 'completed', 'active',
        'utang', 'receivable', 'receivables', 'ar', 'balance', 'balances', 'semana', 'semanaha', 
        'karung', 'karong', 'week', 'this week', 'next week', 'month', 'bulan', 'bulana', 'tuig', 'tuiga', 'adlaw', 'adlawng'
    ]);

    const rawWords = lower.replace(/[^\w\s-]/g, ' ').split(/\s+/);
    const meaningfulKeywords = rawWords.filter(w => w.length >= 2 && !stopWords.has(w));

    // ─── Disambiguation: Skip raw data dump if user is asking HOW to fill/input/record ───
    const isHowToQuestion = /\b(unsaon|unsa may ibutang|ibutang|unsa ibutang|asa ibutang|unsaon pag|unsaon pag-input|how to|how do i|step|steps|guide|paagi|form|fill|input)\b/i.test(lower);

    // ─── 1. AR / Utang / Unpaid Balances Intent ───
    const isArIntent = !isHowToQuestion && /\b(utang|receivable|receivables|balance|balances|unpaid|bayrunon|collect)\b/i.test(lower);
    if (isArIntent) {
        try {
            let arQuery = supabase
                .from('accounts_receivable')
                .select('invoice_no, customer_name, total_amount_due, amount_collected, remaining_balance, date, payment_status, branches(name)')
                .gt('remaining_balance', 0)
                .order('remaining_balance', { ascending: false });

            if (selectedBranchId && selectedBranchId !== "all") {
                arQuery = arQuery.eq('branch_id', selectedBranchId);
            }

            // If user asks about a specific customer (e.g. "utang ni North-Min")
            if (meaningfulKeywords.length > 0) {
                const kw = meaningfulKeywords[0];
                arQuery = arQuery.or(`customer_name.ilike.%${kw}%,invoice_no.ilike.%${kw}%`);
            }

            const { data: arData } = await arQuery.limit(8);
            if (arData && arData.length > 0) {
                const totalTop = arData.reduce((sum, a) => sum + Number(a.remaining_balance || 0), 0);
                const scopeLabel = selectedBranchId && selectedBranchId !== "all" ? `for ${activeBranchName}` : `Global Top Invoices`;
                liveSnippets.push(`[LIVE ACCOUNTS RECEIVABLE / UTANG (${scopeLabel} | Sum of these ${arData.length}: ₱${totalTop.toLocaleString()})]:\n` + JSON.stringify(arData.map(a => ({
                    invoice_no: a.invoice_no,
                    customer: a.customer_name,
                    total_amount_due: `₱${Number(a.total_amount_due).toLocaleString()}`,
                    remaining_balance: `₱${Number(a.remaining_balance).toLocaleString()}`,
                    invoice_date: a.date,
                    status: a.payment_status,
                    branch: (a.branches as any)?.name || 'Main Distribution'
                })), null, 2));
            }
        } catch (e) {
            console.warn("[Primer AI] AR lookup error:", e);
        }
    }

    // ─── 2. Cheque Intent ───
    const isChequeIntent = !isHowToQuestion && /\b(check|cheque|cheques|tseke|mature|pdc|post-dated|bdo|landbank|pnb|metrobank|boc|security bank)\b/i.test(lower);
    if (isChequeIntent) {
        try {
            let checkQuery = supabase
                .from('check_logs')
                .select('invoice_no, customer_name, bank, check_no, check_date, check_amount, status, branches(name)')
                .order('check_date', { ascending: true })
                .limit(8);

            if (selectedBranchId && selectedBranchId !== "all") {
                checkQuery = checkQuery.eq('branch_id', selectedBranchId);
            }

            if (meaningfulKeywords.length > 0) {
                const kw = meaningfulKeywords[0];
                checkQuery = checkQuery.or(`customer_name.ilike.%${kw}%,bank.ilike.%${kw}%,check_no.ilike.%${kw}%,invoice_no.ilike.%${kw}%`);
            } else {
                checkQuery = checkQuery.eq('status', 'Pending');
            }

            const { data: checkData } = await checkQuery;
            if (checkData && checkData.length > 0) {
                const totalPending = checkData.filter(c => c.status === 'Pending').reduce((sum, c) => sum + Number(c.check_amount || 0), 0);
                const scopeLabel = selectedBranchId && selectedBranchId !== "all" ? `in ${activeBranchName}` : `All Branches`;
                liveSnippets.push(`[LIVE CHEQUE TRANSACTIONS (${scopeLabel} | Total Pending: ₱${totalPending.toLocaleString()})]:\n` + JSON.stringify(checkData.map(c => ({
                    invoice_no: c.invoice_no,
                    customer: c.customer_name,
                    bank: c.bank,
                    check_no: c.check_no,
                    check_date: c.check_date,
                    amount: `₱${Number(c.check_amount).toLocaleString()}`,
                    status: c.status,
                    branch: (c.branches as any)?.name || 'Main Distribution'
                })), null, 2));
            }
        } catch (e) {
            console.warn("[Primer AI] Cheque lookup error:", e);
        }
    }

    // ─── 3. Inventory Stock Intent ───
    const isStockIntent = !isHowToQuestion && !isArIntent && !isChequeIntent && /\b(stock|available|inventory|tagpila|presyo|price|item|liter|liters|gallon|gallons|set|can|primer|clear|thinner|nax|paint|ureth|metalguard|nippon|autobase)\b/i.test(lower);
    if (isStockIntent) {
        try {
            let stockQuery = supabase
                .from('inventory')
                .select('product_name, sku, category, quantity, unit, price, dealers_price, branches(name)')
                .limit(6);

            if (selectedBranchId && selectedBranchId !== "all") {
                stockQuery = stockQuery.eq('branch_id', selectedBranchId);
            }

            if (meaningfulKeywords.length > 0) {
                const prioritizedKeyword = meaningfulKeywords.find(k => k.length >= 3) || meaningfulKeywords[0];
                stockQuery = stockQuery.or(`product_name.ilike.%${prioritizedKeyword}%,sku.ilike.%${prioritizedKeyword}%`);
            } else {
                stockQuery = stockQuery.order('quantity', { ascending: false });
            }

            const { data: stockData } = await stockQuery;
            if (stockData && stockData.length > 0) {
                liveSnippets.push(`[LIVE INVENTORY STOCK (${stockData.length} records)]:\n` + JSON.stringify(stockData.map(i => ({
                    product: i.product_name,
                    sku: i.sku || 'N/A',
                    available_quantity: i.quantity,
                    unit: i.unit || 'units',
                    standard_price: i.price ? `₱${Number(i.price).toLocaleString()}` : 'N/A',
                    dealers_price: i.dealers_price ? `₱${Number(i.dealers_price).toLocaleString()}` : 'N/A',
                    branch: (i.branches as any)?.name || 'Main Distribution'
                })), null, 2));
            }
        } catch (e) {
            console.warn("[Primer AI] Stock lookup error:", e);
        }
    }

    // ─── 4. Live Agent Reservations Lookup ───
    const isResIntent = /\b(reservation|reservations|reserve|reserva)\b/i.test(lower);
    if (isResIntent) {
        try {
            let resQuery = supabase
                .from('agent_reservations')
                .select('product_name, branch_name, client_name, client_phone, quantity, status, notes, created_at')
                .order('created_at', { ascending: false })
                .limit(5);

            if (selectedBranchId && selectedBranchId !== "all" && activeBranchName) {
                resQuery = resQuery.ilike('branch_name', `%${activeBranchName}%`);
            }

            const { data: resData } = await resQuery;
            if (resData && resData.length > 0) {
                liveSnippets.push(`[LIVE AGENT RESERVATIONS (${resData.length} recent requests)]:\n` + JSON.stringify(resData.map(r => ({
                    product: r.product_name,
                    client: r.client_name,
                    phone: r.client_phone || 'N/A',
                    quantity: r.quantity,
                    branch: r.branch_name,
                    status: r.status,
                    notes: r.notes || 'None',
                    date: r.created_at ? new Date(r.created_at).toLocaleDateString() : 'N/A'
                })), null, 2));
            }
        } catch (e) {
            console.warn("[Primer AI] Reservation lookup notice:", e);
        }
    }

    // ─── 5. Live Purchase Orders Lookup ───
    const isPoIntent = /\b(purchase order|recent po|po number|po)\b/i.test(lower) && !isArIntent;
    if (isPoIntent) {
        try {
            let poQuery = supabase
                .from('purchase_orders')
                .select('po_number, order_date, terms, status, prepared_by, total_amount, branches(name), suppliers(name)')
                .order('order_date', { ascending: false })
                .limit(5);

            if (selectedBranchId && selectedBranchId !== "all") {
                poQuery = poQuery.eq('branch_id', selectedBranchId);
            }

            const { data: poData } = await poQuery;
            if (poData && poData.length > 0) {
                liveSnippets.push(`[LIVE RECENT PURCHASE ORDERS (${poData.length} orders)]:\n` + JSON.stringify(poData.map(p => ({
                    po_number: p.po_number,
                    order_date: p.order_date,
                    supplier: (p.suppliers as any)?.name || 'N/A',
                    total_amount: p.total_amount ? `₱${Number(p.total_amount).toLocaleString()}` : 'N/A',
                    status: p.status,
                    prepared_by: p.prepared_by,
                    branch: (p.branches as any)?.name || 'Main Distribution'
                })), null, 2));
            }
        } catch (e) {
            console.warn("[Primer AI] PO lookup notice:", e);
        }
    }

    if (liveSnippets.length === 0) return "";

    return `=== 🔴 LIVE DATABASE REAL-TIME CONTEXT (READ-ONLY SNAPSHOT) ===\n` +
        liveSnippets.join("\n\n") +
        `\n=== END LIVE DATABASE CONTEXT ===\n` +
        `Instruction for Live Data: Use the exact verified numbers, quantities, units, dates, customer names, and peso amounts from the live database snapshot above in your response. Answer naturally in warm Bisaya with clear bullet points.`;
}

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
        const { prompt, history, mediaData, model, stream, currentPath, selectedBranchId } = body;

        if (!prompt && !mediaData && (!history || history.length === 0)) {
            return NextResponse.json({ error: "Prompt or media is required" }, { status: 400 });
        }

        // Resolve Active Branch Name from selectedBranchId
        let activeBranchName = "All Branches (Global View)";
        if (selectedBranchId && selectedBranchId !== "all") {
            try {
                const { data: bData } = await supabase
                    .from('branches')
                    .select('name')
                    .eq('id', selectedBranchId)
                    .single();
                if (bData?.name) {
                    activeBranchName = bData.name;
                }
            } catch (bErr) {
                console.warn("[Primer AI] Branch name lookup error:", bErr);
            }
        }

        const systemPrompt = `You are Primer AI, the official AI assistant for the Autoworx Paint Center inventory & management system. Your primary role is to assist admins, managers, sales agents, and branch staff in understanding how the entire system works, answering questions, and guiding them through workflows.

Read-Only Access Clarification:
You have LIVE, read-only visibility into the database through real-time snapshot data injected into your context — you CAN see live balances, stock levels, AR records, cheques, and POs right now. What you CANNOT do is directly mutate, update, delete, or create records on behalf of the user. Instead, you guide users step-by-step on HOW to perform those actions in the system UI. NEVER say "dili nako ma-access ang live database" because you ALWAYS have current live data in your context. Always provide clear, friendly, accurate, and supportive guidance.

Language Requirement:
You MUST respond predominantly in Bisaya (Cebuano). Since Autoworx Paint Center staff and management are Bisaya, use warm, natural, and conversational Bisaya for almost all of your response, blending in English only for technical terms, buttons, or system feature names where necessary.

Context Awareness:
- **Active URL Page**: ${currentPath || "Unknown Route"}
- **Active Selected Branch in UI**: ${activeBranchName} (Branch ID: ${selectedBranchId || "all"})
If they ask contextual questions like "unsaon ni pag gamit?", "unsa ning page?", or ask for stock/balances in their currently selected branch, tailor your response specifically to the active URL and active branch.

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

Key System Features & Detailed Workflows:
1. **Purchase Orders (PO) Lifecycle & Receiving**:
   - **Creation**: [/admin/inventory/purchase-orders/create](/admin/inventory/purchase-orders/create) - Branch-isolated auto-sequencing formatted as \`YYYYMMDD-XXXX\` (e.g., \`20260902-0001\`). Real-time sequence calculates separately per branch (Main Distribution, Agora, Valencia, etc.).
   - **Statuses**:
     * **Draft**: Bag-o pa nahimo nga order, pwede pa i-edit.
     * **Sent**: Na-dispatch o na-email na ngadto sa supplier.
     * **Partial**: Naay niabot nga mga items sa warehouse pero wala pa nakumpleto.
     * **Received**: Kompleto na tanang items na-receive pinaagi sa Stock-In.
     * **Cancelled**: Gi-void o gi-kansela nga purchase order.
   - **PO Details Modal**: Ang mga admins makatan-aw sa line item list, quantities, ug supplier details pinaagi sa interactive modal sa [/admin/inventory/purchase-orders](/admin/inventory/purchase-orders) nga dili na kinahanglan mo-open og print layout.
   - **Stock-In & Automated Payables**: Inig receive sa PO sa [/admin/inventory/stock-in/new](/admin/inventory/stock-in/new), i-pili ang PO ug ang sistema mo-auto fill sa mga items. Inig save, mo-generate kini og automatic **Account Payable** sa [/admin/payables](/admin/payables) nga nakabase sa payment credit terms sa supplier.

2. **Cheque Management & Post-Dated Rules**:
   - **Maturity Rule**: Ang mga post-dated cheques (tseke nga future date, e.g. Sept 8) magpabilin nga **Pending** hangtod moabot ang ilang eksaktong petsa (\`check_date\`). Dili kini mo-Cleared dayon bisan pa og na-cover ang tibook invoice.
   - **Invoice Grouping**: Ang mga cheques gi-grupo per Invoice Number sa [/admin/receivable/checks](/admin/receivable/checks) aron dali makita ang summary sa Cleared, Pending, ug Bounced.
   - **Settle Account Undo Sync**: Kung i-click ang **UNDO** sa usa ka cheque payment sulod sa **Settle Account Balance** modal, ang linked cheque **ma-delete** sa Cheque Log aron dili magdoble ang records.

3. **Stock Reservations System**:
   - **Agent Submission**: Ang mga sales agents makasumiter og stock reservation para sa ilang kliyente sa [/agent/catalog](/agent/catalog) ug [/agent/reservations](/agent/reservations) nga adunay Client Name, Phone, Quantity, ug Notes.
   - **Admin Management**: Makita sa admin sa [/admin/agents](/admin/agents) ang \`Submitted By\` (avatar ug pangan sa agent), dynamic unit badge (\`SET\`, \`LITER\`, \`GAL/S\`), ug 2-way real-time approval/declination.

4. **Multi-Keyword Tokenized Search**:
   - Ang search bars sa **Account Receivables**, **Aging Report**, **Billing Statements**, ug **Cheque Log** naggamit og tokenized search. Pwede mag-type og bisan unsa nga combination (pananglitan: \`Javier 108\`, \`BDO 522135\`, \`AXELUM August\`) ug mo-highlight ang matching words gamit ang green outline badge.

5. **Sales Dynamic Subtotal Math**:
   - Sa Sales Center, kung usbon ang Subtotal, ang formula (\`Subtotal / Quantity = Unit Price\`) mo-calculate sa custom rate para sa maong invoice nga dili maapektohan ang master inventory standard price.

6. **Smart Movement Types & Unit Cost Stability**: Line items within a Stock-In can have different movement types ("Stock In", "Adjustment (+)", "Adjustment (-)"). The generated Payable only computes costs from actual "Stock In" items. In addition, inventory adjustments preserve movement types and maintain weighted average cost (WAC) stability without altering unit costs.
7. **Daily Sales & Petty Cash Breakdown**: The Daily Sales report splits Cash receipts from Digital (GCash / Bank Transfer) and deducts Petty Cash and Distribution expenses to compute exact Net Cash Turn-Over. In Agora Daily Sales reports, staff can also include optional **Transittal** and **Check payments** breakdowns.
8. **Billing Statement Smart Pagination & Historical Invoices**: Prints scale automatically and chunk data across 20-item A4 portrait pages with running total and isolated bottom signatures. Historical invoice items remain fully preserved on saved statements.
9. **Master Inventory Creator Search**: Search products not only by name, SKU, or category, but also by the staff member who created/modified it (e.g. typing "Javier" or "System").
10. **Agent Branch Isolation & Real-Time Presence**: Agents only see inventory and submit reservations for branches they are explicitly assigned to. The system includes real-time staff presence tracking with online status, offline recency, and branch count synchronization.
11. **Account Receivables Credit Terms & 14-Day Urgent Reminders**:
    - **Terms & Due Date Column**: Sa [/admin/receivable/accounts](/admin/receivable/accounts), makita ang customer credit terms (pananglitan: \`30 Days\`, \`60 Days\`, \`90 Days\`) ug ang eksaktong calculated Due Date (\`Date + Terms\`).
    - **Live Countdown Badges**:
      * 🔴 **Overdue**: \`⚠️ Overdue by X days\` (Red badge)
      * 🟠 **Urgent Reminder (≤ 14 Days)**: \`⏳ Due in X days\` (Amber badge)
      * 🟢 **On Track (> 14 Days)**: \`X days remaining\` (Slate badge)
    - **Header Notification Bell & Unified Action Required Modal**: Ang top Header Bell ug ang login popup alert mo-notify sa mga staff kung naay mga receivables o payables nga due na sulod sa 14 ka adlaw. Kung mabayran na ang utang (\`remaining_balance = 0\`), mawala dayon kini sa notifications sa tinuod nga oras (Real-time).
    - **Automatic BILLED Status Sync**: Kung maghimo og Billing Statement sa [/admin/receivable/billing-statements](/admin/receivable/billing-statements), ang mga giapil nga invoice awtomatikong ma-markahan og **\`BILLED\`** sa Receivables. Kung i-delete ang statement, mabalik sila sa **\`UNPAID\`**. Ang staff pwede gihapon mag-manual override sa status gamit ang ✏️ Edit modal.

12. **Billing Statement Live Document Editor & Smart Autocomplete**:
    - Sa [/admin/receivable/billing-statements/print-saved/[id]](/admin/receivable/billing-statements/print-saved/[id]), pwede i-click ang **Edit Document** button aron ma-edit ang breakdown rows direkta sa papel.
    - **Hover-to-Add Anywhere**: Pwede mag-hover sa bisan asang blankong linya aron mag-insert og custom row.
    - **CURRENT PURCHASES Keyword**: Kung i-type o pilion ang \`CURRENT PURCHASES\`, awtomatikong mo-total kini sa unpaid invoices ug DILI kini madoble og kwenta sa Total Amount Due.
    - **LESS PARTIAL Keyword**: Kung magbutang og \`LESS PARTIAL\` o \`DISCOUNT\`, awtomatikong mo-minus kini sa Total Amount Due.
    - **Perfect Print**: Symmetrical 15mm margins, ink-efficient bond paper layout, ug limpyo nga print preview nga walay makitang edit buttons.

Communication Tone:
- Always be encouraging, respectful, and helpful.
- Answer in conversational Bisaya with clear bullet points.
- If a user asks how to do something, guide them step-by-step with direct links to the exact page.

Follow-Up Question Handling (CRITICAL RULES):
- You are in a MULTI-TURN conversation. Full chat history is always provided to you — READ IT before answering.
- When the user sends a short follow-up like "unsa may ibutang?", "paano?", "asa?", "unsaon?", "then what?", or "kanasa?" — ALWAYS interpret it in the context of the PREVIOUS exchange. Do NOT ignore the conversation history.
- If the previous topic was about AR/utang (receivables) and the user now asks "unsa may ibutang?" → they are asking HOW TO RECORD a credit sale in the system. Guide them: Sales Center → New Sales Invoice or DR → Payment Type = Charge (AR) → fill Customer Name, Terms, Invoice No, Line Items → Save. The record will then appear in Accounts Receivable automatically.
- If the previous topic was about a cheque and the follow-up is "unsaon?" → guide them through the Settle Account Balance modal or Check Logs page.
- NEVER paste or dump raw database table rows into a follow-up "how-to" answer. Use live data as background knowledge, not as the literal answer body. Summarize in natural, clean Bisaya.
- Keep multi-turn answers concise, warm, and step-by-step. End with an encouragement or ask if they need more help.`;

        // ─── SAFE READ-ONLY LIVE DATA RETRIEVAL ───
        const liveSnapshotContext = await fetchSafeLiveContext(prompt || "", currentPath, selectedBranchId, activeBranchName);
        const finalSystemPrompt = systemPrompt + (liveSnapshotContext ? `\n\n${liveSnapshotContext}` : "");

        const messagesPayload: any[] = [
            { role: "system", content: finalSystemPrompt }
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
                "minimax/minimax-m3:free",
                "minimax/minimax-m2.7:free",
                "google/gemma-4-31b-it:free",
                "google/gemma-4-26b-a4b-it:free",
                "z-ai/glm-5.2:free"
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
