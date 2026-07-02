const fs = require('fs');
const path = require('path');
const { parse } = require('csv-parse/sync');

const basePath = 'C:\\Users\\User\\.gemini\\antigravity-ide\\brain\\2648089e-2fa0-427e-8c7f-decc79b0f31a\\.system_generated\\steps';
const supabasePath = path.join(__dirname, 'supabase');

function readCsvFile(stepId) {
    const filePath = path.join(basePath, stepId, 'content.md');
    if (!fs.existsSync(filePath)) return null;
    const content = fs.readFileSync(filePath, 'utf-8');
    const parts = content.split('---');
    if (parts.length < 2) return null;
    return parse(parts[1].trim(), { columns: true, skip_empty_lines: true, relax_quotes: true, relax_column_count: true });
}

function generateSchema() {
    const sql = `
-- ============================================================
-- AutoWorx Phase 2 Schema: Financials & Master Data
-- ============================================================

CREATE TABLE IF NOT EXISTS public.customers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    address TEXT,
    contact_person TEXT,
    contact_number TEXT,
    terms TEXT
);

CREATE TABLE IF NOT EXISTS public.accounts_receivable (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE,
    invoice_no TEXT,
    customer_name TEXT,
    total_amount_due NUMERIC DEFAULT 0,
    payment_status TEXT,
    amount_collected NUMERIC DEFAULT 0,
    remaining_balance NUMERIC DEFAULT 0,
    date_collected DATE,
    remarks TEXT
);

CREATE TABLE IF NOT EXISTS public.check_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_no TEXT,
    customer_name TEXT,
    bank TEXT,
    check_no TEXT,
    check_date DATE,
    check_amount NUMERIC DEFAULT 0,
    status TEXT,
    date_posted DATE
);

CREATE TABLE IF NOT EXISTS public.accounts_payable (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    date DATE,
    invoice_no TEXT,
    supplier TEXT,
    total_invoice_amount NUMERIC DEFAULT 0,
    payment_status TEXT,
    amount_paid NUMERIC DEFAULT 0,
    remaining_balance NUMERIC DEFAULT 0,
    date_of_payment DATE,
    remarks TEXT
);

-- Enhance stock_transactions if not already done
ALTER TABLE public.stock_transactions 
ADD COLUMN IF NOT EXISTS reference_no TEXT,
ADD COLUMN IF NOT EXISTS supplier TEXT,
ADD COLUMN IF NOT EXISTS unit_price NUMERIC,
ADD COLUMN IF NOT EXISTS total_amount NUMERIC;

-- Enable RLS
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.accounts_receivable ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.check_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.accounts_payable ENABLE ROW LEVEL SECURITY;

-- Allow full access for now (update to role-based later)
DROP POLICY IF EXISTS "Public Access" ON public.customers;
CREATE POLICY "Public Access" ON public.customers FOR ALL USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "Public Access" ON public.accounts_receivable;
CREATE POLICY "Public Access" ON public.accounts_receivable FOR ALL USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "Public Access" ON public.check_logs;
CREATE POLICY "Public Access" ON public.check_logs FOR ALL USING (true) WITH CHECK (true);
DROP POLICY IF EXISTS "Public Access" ON public.accounts_payable;
CREATE POLICY "Public Access" ON public.accounts_payable FOR ALL USING (true) WITH CHECK (true);
`;
    fs.writeFileSync(path.join(supabasePath, 'schema_v3_financials.sql'), sql);
}

function parseNum(val) {
    if (!val) return 0;
    return parseFloat(val.replace(/[₱, ]/g, '')) || 0;
}

function formatDate(dateStr) {
    if (!dateStr || !dateStr.includes('/')) return 'NULL';
    const parts = dateStr.split('/');
    if (parts.length === 3) {
        let y = parts[2];
        if (y.length === 2) y = '20' + y;
        return `'${y}-${parts[1].padStart(2, '0')}-${parts[0].padStart(2, '0')}'`;
    }
    return 'NULL';
}

