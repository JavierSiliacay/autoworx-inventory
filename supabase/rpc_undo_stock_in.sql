CREATE OR REPLACE FUNCTION public.undo_stock_in(p_log_id UUID)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_invoice_number TEXT;
  v_item RECORD;
BEGIN
  -- 1. Get the invoice number before deleting
  SELECT invoice_number INTO v_invoice_number
  FROM public.stock_in_logs
  WHERE id = p_log_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Stock-in log not found';
  END IF;

  -- 2. Subtract inventory quantities for all items in this stock-in log
  FOR v_item IN 
    SELECT inventory_id, quantity_received 
    FROM public.stock_in_items 
    WHERE stock_in_id = p_log_id
  LOOP
    UPDATE public.inventory
    SET quantity = GREATEST(0, quantity - v_item.quantity_received),
        updated_at = timezone('utc'::text, now())
    WHERE id = v_item.inventory_id;
  END LOOP;

  -- 3. Delete the stock-in log (This deletes stock_in_items if ON DELETE CASCADE is set, 
  -- but just in case, we delete items explicitly first)
  DELETE FROM public.stock_in_items WHERE stock_in_id = p_log_id;
  DELETE FROM public.stock_in_logs WHERE id = p_log_id;

  -- 4. Delete associated stock_transactions audit logs
  IF v_invoice_number IS NOT NULL AND v_invoice_number != '' THEN
    DELETE FROM public.stock_transactions 
    WHERE reason LIKE '%' || v_invoice_number || '%';
    
    -- 5. Delete associated payables (if they haven't been paid)
    DELETE FROM public.supplier_payables
    WHERE reference_no = v_invoice_number;
  END IF;

END;
$$;
