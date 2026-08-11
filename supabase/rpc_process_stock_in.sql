-- ========================================================
-- OPTIMIZE DATABASE: RPC for Bulk Stock In
-- ========================================================
-- This function replaces a loop of 10+ network requests per item 
-- with a single, atomic database transaction.

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

    -- Insert stock_in_items
    INSERT INTO public.stock_in_items (
      stock_in_id, inventory_id, quantity_received, unit_cost, total_cost
    ) VALUES (
      v_log_id,
      v_inventory_id,
      (v_item->>'quantity_received')::decimal,
      (v_item->>'unit_cost')::decimal,
      COALESCE((v_item->>'total_amount')::decimal, (v_item->>'quantity_received')::decimal * (v_item->>'unit_cost')::decimal)
    );

    -- Update inventory quantities and latest cost
    UPDATE public.inventory
    SET quantity = quantity + (v_item->>'quantity_received')::decimal,
        cost = (v_item->>'unit_cost')::decimal,
        last_modified_by = log_payload->>'received_by',
        updated_at = timezone('utc'::text, now())
    WHERE id = v_inventory_id;

    -- Insert stock_transactions audit log
    INSERT INTO public.stock_transactions (
      inventory_id, branch_id, type, quantity, unit_price, reason
    ) VALUES (
      v_inventory_id,
      (log_payload->>'branch_id')::uuid,
      'IN',
      (v_item->>'quantity_received')::decimal,
      COALESCE((v_item->>'total_amount')::decimal / NULLIF((v_item->>'quantity_received')::decimal, 0), (v_item->>'unit_cost')::decimal),
      'Stock In: ' || (log_payload->>'invoice_number')
    );
  END LOOP;

  -- 4. Update PO status if reference_po_id exists
  IF v_po_id IS NOT NULL THEN
    UPDATE public.purchase_orders
    SET status = 'received'
    WHERE id = v_po_id;
  END IF;

  -- 5. Automatically create Supplier Payable if applicable
  -- Fetch supplier name and due_days
  SELECT name, COALESCE(due_days, 0) INTO v_supplier_name, v_supplier_due_days
  FROM public.suppliers
  WHERE id = (log_payload->>'supplier_id')::uuid;

  -- Check if supplier name does NOT start with 'INVENTORY' or 'BEGINNING BALANCE'
  IF v_supplier_name IS NOT NULL AND v_supplier_name NOT ILIKE 'INVENTORY%' AND v_supplier_name NOT ILIKE 'BEGINNING BALANCE%' THEN
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
      (log_payload->>'total_amount')::decimal,
      0,
      (log_payload->>'total_amount')::decimal,
      ((log_payload->>'date_received')::timestamp + (v_supplier_due_days || ' days')::interval),
      'Pending',
      'Auto-generated from Stock-In',
      log_payload->>'received_by'
    );
  END IF;

END;
$$;
