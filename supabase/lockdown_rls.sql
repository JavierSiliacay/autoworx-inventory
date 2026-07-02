-- ============================================================
-- Lock Down Supabase Row Level Security (RLS)
-- Restricts all data access to authenticated NextAuth users
-- ============================================================

-- Function to recreate policies for a specific table
CREATE OR REPLACE FUNCTION lockdown_table(table_name text) RETURNS void AS $$
BEGIN
    -- Enable RLS just in case it's off
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', table_name);
    
    -- Drop the insecure "Public Access" policy if it exists
    EXECUTE format('DROP POLICY IF EXISTS "Public Access" ON public.%I;', table_name);
    
    -- Create the secure policy ensuring auth.role() = 'authenticated'
    EXECUTE format('
        CREATE POLICY "Authenticated Access" ON public.%I 
        FOR ALL USING (auth.role() = ''authenticated'') WITH CHECK (auth.role() = ''authenticated'');
    ', table_name);
END;
$$ LANGUAGE plpgsql;

-- Apply to all relevant tables
SELECT lockdown_table('inventory');
SELECT lockdown_table('sales');
SELECT lockdown_table('branches');
SELECT lockdown_table('customers');
SELECT lockdown_table('accounts_receivable');
SELECT lockdown_table('billing_statements');
SELECT lockdown_table('billing_statement_items');
SELECT lockdown_table('check_logs');
SELECT lockdown_table('receivable_payments');
SELECT lockdown_table('purchase_orders');
SELECT lockdown_table('stock_in_logs');
SELECT lockdown_table('suppliers');
SELECT lockdown_table('users');

-- Drop the helper function
DROP FUNCTION lockdown_table(text);