function safeString(val) {
    if (!val) return 'NULL';
    return "'" + val.replace(/'/g, "''") + "'";
}

function generateCustomers() {
    const data = readCsvFile('284');
    if (!data) return;
    let sql = `-- Migrate Customers\nINSERT INTO public.customers (customer_id, name, address, contact_person, contact_number, terms) VALUES\n`;
    const values = data.filter(r => r["CUSTOMER ID"] && r["CUSTOMER ID"].startsWith("CUST_")).map(r => {
        return `(${safeString(r["CUSTOMER ID"])}, ${safeString(r["CUSTOMER'S NAME"])}, ${safeString(r["ADDRESS"])}, ${safeString(r["CONTACT PERSON"])}, ${safeString(r["CONTACT NUMBER"])}, ${safeString(r["TERMS"])})`;
    });
    sql += values.join(",\n") + "\nON CONFLICT (customer_id) DO UPDATE SET name = EXCLUDED.name, address = EXCLUDED.address, terms = EXCLUDED.terms;\n";
    fs.writeFileSync(path.join(supabasePath, 'migrate_customers.sql'), sql);
}

function generateAccountsReceivable() {
    const data = readCsvFile('280');
    if (!data) return;
    let sql = `-- Migrate Accounts Receivable\nINSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, date_collected, remarks) VALUES\n`;
    const values = data.filter(r => r["CUSTOMER'S NAME"]).map(r => {
        return `(${formatDate(r["DATE"])}, ${safeString(r["INVOICE NO."])}, ${safeString(r["CUSTOMER'S NAME"])}, ${parseNum(r["TOTAL AMOUNT DUE"])}, ${safeString(r["PAYMENT STATUS"])}, ${parseNum(r["AMOUNT COLLECTED"])}, ${parseNum(r["REMAINING BALANCE"])}, ${formatDate(r["DATE COLLECTED"])}, ${safeString(r["REMARKS/PAYMENT DETAILS"])})`;
    });
    sql += values.join(",\n") + ";\n";
    fs.writeFileSync(path.join(supabasePath, 'migrate_accounts_receivable.sql'), sql);
}

function generateCheckLogs() {
    const data = readCsvFile('285');
    if (!data) return;
    let sql = `-- Migrate Check Logs\nINSERT INTO public.check_logs (invoice_no, customer_name, bank, check_no, check_date, check_amount, status, date_posted) VALUES\n`;
    const values = data.filter(r => r["CUSTOMER'S NAME"]).map(r => {
        return `(${safeString(r["INVOICE NO."])}, ${safeString(r["CUSTOMER'S NAME"])}, ${safeString(r["BANK"])}, ${safeString(r["CHECK NO."])}, ${formatDate(r["CHECK DATE"])}, ${parseNum(r["CHECK AMOUNT"])}, ${safeString(r["CHECK STATUS"])}, ${formatDate(r["DATE POSTED"])})`;
    });
    sql += values.join(",\n") + ";\n";
    fs.writeFileSync(path.join(supabasePath, 'migrate_check_logs.sql'), sql);
}

function generateAccountsPayable() {
    const data = readCsvFile('279');
    if (!data) return;
    let sql = `-- Migrate Accounts Payable\nINSERT INTO public.accounts_payable (date, invoice_no, supplier, total_invoice_amount, payment_status, amount_paid, remaining_balance, date_of_payment, remarks) VALUES\n`;
    const values = data.filter(r => r["SUPPLIER"]).map(r => {
        return `(${formatDate(r["DATE"])}, ${safeString(r["INVOICE NO."])}, ${safeString(r["SUPPLIER"])}, ${parseNum(r["TOTAL INVOICE AMOUNT"])}, ${safeString(r["PAYMENT STATUS"])}, ${parseNum(r["AMOUNT PAID"])}, ${parseNum(r["REMAINING BALANCE"])}, ${formatDate(r["DATE OF PAYMENT"])}, ${safeString(r["REMARKS/PAYMENT DETAILS"])})`;
    });
    sql += values.join(",\n") + ";\n";
    fs.writeFileSync(path.join(supabasePath, 'migrate_accounts_payable.sql'), sql);
}

function generateStockIn() {
    const data = readCsvFile('278');
    if (!data) return;
    let sql = `-- Migrate Historical Stock In\nDO $$\nDECLARE inv_id UUID;\nBEGIN\n`;
    data.filter(r => r["ITEM CODE"]).forEach(r => {
        const sku = safeString(r["ITEM CODE"]);
        const qty = parseNum(r["QTY"]);
        const typeStr = r["TYPE"] === 'STOCK IN' ? 'IN' : 'OUT'; // Adjust based on data if necessary
        sql += `  SELECT id INTO inv_id FROM public.inventory WHERE sku = ${sku} LIMIT 1;\n`;
        sql += `  IF FOUND THEN\n`;
        sql += `    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)\n`;
        sql += `    VALUES (inv_id, '${typeStr}', ${qty}, 'Historical Migration', ${safeString(r["REF. NO."])}, ${safeString(r["SUPPLIER"])}, ${parseNum(r["UNIT PRICE"])}, ${parseNum(r["TOTAL AMOUNT"])}, COALESCE(${formatDate(r["DATE"])}, timezone('utc'::text, now())));\n`;
        sql += `  END IF;\n`;
    });
    sql += `END\n$$;\n`;
    fs.writeFileSync(path.join(supabasePath, 'migrate_historical_stock_in.sql'), sql);
}

function generateInventoryCosts() {
    const data = readCsvFile('565'); // MASTER ITEM LIST with COST column
    if (!data) { console.warn('Master item list (step 565) not found - skipping cost migration'); return; }
    let sql = `-- Update Inventory Unit Costs from Master Item List\n-- Safe to run multiple times (idempotent UPDATE)\nDO $$\nDECLARE b_id UUID;\nBEGIN\n`;
    sql += `  SELECT id INTO b_id FROM public.branches WHERE name = 'Main Distribution' LIMIT 1;\n`;
    sql += `  IF b_id IS NULL THEN SELECT id INTO b_id FROM public.branches LIMIT 1; END IF;\n`;
    data.filter(r => r["ITEM CODE"] && r["COST"]).forEach(r => {
        const sku = safeString(r["ITEM CODE"]);
        const cost = parseNum(r["COST"]);
        if (!cost) return;
        sql += `  UPDATE public.inventory SET cost = ${cost} WHERE sku = ${sku} AND branch_id = b_id;\n`;
    });
    sql += `END\n$$;\n`;
    fs.writeFileSync(path.join(supabasePath, 'update_inventory_costs.sql'), sql);
    console.log('Generated update_inventory_costs.sql');
}

function normalizePaymentType(val) {
    if (!val) return 'Cash';
    const v = val.toUpperCase().trim();
    if (v === 'CHARGE') return 'Charge';
    if (v === 'DELIVERY') return 'Delivery';
    // CASH, GCASH / BANK TRANSFER, etc. all map to Cash
    return 'Cash';
}

function generateSales() {
    const data = readCsvFile('481');
    if (!data) return;
    let sql = `-- Migrate Historical Sales\nDO $$\nDECLARE inv_id UUID;\nDECLARE b_id UUID;\nBEGIN\n`;
    sql += `  SELECT id INTO b_id FROM public.branches WHERE name = 'Main Distribution' LIMIT 1;\n`;
    sql += `  IF b_id IS NULL THEN\n`;
    sql += `    SELECT id INTO b_id FROM public.branches LIMIT 1;\n`;
    sql += `  END IF;\n`;
    data.filter(r => r["ITEM CODE"]).forEach(r => {
        const sku = safeString(r["ITEM CODE"]);
        const qty = parseNum(r["QTY"]);
        const unit_price = parseNum(r["UNIT PRICE"]);
        const total = parseNum(r["TOTAL AMOUNT"]);
        const paymentType = normalizePaymentType(r["PAYMENT TYPE"]);
        sql += `  SELECT id INTO inv_id FROM public.inventory WHERE sku = ${sku} AND branch_id = b_id LIMIT 1;\n`;
        sql += `  IF FOUND THEN\n`;
        sql += `    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)\n`;
        sql += `    VALUES (COALESCE(${formatDate(r["DATE"])}, timezone('utc'::text, now())), ${safeString(r["INVOICE NO."])}, ${safeString(r["CUSTOMER'S NAME"])}, '${paymentType}', b_id, inv_id, ${qty}, ${unit_price}, 0, ${total}, 'System Migration', COALESCE(${formatDate(r["DATE"])}, timezone('utc'::text, now())));\n`;
        
        // Also log transaction
        sql += `    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)\n`;
        sql += `    VALUES (inv_id, ${qty}, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || ${safeString(r["INVOICE NO."])} || ')', COALESCE(${formatDate(r["DATE"])}, timezone('utc'::text, now())));\n`;
        sql += `  END IF;\n`;
    });
    sql += `END\n$$;\n`;
    fs.writeFileSync(path.join(supabasePath, 'migrate_historical_sales.sql'), sql);
}

try {
    generateSchema();
    generateCustomers();
    generateAccountsReceivable();
    generateCheckLogs();
    generateAccountsPayable();
    generateStockIn();
    generateSales();
    generateInventoryCosts();
    console.log("Migration scripts generated successfully in supabase folder.");
} catch (e) {
    console.error("Error generating scripts:", e);
}
