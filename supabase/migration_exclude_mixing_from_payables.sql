-- ========================================================
-- MIGRATION: Exclude Mixing Station / Mixing Suppliers from Automated Payables
-- ========================================================
-- When performing Stock-In or editing Stock-In records and selecting
-- "MIXING STATION", "TRANSFER TO MIXING AREA", or any supplier with "MIXING",
-- it represents an internal stock movement or mixing batch rather than an
-- external vendor debt. Thus, automated records in `supplier_payables` are skipped.

-- 1. Update public.process_stock_in
CREATE OR REPLACE FUNCTION public.process_stock_in(
  log_payload jsonb,
  items_payload jsonb
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_log_id uuid;
  v_item jsonb;
  v_inventory_id uuid;
  v_po_id uuid;
  v_supplier_name text;
  v_supplier_due_days int;
  v_payable_amount decimal := 0;
  v_curr_qty decimal;
  v_curr_cost decimal;
  v_qty_in decimal;
  v_line_total decimal;
  v_new_qty decimal;
  v_final_cost decimal;
  v_movement_type text;
BEGIN
  -- 1. Parse PO ID if it exists (and is not empty string)
  IF (log_payload->>'reference_po_id') IS NOT NULL AND (log_payload->>'reference_po_id') != '' THEN
    v_po_id := (log_payload->>'reference_po_id')::uuid;
  ELSE
    v_po_id := NULL;
  END IF;

  -- 2. Insert into stock_in_logs
  INSERT INTO public.stock_in_logs (
    reference_po_id,
    branch_id,
    supplier_id,
    invoice_number,
    date_received,
    received_by,
    receipt_image_url,
    total_amount
  ) VALUES (
    v_po_id,
    (log_payload->>'branch_id')::uuid,
    (log_payload->>'supplier_id')::uuid,
    log_payload->>'invoice_number',
    (log_payload->>'date_received')::timestamp,
    log_payload->>'received_by',
    log_payload->>'receipt_image_url',
    (log_payload->>'total_amount')::decimal
  ) RETURNING id INTO v_log_id;

  -- 3. Process each item in the array
  FOR v_item IN SELECT * FROM jsonb_array_elements(items_payload)
  LOOP
    -- Handle potentially empty string for inventory_id
    IF (v_item->>'inventory_id') IS NOT NULL AND (v_item->>'inventory_id') != '' THEN
      v_inventory_id := (v_item->>'inventory_id')::uuid;
    ELSE
      v_inventory_id := NULL;
    END IF;

    IF v_inventory_id IS NULL THEN
      -- Create new inventory record
      INSERT INTO public.inventory (
        product_name, category, quantity, cost, price, branch_id, last_modified_by
      ) VALUES (
        v_item->>'product_name',
        COALESCE(v_item->>'category', 'Paint'),
        0, -- initial quantity
        (v_item->>'unit_cost')::decimal,
        COALESCE((v_item->>'price')::decimal, (v_item->>'unit_cost')::decimal * 1.3),
        (log_payload->>'branch_id')::uuid,
        log_payload->>'received_by'
      ) RETURNING id INTO v_inventory_id;
    END IF;

    INSERT INTO public.stock_in_items (
      stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type
    ) VALUES (
      v_log_id,
      v_inventory_id,
      (v_item->>'quantity_received')::decimal,
      (v_item->>'unit_cost')::decimal,
      COALESCE((v_item->>'total_amount')::decimal, (v_item->>'quantity_received')::decimal * (v_item->>'unit_cost')::decimal),
      COALESCE(v_item->>'movement_type', 'Stock In')
    );

    -- Calculate payable amount (only Stock In items)
    IF COALESCE(v_item->>'movement_type', 'Stock In') = 'Stock In' THEN
      v_payable_amount := v_payable_amount + COALESCE((v_item->>'total_amount')::decimal, (v_item->>'quantity_received')::decimal * (v_item->>'unit_cost')::decimal);
    END IF;

    -- Retrieve current stock and cost for Weighted Average Cost calculation
    SELECT quantity, cost INTO v_curr_qty, v_curr_cost
    FROM public.inventory
    WHERE id = v_inventory_id;

    v_movement_type := COALESCE(v_item->>'movement_type', 'Stock In');
    v_qty_in := (v_item->>'quantity_received')::decimal;
    v_line_total := COALESCE((v_item->>'total_amount')::decimal, v_qty_in * (v_item->>'unit_cost')::decimal);
    v_new_qty := COALESCE(v_curr_qty, 0) + v_qty_in;

    -- Compute Weighted Average Cost:
    IF v_qty_in > 0 THEN
      IF COALESCE(v_curr_qty, 0) <= 0 THEN
        v_final_cost := v_line_total / NULLIF(v_qty_in, 0);
      ELSE
        v_final_cost := ( (COALESCE(v_curr_qty, 0) * COALESCE(v_curr_cost, 0)) + v_line_total ) / NULLIF(v_new_qty, 0);
      END IF;
    ELSE
      v_final_cost := COALESCE(v_curr_cost, (v_item->>'unit_cost')::decimal);
    END IF;

    v_final_cost := ROUND(COALESCE(v_final_cost, (v_item->>'unit_cost')::decimal), 4);

    UPDATE public.inventory
    SET quantity = v_new_qty,
        cost = v_final_cost,
        last_modified_by = log_payload->>'received_by',
        updated_at = timezone('utc'::text, now())
    WHERE id = v_inventory_id;

    INSERT INTO public.stock_transactions (
      inventory_id, branch_id, type, quantity, unit_price, reason
    ) VALUES (
      v_inventory_id,
      (log_payload->>'branch_id')::uuid,
      'IN',
      v_qty_in,
      (v_item->>'unit_cost')::decimal,
      v_movement_type || ': ' || COALESCE(log_payload->>'invoice_number', 'N/A')
    );
  END LOOP;

  -- 4. Update PO status if reference_po_id exists
  IF v_po_id IS NOT NULL THEN
    UPDATE public.purchase_orders
    SET status = 'received'
    WHERE id = v_po_id;
  END IF;

  -- 5. Automatically create Supplier Payable if applicable
  SELECT name, COALESCE(due_days, 0) INTO v_supplier_name, v_supplier_due_days
  FROM public.suppliers
  WHERE id = (log_payload->>'supplier_id')::uuid;

  -- Exclude 'INVENTORY%', 'BEGINNING BALANCE%', and any supplier with '%MIXING%'
  IF v_supplier_name IS NOT NULL 
     AND v_supplier_name NOT ILIKE 'INVENTORY%' 
     AND v_supplier_name NOT ILIKE 'BEGINNING BALANCE%' 
     AND v_supplier_name NOT ILIKE '%MIXING%'
     AND v_payable_amount > 0 THEN
    INSERT INTO public.supplier_payables (
      supplier_name,
      reference_no,
      branch_id,
      amount_due,
      paid_amount,
      balance,
      due_date,
      status,
      notes,
      created_by
    ) VALUES (
      v_supplier_name,
      log_payload->>'invoice_number',
      (log_payload->>'branch_id')::uuid,
      v_payable_amount,
      0,
      v_payable_amount,
      ((log_payload->>'date_received')::timestamp + (v_supplier_due_days || ' days')::interval),
      'Pending',
      'Auto-generated from Stock-In',
      log_payload->>'received_by'
    );
  END IF;

END;
$$;


-- 2. Update public.edit_stock_in
CREATE OR REPLACE FUNCTION public.edit_stock_in(
  p_log_id uuid,
  p_log_payload jsonb,
  p_old_items_payload jsonb,
  p_new_items_payload jsonb,
  p_user_id text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_item jsonb;
  v_inventory_id uuid;
  v_qty_diff decimal;
  v_cost decimal;
  v_line_total decimal;
  v_curr_qty decimal;
  v_curr_cost decimal;
  v_new_qty decimal;
  v_final_cost decimal;
  v_payable_amount decimal := 0;
  v_supplier_name text;
  v_supplier_due_days int;
BEGIN
  -- 1. Update stock_in_logs entry
  UPDATE public.stock_in_logs
  SET 
    supplier_id = (p_log_payload->>'supplier_id')::uuid,
    invoice_number = p_log_payload->>'invoice_number',
    date_received = (p_log_payload->>'date_received')::timestamp,
    total_amount = (p_log_payload->>'total_amount')::decimal,
    updated_at = timezone('utc'::text, now())
  WHERE id = p_log_id;

  -- 2. Revert Old Items Impact on inventory
  FOR v_item IN SELECT * FROM jsonb_array_elements(p_old_items_payload)
  LOOP
    v_inventory_id := (v_item->>'inventory_id')::uuid;
    IF v_inventory_id IS NOT NULL THEN
      UPDATE public.inventory
      SET quantity = quantity - (v_item->>'quantity_received')::decimal
      WHERE id = v_inventory_id;
    END IF;
  END LOOP;

  -- 3. Delete Old stock_in_items
  DELETE FROM public.stock_in_items
  WHERE stock_in_id = p_log_id;

  -- 4. Insert New Items & Re-apply Weighted Average Cost & Stock
  FOR v_item IN SELECT * FROM jsonb_array_elements(p_new_items_payload)
  LOOP
    v_inventory_id := (v_item->>'inventory_id')::uuid;
    v_cost := (v_item->>'unit_cost')::decimal;
    v_line_total := COALESCE((v_item->>'total_amount')::decimal, (v_item->>'quantity_received')::decimal * v_cost);

    INSERT INTO public.stock_in_items (
      stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type
    ) VALUES (
      p_log_id,
      v_inventory_id,
      (v_item->>'quantity_received')::decimal,
      v_cost,
      v_line_total,
      COALESCE(v_item->>'movement_type', 'Stock In')
    );

    IF COALESCE(v_item->>'movement_type', 'Stock In') = 'Stock In' THEN
      v_payable_amount := v_payable_amount + v_line_total;
    END IF;

    IF v_inventory_id IS NOT NULL THEN
      SELECT quantity, cost INTO v_curr_qty, v_curr_cost
      FROM public.inventory
      WHERE id = v_inventory_id;

      v_qty_diff := (v_item->>'quantity_received')::decimal;
      v_new_qty := COALESCE(v_curr_qty, 0) + v_qty_diff;

      IF v_qty_diff > 0 THEN
        IF COALESCE(v_curr_qty, 0) <= 0 THEN
          v_final_cost := v_line_total / NULLIF(v_qty_diff, 0);
        ELSE
          v_final_cost := ( (COALESCE(v_curr_qty, 0) * COALESCE(v_curr_cost, 0)) + v_line_total ) / NULLIF(v_new_qty, 0);
        END IF;
      ELSE
        v_final_cost := COALESCE(v_curr_cost, v_cost);
      END IF;

      v_final_cost := ROUND(COALESCE(v_final_cost, v_cost), 4);

      UPDATE public.inventory
      SET quantity = v_new_qty,
          cost = v_final_cost,
          updated_at = timezone('utc'::text, now())
      WHERE id = v_inventory_id;
    END IF;
  END LOOP;

  -- 5. Synchronize Supplier Payable if it exists and is not 'INVENTORY', 'BEGINNING BALANCE', or 'MIXING'
  SELECT name, COALESCE(due_days, 0) INTO v_supplier_name, v_supplier_due_days
  FROM public.suppliers
  WHERE id = (p_log_payload->>'supplier_id')::uuid;

  IF v_supplier_name IS NOT NULL 
     AND v_supplier_name NOT ILIKE 'INVENTORY%' 
     AND v_supplier_name NOT ILIKE 'BEGINNING BALANCE%' 
     AND v_supplier_name NOT ILIKE '%MIXING%' THEN
    IF v_payable_amount > 0 THEN
      UPDATE public.supplier_payables
      SET 
        supplier_name = v_supplier_name,
        reference_no = p_log_payload->>'invoice_number',
        amount_due = v_payable_amount,
        balance = v_payable_amount - paid_amount,
        due_date = ((p_log_payload->>'date_received')::timestamp + (v_supplier_due_days || ' days')::interval)
      WHERE reference_no = p_log_payload->>'old_invoice_number';
    ELSE
      UPDATE public.supplier_payables
      SET 
        supplier_name = v_supplier_name,
        reference_no = p_log_payload->>'invoice_number',
        amount_due = 0,
        balance = 0 - paid_amount,
        due_date = ((p_log_payload->>'date_received')::timestamp + (v_supplier_due_days || ' days')::interval)
      WHERE reference_no = p_log_payload->>'old_invoice_number';
    END IF;
  ELSE
    DELETE FROM public.supplier_payables
    WHERE reference_no = p_log_payload->>'old_invoice_number';
  END IF;

END;
$$;
