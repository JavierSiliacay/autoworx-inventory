-- ========================================================
-- OPTIMIZE DATABASE: RPC for Bulk Edit Stock In
-- ========================================================
-- This function replaces sequential client-side HTTP requests
-- with a single atomic transaction for editing a stock-in.

CREATE OR REPLACE FUNCTION public.edit_stock_in(
  p_log_id uuid,
  p_log_payload jsonb,
  p_old_items_payload jsonb,
  p_new_items_payload jsonb,
  p_user_id uuid
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_old_item jsonb;
  v_new_item jsonb;
  v_inventory_id uuid;
  v_branch_id uuid;
BEGIN
  v_branch_id := (p_log_payload->>'branch_id')::uuid;

  -- 1. Revert Old Inventory (Subtract old quantities)
  FOR v_old_item IN SELECT * FROM jsonb_array_elements(p_old_items_payload)
  LOOP
    IF (v_old_item->>'inventory_id') IS NOT NULL AND (v_old_item->>'inventory_id') != '' THEN
      UPDATE public.inventory
      SET quantity = GREATEST(0, quantity - (v_old_item->>'quantity_received')::decimal)
      WHERE id = (v_old_item->>'inventory_id')::uuid;
    END IF;
  END LOOP;

  -- 2. Delete old stock-in items and transactions
  DELETE FROM public.stock_in_items WHERE stock_in_id = p_log_id;
  
  IF (p_log_payload->>'old_invoice_number') IS NOT NULL AND (p_log_payload->>'old_invoice_number') != '' THEN
    DELETE FROM public.stock_transactions 
    WHERE type = 'IN' 
    AND reason ILIKE '%' || (p_log_payload->>'old_invoice_number') || '%';
  END IF;

  -- 3. Update stock_in_logs Header
  UPDATE public.stock_in_logs
  SET 
    invoice_number = p_log_payload->>'invoice_number',
    date_received = (p_log_payload->>'date_received')::timestamp,
    supplier_id = (p_log_payload->>'supplier_id')::uuid,
    total_amount = (p_log_payload->>'total_amount')::decimal
  WHERE id = p_log_id;

  -- 4. Insert new stock_in_items and Apply new inventory quantities
  FOR v_new_item IN SELECT * FROM jsonb_array_elements(p_new_items_payload)
  LOOP
    v_inventory_id := (v_new_item->>'inventory_id')::uuid;

    -- Insert stock_in_item
    INSERT INTO public.stock_in_items (
      stock_in_id, inventory_id, quantity_received, unit_cost
    ) VALUES (
      p_log_id,
      v_inventory_id,
      (v_new_item->>'quantity_received')::decimal,
      (v_new_item->>'unit_cost')::decimal
    );

    -- Update inventory quantities and latest cost
    UPDATE public.inventory
    SET quantity = quantity + (v_new_item->>'quantity_received')::decimal,
        cost = (v_new_item->>'unit_cost')::decimal,
        updated_at = timezone('utc'::text, now())
    WHERE id = v_inventory_id;

    -- Insert stock_transactions audit log
    INSERT INTO public.stock_transactions (
      inventory_id, branch_id, type, quantity, unit_price, reason
    ) VALUES (
      v_inventory_id,
      v_branch_id,
      'IN',
      (v_new_item->>'quantity_received')::decimal,
      (v_new_item->>'unit_cost')::decimal,
      'Stock In Edited: ' || (p_log_payload->>'invoice_number')
    );
  END LOOP;

END;
$$;
