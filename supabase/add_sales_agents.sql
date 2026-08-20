-- Create sales_agents table
CREATE TABLE IF NOT EXISTS public.sales_agents (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    branch_id UUID REFERENCES public.branches(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS on sales_agents
ALTER TABLE public.sales_agents ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow read access to all authenticated users for sales_agents"
    ON public.sales_agents FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Allow write access to admins for sales_agents"
    ON public.sales_agents FOR ALL
    TO authenticated
    USING (EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid()::text AND role IN ('developer', 'owner', 'manager')));

-- Add sales_agent column to sales table
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='sales' AND column_name='sales_agent') THEN
    ALTER TABLE public.sales ADD COLUMN sales_agent TEXT;
  END IF;
END $$;

-- Update rpc_edit_sale to accept sales_agent
CREATE OR REPLACE FUNCTION public.edit_sale(
    p_sale_id UUID,
    p_date DATE,
    p_invoice_no TEXT,
    p_customer_name TEXT,
    p_payment_type TEXT,
    p_sales_agent TEXT,
    p_items JSONB,
    p_performed_by UUID
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_old_sale RECORD;
    v_old_item RECORD;
    v_new_item JSONB;
    v_total_amount DECIMAL := 0;
BEGIN
    -- 1. Get old sale data
    SELECT * INTO v_old_sale FROM public.sales WHERE id = p_sale_id;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Sale not found';
    END IF;

    -- 2. Reverse inventory for old items
    FOR v_old_item IN SELECT * FROM public.sale_items WHERE sale_id = p_sale_id LOOP
        UPDATE public.inventory
        SET quantity = quantity + v_old_item.quantity
        WHERE id = v_old_item.item_id;
    END LOOP;

    -- 3. Delete old items
    DELETE FROM public.sale_items WHERE sale_id = p_sale_id;

    -- 4. Calculate new total and insert new items, while updating inventory
    FOR v_new_item IN SELECT * FROM jsonb_array_elements(p_items) LOOP
        v_total_amount := v_total_amount + (v_new_item->>'subtotal')::DECIMAL;
        
        -- Insert new item
        INSERT INTO public.sale_items (sale_id, item_id, quantity, unit_price, subtotal)
        VALUES (
            p_sale_id,
            (v_new_item->>'item_id')::UUID,
            (v_new_item->>'quantity')::DECIMAL,
            (v_new_item->>'unit_price')::DECIMAL,
            (v_new_item->>'subtotal')::DECIMAL
        );

        -- Deduct inventory
        UPDATE public.inventory
        SET quantity = quantity - (v_new_item->>'quantity')::DECIMAL
        WHERE id = (v_new_item->>'item_id')::UUID;
    END LOOP;

    -- 5. Update sales record
    UPDATE public.sales
    SET 
        date = p_date,
        invoice_no = p_invoice_no,
        customer_name = p_customer_name,
        payment_type = p_payment_type,
        sales_agent = p_sales_agent,
        total_amount = v_total_amount,
        updated_at = timezone('utc'::text, now())
    WHERE id = p_sale_id;

    -- 6. Log the edit action
    INSERT INTO public.activity_logs (action_type, module_type, record_id, performed_by, remarks, branch_id)
    VALUES (
        'UPDATE',
        'sales',
        p_sale_id,
        p_performed_by,
        'Sale edited (Total: ' || v_total_amount || ', Agent: ' || COALESCE(p_sales_agent, 'None') || ')',
        v_old_sale.branch_id
    );
END;
$$;
