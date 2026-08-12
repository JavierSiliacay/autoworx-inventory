-- ============================================================
-- Sync ISUZU Sales to Receivables & Billing Statements
-- ============================================================

DO $$ 
DECLARE
  v_isuzu_branch_id UUID;
  v_billing_id UUID;
BEGIN
  -- 1. Get ISUZU branch ID
  SELECT id INTO v_isuzu_branch_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;
  IF v_isuzu_branch_id IS NULL THEN
    RAISE EXCEPTION 'Could not find ISUZU branch.';
  END IF;

  -- 2. Aggregate ISUZU Sales and Insert into Accounts Receivable
  -- Group all sales with 'CHARGE' by their invoice_no
  INSERT INTO public.accounts_receivable (date, invoice_no, customer_name, total_amount_due, payment_status, amount_collected, remaining_balance, branch_id)
  SELECT 
    MIN(date) as date,
    invoice_no,
    'NORTH-MIN AUTO DEALERSHIP INC.' as customer_name,
    SUM(total_amount) as total_amount_due,
    'UNPAID' as payment_status,
    0 as amount_collected,
    SUM(total_amount) as remaining_balance,
    v_isuzu_branch_id
  FROM public.sales
  WHERE branch_id = v_isuzu_branch_id 
    AND payment_type ILIKE '%charge%'
    AND invoice_no NOT IN (SELECT invoice_no FROM public.accounts_receivable WHERE branch_id = v_isuzu_branch_id)
  GROUP BY invoice_no;

  -- 3. Create a Billing Statement Header for NORTH-MIN AUTO DEALERSHIP INC.
  SELECT id INTO v_billing_id FROM public.billing_statements WHERE customer_name = 'NORTH-MIN AUTO DEALERSHIP INC.' AND branch_id = v_isuzu_branch_id LIMIT 1;

  IF v_billing_id IS NULL THEN
    INSERT INTO public.billing_statements (customer_name, status, branch_id, prepared_by)
    VALUES ('NORTH-MIN AUTO DEALERSHIP INC.', 'Finalized', v_isuzu_branch_id, 'RHONABYL MAGALLANES')
    RETURNING id INTO v_billing_id;
  ELSE
    -- If it already exists, forcefully update the prepared_by field in case it was created incorrectly
    UPDATE public.billing_statements 
    SET prepared_by = 'RHONABYL MAGALLANES' 
    WHERE id = v_billing_id;
  END IF;

  -- 4. Link all ISUZU receivables to the Billing Statement
  INSERT INTO public.billing_statement_items (billing_statement_id, ar_id, invoice_no, date_purchased, original_amount, amount_due)
  SELECT 
    v_billing_id,
    ar.id,
    ar.invoice_no,
    ar.date,
    ar.total_amount_due,
    ar.remaining_balance
  FROM public.accounts_receivable ar
  WHERE ar.branch_id = v_isuzu_branch_id
    AND ar.id NOT IN (SELECT ar_id FROM public.billing_statement_items WHERE billing_statement_id = v_billing_id);

END $$;
