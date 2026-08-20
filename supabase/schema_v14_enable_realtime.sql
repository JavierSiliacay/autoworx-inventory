DO $$
DECLARE
    t text;
    tables_to_add text[] := ARRAY[
        'inventory',
        'transactions',
        'customers',
        'users',
        'branches',
        'stock_transactions',
        'accounts_receivable',
        'check_logs',
        'accounts_payable',
        'receivable_payments',
        'billing_statements',
        'inventory_price_history'
    ];
BEGIN
    FOREACH t IN ARRAY tables_to_add
    LOOP
        BEGIN
            EXECUTE format('ALTER PUBLICATION supabase_realtime ADD TABLE %I;', t);
        EXCEPTION
            WHEN duplicate_object THEN
                -- Ignore error if table is already in the publication
                RAISE NOTICE 'Table % is already in supabase_realtime publication, skipping.', t;
        END;
    END LOOP;
END;
$$;
