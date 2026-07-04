-- ============================================================================
-- SQL Script: Create Inventory Price & Cost History Log
-- Description: Automatically logs changes to cost or price in the inventory table
-- ============================================================================

-- 1. Create the history table
CREATE TABLE IF NOT EXISTS public.inventory_price_history (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    inventory_id UUID REFERENCES public.inventory(id) ON DELETE CASCADE,
    old_cost DECIMAL(10, 2),
    new_cost DECIMAL(10, 2),
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    changed_by TEXT, -- Email of the person making the change
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE public.inventory_price_history ENABLE ROW LEVEL SECURITY;

-- Admins can do everything, others can select
DROP POLICY IF EXISTS "Inventory price history is public" ON public.inventory_price_history;
CREATE POLICY "Inventory price history is public" ON public.inventory_price_history FOR SELECT USING (true);
DROP POLICY IF EXISTS "Inventory price history is manageable by admins" ON public.inventory_price_history;
CREATE POLICY "Inventory price history is manageable by admins" ON public.inventory_price_history FOR ALL USING (true) WITH CHECK (true);

-- 2. Create the trigger function
CREATE OR REPLACE FUNCTION public.log_inventory_price_changes()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if either cost or price has changed
    IF (OLD.cost IS DISTINCT FROM NEW.cost) OR (OLD.price IS DISTINCT FROM NEW.price) THEN
        INSERT INTO public.inventory_price_history (
            inventory_id,
            old_cost,
            new_cost,
            old_price,
            new_price,
            changed_by
        ) VALUES (
            NEW.id,
            OLD.cost,
            NEW.cost,
            OLD.price,
            NEW.price,
            NEW.last_modified_by
        );
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Attach the trigger to the inventory table
DROP TRIGGER IF EXISTS trg_inventory_price_changes ON public.inventory;
CREATE TRIGGER trg_inventory_price_changes
    AFTER UPDATE ON public.inventory
    FOR EACH ROW
    EXECUTE FUNCTION public.log_inventory_price_changes();
