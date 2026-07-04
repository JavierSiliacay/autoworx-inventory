-- ========================================================
-- OPTIMIZE DATABASE: Add 'Cancelled' to Sales Payment Types
-- ========================================================
-- This script updates the check constraint on the sales table
-- to allow 'Cancelled' as a valid payment_type.

ALTER TABLE public.sales DROP CONSTRAINT IF EXISTS sales_payment_type_check;

ALTER TABLE public.sales
  ADD CONSTRAINT sales_payment_type_check 
  CHECK (payment_type IN ('Cash', 'GCash', 'Bank Transfer', 'Charge', 'Delivery', 'Cancelled'));
