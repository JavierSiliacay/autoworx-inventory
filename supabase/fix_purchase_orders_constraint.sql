-- Update Purchase Orders unique constraint so sequence is isolated per branch
DO $$
BEGIN
  -- Drop existing global unique constraint on po_number if it exists
  IF EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'purchase_orders_po_number_key' 
    AND conrelid = 'public.purchase_orders'::regclass
  ) THEN
    ALTER TABLE public.purchase_orders DROP CONSTRAINT purchase_orders_po_number_key;
    RAISE NOTICE 'Dropped global unique constraint purchase_orders_po_number_key.';
  END IF;

  -- Add branch-isolated composite unique constraint (po_number, branch_id)
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'purchase_orders_po_number_branch_key' 
    AND conrelid = 'public.purchase_orders'::regclass
  ) THEN
    ALTER TABLE public.purchase_orders ADD CONSTRAINT purchase_orders_po_number_branch_key UNIQUE (po_number, branch_id);
    RAISE NOTICE 'Added branch-isolated unique constraint (po_number, branch_id).';
  END IF;
END $$;
