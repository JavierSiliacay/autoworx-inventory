-- ============================================================
-- AUTOWORX BRANCH FRESHEN-UP SCRIPT
-- ============================================================
-- PURPOSE:
--   Clears all transactional data for EVERY branch
--   EXCEPT "Main Distribution" and "Isuzu".
--
-- PRESERVED (untouched for ALL branches):
--   inventory, customers, suppliers, branches, users/profiles
--
-- PROTECTED BRANCHES (transactions untouched):
--   Main Distribution
--   Isuzu  (staff not yet in office)
--
-- CLEARED (Kauswagan, Agora, Valencia ColourSmile, Valencia Distribution):
--   sales, stock_in_logs, stock_in_items, stock_transactions
--   accounts_receivable, receivable_payments, check_logs
--   billing_statements, billing_statement_items
--   payables, payable_payments (filtered via sales.branch_id)
--   purchase_orders, purchase_order_items
--   agent_reservations, delete_history_logs
-- NOTE: accounts_payable has NO branch_id column and belongs to Main
--       Distribution only -- it is left untouched.
--
-- WARNING: THIS IS IRREVERSIBLE. TAKE A SUPABASE BACKUP FIRST.
-- ============================================================

DO $$
DECLARE
  v_main_branch_id  UUID;
  v_isuzu_branch_id UUID;
BEGIN

  -- Step 0: Resolve protected branch IDs
  SELECT id INTO v_main_branch_id
  FROM public.branches
  WHERE name ILIKE '%main distribution%'
  LIMIT 1;

  SELECT id INTO v_isuzu_branch_id
  FROM public.branches
  WHERE name ILIKE '%isuzu%'
  LIMIT 1;

  IF v_main_branch_id IS NULL THEN
    RAISE EXCEPTION 'Could not find Main Distribution branch. Aborting.';
  END IF;

  IF v_isuzu_branch_id IS NULL THEN
    RAISE EXCEPTION 'Could not find Isuzu branch. Aborting.';
  END IF;

  RAISE NOTICE 'Main Distribution branch ID : %', v_main_branch_id;
  RAISE NOTICE 'Isuzu branch ID             : %', v_isuzu_branch_id;
  RAISE NOTICE 'Both branches will be LEFT INTACT.';
  RAISE NOTICE 'Clearing transactional data for all OTHER branches...';


  -- Step 1: Agent Reservations
  -- agent_reservations uses branch_name (TEXT), not branch_id UUID
  DELETE FROM public.agent_reservations
  WHERE branch_name NOT ILIKE '%main distribution%'
    AND branch_name NOT ILIKE '%isuzu%';

  RAISE NOTICE '  agent_reservations cleared.';


  -- Step 2: Billing Statement Items (child of billing_statements)
  -- billing_statements has its own branch_id (schema_v7)
  -- billing_statement_audit_logs was DROPPED in schema_v6 - does not exist
  DELETE FROM public.billing_statement_items
  WHERE billing_statement_id IN (
    SELECT id FROM public.billing_statements
    WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  RAISE NOTICE '  billing_statement_items cleared.';


  -- Step 3: Billing Statements
  DELETE FROM public.billing_statements
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  billing_statements cleared.';


  -- Step 4: Receivable Payments (child of AR)
  DELETE FROM public.receivable_payments
  WHERE ar_id IN (
    SELECT id FROM public.accounts_receivable
    WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  RAISE NOTICE '  receivable_payments cleared.';


  -- Step 5: Check Logs
  DELETE FROM public.check_logs
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  check_logs cleared.';


  -- Step 6: Accounts Receivable
  DELETE FROM public.accounts_receivable
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  accounts_receivable cleared.';


  -- Step 7: Payable Payments then Payables
  -- payables has no branch_id — filter via sale_id -> sales.branch_id
  DELETE FROM public.payable_payments
  WHERE payable_id IN (
    SELECT p.id FROM public.payables p
    JOIN public.sales s ON p.sale_id = s.id
    WHERE s.branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  DELETE FROM public.payables
  WHERE sale_id IN (
    SELECT id FROM public.sales
    WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  RAISE NOTICE '  payables and payable_payments cleared.';


  -- Step 8: Sales
  DELETE FROM public.sales
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  sales cleared.';


  -- Step 9: Stock In Items then Stock In Logs
  DELETE FROM public.stock_in_items
  WHERE stock_in_id IN (
    SELECT id FROM public.stock_in_logs
    WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  DELETE FROM public.stock_in_logs
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  stock_in_logs and stock_in_items cleared.';


  -- Step 10: Stock Transactions
  DELETE FROM public.stock_transactions
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  stock_transactions cleared.';


  -- Step 11: Accounts Payable
  -- accounts_payable has NO branch_id column. It belongs to Main Distribution
  -- only and must NOT be touched. Skipping intentionally.
  RAISE NOTICE '  accounts_payable skipped (no branch_id — Main Distribution only).';


  -- Step 12: Purchase Order Items then Purchase Orders
  DELETE FROM public.purchase_order_items
  WHERE po_id IN (
    SELECT id FROM public.purchase_orders
    WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id)
  );

  DELETE FROM public.purchase_orders
  WHERE branch_id NOT IN (v_main_branch_id, v_isuzu_branch_id);

  RAISE NOTICE '  purchase_orders and purchase_order_items cleared.';


  -- Step 13: Delete History Logs
  DELETE FROM public.delete_history_logs;

  RAISE NOTICE '  delete_history_logs cleared.';


  -- SUMMARY
  RAISE NOTICE '';
  RAISE NOTICE '============================================================';
  RAISE NOTICE 'BRANCH FRESHEN-UP COMPLETE!';
  RAISE NOTICE '  Main Distribution data      : UNTOUCHED';
  RAISE NOTICE '  Isuzu data                  : UNTOUCHED';
  RAISE NOTICE '  Master Inventory (all)      : UNTOUCHED';
  RAISE NOTICE '  Customers List (all)        : UNTOUCHED';
  RAISE NOTICE '  Suppliers List (all)        : UNTOUCHED';
  RAISE NOTICE '  Transactional data (others) : CLEARED';
  RAISE NOTICE '============================================================';

END $$;
