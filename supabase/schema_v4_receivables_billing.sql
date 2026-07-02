-- ============================================================
-- AutoWorx Phase 3 Schema: Receivables & Billing Statements
-- ============================================================

-- 1. Receivable Payments (Audit Trail for Cash & Cheques)
CREATE TABLE IF NOT EXISTS public.receivable_payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ar_id UUID NOT NULL REFERENCES public.accounts_receivable(id) ON DELETE CASCADE,
    amount NUMERIC NOT NULL DEFAULT 0,
    payment_method TEXT NOT NULL CHECK (payment_method IN ('Cash', 'Cheque')),
    check_log_id UUID REFERENCES public.check_logs(id) ON DELETE SET NULL,
    status TEXT NOT NULL CHECK (status IN ('Completed', 'Pending', 'Bounced', 'Cancelled', 'Cleared')),
    remarks TEXT,
    created_by TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Billing Statements
CREATE TABLE IF NOT EXISTS public.billing_statements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ar_id UUID NOT NULL REFERENCES public.accounts_receivable(id) ON DELETE CASCADE,
    due_date DATE,
    manual_adjustment NUMERIC DEFAULT 0,
    remarks TEXT,
    status TEXT DEFAULT 'Draft' CHECK (status IN ('Draft', 'Finalized')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 3. Billing Statement Audit Logs
CREATE TABLE IF NOT EXISTS public.billing_statement_audit_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    billing_statement_id UUID NOT NULL REFERENCES public.billing_statements(id) ON DELETE CASCADE,
    changed_by TEXT NOT NULL,
    field_changed TEXT NOT NULL,
    old_value TEXT,
    new_value TEXT,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Link Check Logs to AR
ALTER TABLE public.check_logs 
ADD COLUMN IF NOT EXISTS ar_id UUID REFERENCES public.accounts_receivable(id) ON DELETE CASCADE;

-- Enable RLS
ALTER TABLE public.receivable_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.billing_statements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.billing_statement_audit_logs ENABLE ROW LEVEL SECURITY;

-- Allow full access for now (update to role-based later)
DROP POLICY IF EXISTS "Public Access" ON public.receivable_payments;
CREATE POLICY "Public Access" ON public.receivable_payments FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public Access" ON public.billing_statements;
CREATE POLICY "Public Access" ON public.billing_statements FOR ALL USING (true) WITH CHECK (true);

DROP POLICY IF EXISTS "Public Access" ON public.billing_statement_audit_logs;
CREATE POLICY "Public Access" ON public.billing_statement_audit_logs FOR ALL USING (true) WITH CHECK (true);

-- ============================================================
-- Sync Trigger Logic
-- ============================================================

-- Create function to update AR balances automatically
CREATE OR REPLACE FUNCTION public.sync_ar_balance()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        IF NEW.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected + NEW.amount,
                remaining_balance = remaining_balance - NEW.amount
            WHERE id = NEW.ar_id;
        END IF;
    ELSIF TG_OP = 'UPDATE' THEN
        -- If status changes from Completed/Pending to Bounced/Cancelled
        IF OLD.status IN ('Completed', 'Pending', 'Cleared') AND NEW.status IN ('Bounced', 'Cancelled') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected - NEW.amount,
                remaining_balance = remaining_balance + NEW.amount
            WHERE id = NEW.ar_id;
        -- If status changes from Bounced/Cancelled to Cleared/Pending/Completed
        ELSIF OLD.status IN ('Bounced', 'Cancelled') AND NEW.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected + NEW.amount,
                remaining_balance = remaining_balance - NEW.amount
            WHERE id = NEW.ar_id;
        END IF;
    ELSIF TG_OP = 'DELETE' THEN
        IF OLD.status IN ('Completed', 'Pending', 'Cleared') THEN
            UPDATE public.accounts_receivable
            SET amount_collected = amount_collected - OLD.amount,
                remaining_balance = remaining_balance + OLD.amount
            WHERE id = OLD.ar_id;
        END IF;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_ar_balance ON public.receivable_payments;
CREATE TRIGGER trg_sync_ar_balance
AFTER INSERT OR UPDATE OR DELETE ON public.receivable_payments
FOR EACH ROW
EXECUTE FUNCTION public.sync_ar_balance();

-- Create function to sync Check Logs to Receivable Payments automatically
CREATE OR REPLACE FUNCTION public.sync_check_log_payment()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' AND NEW.ar_id IS NOT NULL THEN
        INSERT INTO public.receivable_payments (ar_id, amount, payment_method, check_log_id, status, created_at)
        VALUES (NEW.ar_id, NEW.check_amount, 'Cheque', NEW.id, NEW.status, COALESCE(NEW.date_posted, timezone('utc'::text, now())));
    ELSIF TG_OP = 'UPDATE' THEN
        -- If AR ID changed or status changed, sync to receivable payments
        IF NEW.ar_id IS NOT NULL THEN
            UPDATE public.receivable_payments
            SET amount = NEW.check_amount, status = NEW.status
            WHERE check_log_id = NEW.id;
        END IF;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_sync_check_log_payment ON public.check_logs;
CREATE TRIGGER trg_sync_check_log_payment
AFTER INSERT OR UPDATE ON public.check_logs
FOR EACH ROW
EXECUTE FUNCTION public.sync_check_log_payment();
