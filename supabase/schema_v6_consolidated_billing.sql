-- ============================================================
-- AutoWorx Phase 3 Schema: Consolidated Billing Statements
-- ============================================================

-- Drop the old tables (User confirmed this is safe as it's dummy data)
DROP TABLE IF EXISTS public.billing_statement_audit_logs CASCADE;
DROP TABLE IF EXISTS public.billing_statements CASCADE;

-- 1. Billing Statements (Header Table)
CREATE TABLE IF NOT EXISTS public.billing_statements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    statement_number TEXT NOT NULL UNIQUE, -- e.g., BS-0001
    customer_name TEXT NOT NULL,
    address TEXT,
    terms TEXT,
    po_number TEXT,
    prepared_by TEXT,
    noted_by TEXT,
    statement_date DATE DEFAULT CURRENT_DATE,
    due_date DATE,
    manual_adjustment NUMERIC DEFAULT 0,
    remarks TEXT,
    status TEXT DEFAULT 'Draft' CHECK (status IN ('Draft', 'Finalized', 'Void')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Billing Statement Items (Line Items mapping to AR)
CREATE TABLE IF NOT EXISTS public.billing_statement_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    billing_statement_id UUID NOT NULL REFERENCES public.billing_statements(id) ON DELETE CASCADE,
    ar_id UUID NOT NULL REFERENCES public.accounts_receivable(id) ON DELETE RESTRICT,
    invoice_no TEXT NOT NULL,
    date_purchased DATE NOT NULL,
    original_amount NUMERIC NOT NULL,
    amount_due NUMERIC NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Sequence for Statement Numbers
CREATE SEQUENCE IF NOT EXISTS billing_statement_seq START 1;

CREATE OR REPLACE FUNCTION generate_billing_statement_number()
RETURNS TRIGGER AS $$
BEGIN
    NEW.statement_number := 'BS-' || LPAD(nextval('billing_statement_seq')::TEXT, 4, '0');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_generate_bs_number
BEFORE INSERT ON public.billing_statements
FOR EACH ROW
WHEN (NEW.statement_number IS NULL OR NEW.statement_number = '')
EXECUTE FUNCTION generate_billing_statement_number();

-- Enable RLS
ALTER TABLE public.billing_statements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.billing_statement_items ENABLE ROW LEVEL SECURITY;

-- Allow full access for now (update to role-based later)
DROP POLICY IF EXISTS "Public Access" ON public.billing_statements;
CREATE POLICY "Public Access" ON public.billing_statements FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public Access" ON public.billing_statement_items;
CREATE POLICY "Public Access" ON public.billing_statement_items FOR ALL USING (true) WITH CHECK (true);
