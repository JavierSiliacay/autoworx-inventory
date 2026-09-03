CREATE OR REPLACE FUNCTION public.undo_stock_in(p_log_id UUID)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_invoice_number TEXT;
  v_item           RECORD;
  v_curr_qty       DECIMAL;
  v_curr_cost      DECIMAL;
  v_qty_in         DECIMAL;  -- the qty that was added (negative for Adj-)
  v_line_total     DECIMAL;  -- the monetary value that was blended in
  v_old_qty        DECIMAL;  -- qty BEFORE the original stock-in
  v_restored_cost  DECIMAL;  -- cost to restore after reversal
BEGIN
  -- 1. Get the invoice number before deleting
  SELECT invoice_number INTO v_invoice_number
  FROM public.stock_in_logs
  WHERE id = p_log_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Stock-in log not found';
  END IF;

  -- 2. Reverse qty AND restore Weighted Average Cost for each item
  FOR v_item IN
    SELECT
      si.inventory_id,
      si.quantity_received,
      si.unit_cost,
      COALESCE(si.total_cost, si.quantity_received * si.unit_cost) AS line_total,
      COALESCE(si.movement_type, 'Stock In') AS movement_type
    FROM public.stock_in_items si
    WHERE si.stock_in_id = p_log_id
      AND si.inventory_id IS NOT NULL
  LOOP
    -- Fetch current live inventory state
    SELECT quantity, cost
    INTO v_curr_qty, v_curr_cost
    FROM public.inventory
    WHERE id = v_item.inventory_id;

    v_qty_in     := v_item.quantity_received;  -- signed
    v_line_total := v_item.line_total;          -- signed (negative for Adj-)

    -- The quantity that existed BEFORE this stock-in was applied
    v_old_qty := COALESCE(v_curr_qty, 0) - v_qty_in;

    -- Reverse the WAC:
    -- If this was an Adjustment (-) reduction (v_qty_in <= 0 or movement_type = 'Adjustment (-)'),
    -- the reduction never changed the unit cost, so reversing it must KEEP the current unit cost!
    IF v_qty_in <= 0 OR v_item.movement_type = 'Adjustment (-)' THEN
      v_restored_cost := COALESCE(v_curr_cost, v_item.unit_cost);
    ELSIF v_old_qty > 0 THEN
      -- Regular Stock In / Adj (+) reversal:
      -- new_cost = (old_value + line_total) / new_qty => old_cost = (current_value - line_total) / old_qty
      v_restored_cost := ROUND(
        ( (COALESCE(v_curr_qty, 0) * COALESCE(v_curr_cost, 0)) - v_line_total )
        / v_old_qty,
        4
      );
      -- Clamp to >= 0 to guard against floating-point drift
      v_restored_cost := GREATEST(0, v_restored_cost);
    ELSE
      -- Qty returns to 0 or below — reset cost to 0
      v_restored_cost := 0;
    END IF;

    UPDATE public.inventory
    SET quantity   = GREATEST(0, v_old_qty),
        cost       = v_restored_cost,
        updated_at = timezone('utc'::text, now())
    WHERE id = v_item.inventory_id;
  END LOOP;

  -- 3. Delete the stock-in items then the log
  DELETE FROM public.stock_in_items WHERE stock_in_id = p_log_id;
  DELETE FROM public.stock_in_logs  WHERE id = p_log_id;

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
