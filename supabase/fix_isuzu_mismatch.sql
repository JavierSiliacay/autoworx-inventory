-- Fix Stock Value Mismatch (Precision Rounding)
ALTER TABLE public.inventory ALTER COLUMN quantity TYPE numeric;
ALTER TABLE public.stock_transactions ALTER COLUMN quantity TYPE numeric;
ALTER TABLE public.stock_in_items ALTER COLUMN quantity_received TYPE numeric;
ALTER TABLE public.sales ALTER COLUMN quantity TYPE numeric;
ALTER TABLE public.transactions ALTER COLUMN quantity TYPE numeric;

-- Update the 4 items that had exactly 3 decimal places in the Excel sheet
UPDATE public.inventory 
SET quantity = 1.375 
WHERE sku = 'MEG3901-4L' 
  AND branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1);

UPDATE public.inventory 
SET quantity = 28.375 
WHERE sku = 'NAX3974' 
  AND branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1);

UPDATE public.inventory 
SET quantity = 13.875 
WHERE sku = 'NAX/EXTMIX' 
  AND branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1);

UPDATE public.inventory 
SET quantity = 1.375 
WHERE sku = 'MEG3001-4L' 
  AND branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1);

-- Fix Total Purchases Mismatch
-- Change "type" from 'IN' to 'ADJUSTMENT' for suppliers that aren't actual purchases 
-- so they are excluded from the "Total Purchases" sum, exactly matching Excel.

-- First, allow 'ADJUSTMENT' as a valid type
ALTER TABLE public.stock_transactions DROP CONSTRAINT IF EXISTS stock_transactions_type_check;
ALTER TABLE public.stock_transactions ADD CONSTRAINT stock_transactions_type_check CHECK (type IN ('IN', 'OUT', 'ADJUSTMENT'));

UPDATE public.stock_transactions st
SET type = 'ADJUSTMENT'
FROM public.stock_in_logs sl
JOIN public.suppliers sup ON sl.supplier_id = sup.id
WHERE st.reason = 'Historical Stock In: ' || sl.invoice_number
  AND st.branch_id = (SELECT id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1)
  AND sup.name IN (
    'INVENTORY BALANCE', 
    'FROM STOCKS', 
    'FOR EXPENSE', 
    'ADDITIONAL BALANCE', 
    'UNKNOWN SUPPLIER'
  );
