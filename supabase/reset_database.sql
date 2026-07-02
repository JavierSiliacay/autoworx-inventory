-- ============================================================
-- RESET SCRIPT
-- This script safely removes all migrated data so you can 
-- run the migration scripts exactly ONCE to get accurate numbers.
-- ============================================================

DO $$
BEGIN
  -- 1. Delete all sales from the system migration
  DELETE FROM public.sales WHERE performed_by = 'System Migration';

  -- 2. Delete all stock-in related data
  DELETE FROM public.stock_in_items;
  DELETE FROM public.stock_in_logs;
  
  -- 3. Delete all transaction history
  DELETE FROM public.stock_transactions;
  DELETE FROM public.transactions;

  -- 4. Clear inventory so it can be recreated cleanly by the migration
  DELETE FROM public.inventory;

  RAISE NOTICE 'Database reset completed. You can now run the migration scripts again.';
END $$;
