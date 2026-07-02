-- ============================================================
-- JSON Audit Vault / Delete History System
-- ============================================================

-- Create the Delete History table
CREATE TABLE IF NOT EXISTS public.delete_history_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_table TEXT NOT NULL,
    record_id TEXT NOT NULL,
    record_data JSONB NOT NULL,
    deleted_by UUID, -- Can be populated if user context is available
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Enable RLS on the logs table
ALTER TABLE public.delete_history_logs ENABLE ROW LEVEL SECURITY;

-- Allow full access for now (matching the rest of the app's anon architecture)
DROP POLICY IF EXISTS "Public Access" ON public.delete_history_logs;
CREATE POLICY "Public Access" ON public.delete_history_logs FOR ALL USING (true) WITH CHECK (true);

-- Create a generic trigger function to capture deletions
CREATE OR REPLACE FUNCTION public.log_deletion()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.delete_history_logs (
        original_table,
        record_id,
        record_data
    ) VALUES (
        TG_TABLE_NAME,
        OLD.id::TEXT,
        row_to_json(OLD)::JSONB
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Apply the trigger to relevant tables (e.g., Accounts Receivable and Check Logs)
DROP TRIGGER IF EXISTS trg_log_deletion_ar ON public.accounts_receivable;
CREATE TRIGGER trg_log_deletion_ar
AFTER DELETE ON public.accounts_receivable
FOR EACH ROW
EXECUTE FUNCTION public.log_deletion();

DROP TRIGGER IF EXISTS trg_log_deletion_checks ON public.check_logs;
CREATE TRIGGER trg_log_deletion_checks
AFTER DELETE ON public.check_logs
FOR EACH ROW
EXECUTE FUNCTION public.log_deletion();

-- Apply to Billing Statements as well
DROP TRIGGER IF EXISTS trg_log_deletion_billing ON public.billing_statements;
CREATE TRIGGER trg_log_deletion_billing
AFTER DELETE ON public.billing_statements
FOR EACH ROW
EXECUTE FUNCTION public.log_deletion();


-- ============================================================
-- Restore RPC Function
-- ============================================================
-- Safely restores a JSON log record back into its original table using dynamic SQL
CREATE OR REPLACE FUNCTION public.restore_deleted_record(log_id UUID)
RETURNS BOOLEAN AS $$
DECLARE
    log_row public.delete_history_logs%ROWTYPE;
BEGIN
    -- Fetch the deleted log
    SELECT * INTO log_row FROM public.delete_history_logs WHERE id = log_id;
    
    -- If not found, return false
    IF NOT FOUND THEN
        RETURN FALSE;
    END IF;

    -- Dynamically insert the JSON back into its original table
    -- jsonb_populate_record elegantly converts the JSONB into the exact row structure of the destination table
    EXECUTE format(
        'INSERT INTO public.%I SELECT * FROM jsonb_populate_record(null::public.%I, $1)',
        log_row.original_table, log_row.original_table
    ) USING log_row.record_data;
    
    -- Remove the log from the delete history since it is now restored
    DELETE FROM public.delete_history_logs WHERE id = log_id;
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
