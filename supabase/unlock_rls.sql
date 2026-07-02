-- Helper function to unlock a table
CREATE OR REPLACE FUNCTION unlock_table(table_name text)
RETURNS void AS $$
BEGIN
    -- Drop the authenticated policy we created
    EXECUTE format('DROP POLICY IF EXISTS "Authenticated Access" ON public.%I', table_name);
    
    -- Re-create the Public Access policy
    EXECUTE format('
        CREATE POLICY "Public Access" ON public.%I 
        FOR ALL USING (true) WITH CHECK (true);
    ', table_name);
END;
$$ LANGUAGE plpgsql;

-- Apply to all relevant tables
SELECT unlock_table('inventory');
SELECT unlock_table('sales');
SELECT unlock_table('branches');
SELECT unlock_table('customers');
SELECT unlock_table('accounts_receivable');
SELECT unlock_table('billing_statements');
SELECT unlock_table('billing_statement_items');
SELECT unlock_table('check_logs');
SELECT unlock_table('receivable_payments');
SELECT unlock_table('purchase_orders');
SELECT unlock_table('stock_in_logs');
SELECT unlock_table('suppliers');
SELECT unlock_table('users');

-- Drop the helper function
DROP FUNCTION unlock_table(text);
