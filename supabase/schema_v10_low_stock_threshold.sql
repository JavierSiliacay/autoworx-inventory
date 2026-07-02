-- Add low_stock_threshold column to inventory
ALTER TABLE public.inventory
ADD COLUMN IF NOT EXISTS low_stock_threshold NUMERIC DEFAULT 5.0;
