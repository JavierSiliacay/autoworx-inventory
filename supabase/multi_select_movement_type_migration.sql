-- Run this directly in your Supabase SQL Editor

-- 1. Add movement_type to stock_in_items
ALTER TABLE public.stock_in_items 
ADD COLUMN IF NOT EXISTS movement_type varchar(50) DEFAULT 'Stock In';

-- 2. Backfill existing records (they were all generic or derived from log)
-- We will just default them to 'Stock In' which the DEFAULT constraint already handles, but if we wanted to be perfectly precise, we could backfill based on the parent stock_in_logs invoice_number prefix.
UPDATE public.stock_in_items sii
SET movement_type = 
  CASE 
    WHEN sil.invoice_number LIKE '[ADJ+]%' THEN 'Adjustment (+)'
    WHEN sil.invoice_number LIKE '[ADJ-]%' THEN 'Adjustment (-)'
    ELSE 'Stock In'
  END
FROM public.stock_in_logs sil
WHERE sii.stock_in_id = sil.id;
