
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
