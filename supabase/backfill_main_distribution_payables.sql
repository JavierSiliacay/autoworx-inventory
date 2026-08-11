-- ========================================================
-- BACKFILL SCRIPT: Migrate existing Stock-Ins to Payables
-- ========================================================
-- This script safely copies existing stock-ins from Main Distribution
-- into the supplier_payables table. It ignores 'INVENTORY' and 'BEGINNING BALANCE'.
-- It also checks to make sure it doesn't create duplicates.

INSERT INTO public.supplier_payables (
    supplier_name,
    reference_no,
    branch_id,
    amount_due,
    paid_amount,
    balance,
    due_date,
    status,
    notes,
    created_by
)
SELECT
    s.name as supplier_name,
    sil.invoice_number as reference_no,
    sil.branch_id,
    sil.total_amount as amount_due,
    0 as paid_amount,
    sil.total_amount as balance,
    (sil.date_received + (COALESCE(s.due_days, 0) || ' days')::interval) as due_date,
    'Pending' as status,
    'Backfilled from existing Stock-In' as notes,
    COALESCE(sil.received_by, 'System') as created_by
FROM public.stock_in_logs sil
JOIN public.suppliers s ON s.id = sil.supplier_id
JOIN public.branches b ON b.id = sil.branch_id
WHERE b.name ILIKE '%Main Distribution%'
  AND s.name NOT ILIKE 'INVENTORY%'
  AND s.name NOT ILIKE 'BEGINNING BALANCE%'
  -- Ensures we do not insert duplicates if they were already auto-generated recently
  AND NOT EXISTS (
    SELECT 1 FROM public.supplier_payables sp
    WHERE sp.reference_no = sil.invoice_number
  );
