-- Migration: Add unit_cost to sales table to track historical cost at time of sale
ALTER TABLE public.sales ADD COLUMN IF NOT EXISTS unit_cost NUMERIC NOT NULL DEFAULT 0;

-- Update existing records to match inventory cost as a starting point (optional but good for consistency)
UPDATE public.sales s
SET unit_cost = i.cost
FROM public.inventory i
WHERE s.item_id = i.id AND s.unit_cost = 0;
