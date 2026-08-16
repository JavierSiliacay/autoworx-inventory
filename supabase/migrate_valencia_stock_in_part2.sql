-- Migration for Valencia Stock In Part 2
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  DECLARE
    v_item_id UUID;
    v_supplier_id UUID;
    v_stock_in_id UUID;
  BEGIN

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-250' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-250', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 705 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-40-1L' OR product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'AC-40-1L', v_branch_id, 0, 141) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 141);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 141, 'Migration: ' || 'UNREF-250');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-251' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-251', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-90-1L' OR product_name = 'RAW SIENNA ACRY-COLOR AC-90 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAW SIENNA ACRY-COLOR AC-90 1L DAVIES', 'AC-90-1L', v_branch_id, 0, 115) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 115);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 115, 'Migration: ' || 'UNREF-251');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-252' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-252', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 715.9 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTAC-3117-1L' OR product_name = 'PERMANENT ORANGE ACRY-COLOR PWTAC-3117 1L WELCOAT PREMIUM') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PERMANENT ORANGE ACRY-COLOR PWTAC-3117 1L WELCOAT PREMIUM', 'PWTAC-3117-1L', v_branch_id, 0, 143.18) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 143.18);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 143.18, 'Migration: ' || 'UNREF-252');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-253' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-253', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 721 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-30-1L' OR product_name = 'THALO GREEN ACRY-COLOR AC-30 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('THALO GREEN ACRY-COLOR AC-30 1L DAVIES', 'AC-30-1L', v_branch_id, 0, 103) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 103);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 103, 'Migration: ' || 'UNREF-253');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-254' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-254', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 206 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-20-1L' OR product_name = 'THALO BLUE ACRY-COLOR AC-20 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'AC-20-1L', v_branch_id, 0, 103) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 103);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 103, 'Migration: ' || 'UNREF-254');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-255' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-255', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 432 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-11-1L' OR product_name = 'VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES', 'AC-11-1L', v_branch_id, 0, 108) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 108);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 108, 'Migration: ' || 'UNREF-255');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-256' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-256', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 627.6 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTAC-6517-1L' OR product_name = 'BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT', 'PWTAC-6517-1L', v_branch_id, 0, 104.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 104.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 104.6, 'Migration: ' || 'UNREF-256');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-257' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-257', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 627.6 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTAC-4317-1L' OR product_name = 'RAW UMBER ACRY-COLOR PWTAC-4317 1L WELCOAT PREMIUM') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAW UMBER ACRY-COLOR PWTAC-4317 1L WELCOAT PREMIUM', 'PWTAC-4317-1L', v_branch_id, 0, 104.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 104.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 104.6, 'Migration: ' || 'UNREF-257');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-258' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-258', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 627.6 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTAC-4617-1L' OR product_name = 'BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT', 'PWTAC-4617-1L', v_branch_id, 0, 104.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 104.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 104.6, 'Migration: ' || 'UNREF-258');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-259' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-259', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 432 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-10-1L' OR product_name = 'TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'AC-10-1L', v_branch_id, 0, 108) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 108);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 108, 'Migration: ' || 'UNREF-259');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-260' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-260', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5304 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FRANELLA' OR product_name = 'FRANELLA CLOTH 1YARD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('FRANELLA CLOTH 1YARD', 'FRANELLA', v_branch_id, 0, 68) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 78, 68);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 78, 68, 'Migration: ' || 'UNREF-260');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-261' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-261', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3480 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1160, 'Migration: ' || 'UNREF-261');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-262' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-262', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3589 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 194, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 194, 18.5, 'Migration: ' || 'UNREF-262');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-263' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-263', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MTX' OR product_name = 'SUPRA GLOSS (TURTLE WAX)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SUPRA GLOSS (TURTLE WAX)', 'MTX', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 700);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 700, 'Migration: ' || 'UNREF-263');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-264' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-264', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9350 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXUMAGENTA-4L' OR product_name = 'NIPPON EXTREME MAGENTA 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME MAGENTA 4L', 'NXUMAGENTA-4L', v_branch_id, 0, 1870) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1870);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1870, 'Migration: ' || 'UNREF-264');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-265' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-265', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXUCINQVIO-4L' OR product_name = 'NIPPON EXTREME CINQUASA VIOLET 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME CINQUASA VIOLET 4L', 'NXUCINQVIO-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1630, 'Migration: ' || 'UNREF-265');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-266' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-266', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7210 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 515) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 14, 515);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 14, 515, 'Migration: ' || 'UNREF-266');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-267' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-267', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 441 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-LTR' OR product_name = 'NIPPON METAL PRIMER RED OXIDE LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'NMPREDOX-LTR', v_branch_id, 0, 147) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 147);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 147, 'Migration: ' || 'UNREF-267');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-268' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-268', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-GAL' OR product_name = 'NIPPON CLEAR GLOSS VARNISH GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON CLEAR GLOSS VARNISH GAL', 'NCGVARNISH-GAL', v_branch_id, 0, 1460) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1460);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1460, 'Migration: ' || 'UNREF-268');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-269' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-269', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1347 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-LTR' OR product_name = 'NIPPON CLEAR GLOSS VARNISH LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'NCGVARNISH-LTR', v_branch_id, 0, 449) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 449);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 449, 'Migration: ' || 'UNREF-269');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-270' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-270', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7778.08 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 55.36) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 140.5, 55.36);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 140.5, 55.36, 'Migration: ' || 'UNREF-270');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-271' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-271', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 42.4) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 42.4);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 42.4, 'Migration: ' || 'UNREF-271');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-272' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-272', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2952.18 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 44.73) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 66, 44.73);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 66, 44.73, 'Migration: ' || 'UNREF-272');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-273' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-273', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5015.355 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 39.03) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 128.5, 39.03);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 128.5, 39.03, 'Migration: ' || 'UNREF-273');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-274' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-274', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 128 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 32, 'Migration: ' || 'UNREF-274');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-275' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-275', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 252 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 28, 'Migration: ' || 'UNREF-275');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-276' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-276', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8121.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 439, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 439, 18.5, 'Migration: ' || 'UNREF-276');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-277' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-277', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9196 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 836) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 836);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 836, 'Migration: ' || 'UNREF-277');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-278' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-278', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 496 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 62) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 62);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 62, 'Migration: ' || 'UNREF-278');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-279' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-279', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6294 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEEKBOS-4L' OR product_name = 'EL KAPITAN A & B 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EL KAPITAN A & B 4L', 'MEEKBOS-4L', v_branch_id, 0, 2098) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2098);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2098, 'Migration: ' || 'UNREF-279');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-280' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-280', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1188 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'RUGBY' OR product_name = 'RUGBY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RUGBY', 'RUGBY', v_branch_id, 0, 66) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 66);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 66, 'Migration: ' || 'UNREF-280');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-281' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-281', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2502 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 834) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 834);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 834, 'Migration: ' || 'UNREF-281');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-282' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-282', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5439 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSFWEW-GAL' OR product_name = 'BOYSEN FWE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN FWE WHITE GAL', 'BSFWEW-GAL', v_branch_id, 0, 777) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 777);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 777, 'Migration: ' || 'UNREF-282');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-283' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-283', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4320 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-701-4L' OR product_name = 'FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L', 'B-701-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.75, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.75, 640, 'Migration: ' || 'UNREF-283');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-284' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-284', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8811 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1705' OR product_name = 'ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'B-1705', v_branch_id, 0, 979) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 979);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 979, 'Migration: ' || 'UNREF-284');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-285' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-285', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1437 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1750' OR product_name = 'REDUCER ACRYTEX B-1750 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('REDUCER ACRYTEX B-1750 BOYSEN 4L', 'B-1750', v_branch_id, 0, 479) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 479);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 479, 'Migration: ' || 'UNREF-285');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-286' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-286', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1047 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-337' OR product_name = 'COTTA ELASTOMERIC WATER FROOFING PAINT R0S-SR-337 SUN ROOF RAIN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('COTTA ELASTOMERIC WATER FROOFING PAINT R0S-SR-337 SUN ROOF RAIN 4L', 'ROS-SR-337', v_branch_id, 0, 523.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 523.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 523.5, 'Migration: ' || 'UNREF-286');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-287' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-287', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1732.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-182' OR product_name = 'BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L', 'ROS-SR-182', v_branch_id, 0, 577.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 577.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 577.6, 'Migration: ' || 'UNREF-287');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-288' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-288', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2776.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-EF-1130' OR product_name = 'BLACK ELASTO FLOOR ROS-EF-1130 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BLACK ELASTO FLOOR ROS-EF-1130 RAIN OR SHINE 4L', 'ROS-EF-1130', v_branch_id, 0, 925.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 925.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 925.5, 'Migration: ' || 'UNREF-288');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-289' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-289', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1155.2 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-183' OR product_name = 'SAMAR BEIGE SUN ROOF ROS-SR-183 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SAMAR BEIGE SUN ROOF ROS-SR-183 RAIN OR SHINE 4L', 'ROS-SR-183', v_branch_id, 0, 577.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 577.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 577.6, 'Migration: ' || 'UNREF-289');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-290' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-290', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1344.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-100' OR product_name = 'WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L', 'ROS-SR-100', v_branch_id, 0, 672.4) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 672.4);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 672.4, 'Migration: ' || 'UNREF-290');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-291' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-291', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 595.7 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-777' OR product_name = 'BITTER SWEET SUN ROOF ROS-SR-777 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BITTER SWEET SUN ROOF ROS-SR-777 RAIN OR SHINE 4L', 'ROS-SR-777', v_branch_id, 0, 595.7) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 595.7);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 595.7, 'Migration: ' || 'UNREF-291');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-292' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-292', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3045 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-823' OR product_name = 'VIBRANT RUBY ROS-823 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('VIBRANT RUBY ROS-823 RAIN OR SHINE 4L', 'ROS-823', v_branch_id, 0, 1015) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1015);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1015, 'Migration: ' || 'UNREF-292');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-293' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-293', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 681.4 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-238' OR product_name = 'PISTACHIO ELASTOMERIC WATER FROOFING PAINT ROS-238 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PISTACHIO ELASTOMERIC WATER FROOFING PAINT ROS-238 RAIN OR SHINE 4L', 'ROS-238', v_branch_id, 0, 681.4) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 681.4);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 681.4, 'Migration: ' || 'UNREF-293');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-294' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-294', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3305.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-353' OR product_name = 'LIGHT BEIGE ROS-353 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LIGHT BEIGE ROS-353 RAIN OR SHINE 4L', 'ROS-353', v_branch_id, 0, 661.1) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 661.1);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 661.1, 'Migration: ' || 'UNREF-294');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-295' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-295', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3871.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-678' OR product_name = 'GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L', 'ROS-678', v_branch_id, 0, 645.3) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 645.3);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 645.3, 'Migration: ' || 'UNREF-295');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-296' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-296', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1534.2 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-529' OR product_name = 'GOLD RUSH ROS-529 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GOLD RUSH ROS-529 RAIN OR SHINE 4L', 'ROS-529', v_branch_id, 0, 767.1) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 767.1);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 767.1, 'Migration: ' || 'UNREF-296');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-297' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-297', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 661.1 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-367' OR product_name = 'CANDY TUFF ROS-367 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'ROS-367', v_branch_id, 0, 661.1) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 661.1);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 661.1, 'Migration: ' || 'UNREF-297');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-298' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-298', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1983.3 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-350' OR product_name = 'AMBER ROSE ROS-350 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('AMBER ROSE ROS-350 RAIN OR SHINE 4L', 'ROS-350', v_branch_id, 0, 661.1) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 661.1);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 661.1, 'Migration: ' || 'UNREF-298');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-299' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-299', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1920 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 160, 'Migration: ' || 'UNREF-299');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-300' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-300', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOTHALOBLU-4L' OR product_name = 'TIMEOUT ACRYLIC THALO BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'TOTHALOBLU-4L', v_branch_id, 0, 1060) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1060);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1060, 'Migration: ' || 'UNREF-300');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-301' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-301', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 50, 'Migration: ' || 'UNREF-301');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-302' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-302', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 33444 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 27.87, 1200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 27.87, 1200, 'Migration: ' || 'UNREF-302');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-303' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-303', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3071 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 166, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 166, 18.5, 'Migration: ' || 'UNREF-303');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-304' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-304', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2109 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 114, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 114, 18.5, 'Migration: ' || 'UNREF-304');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-305' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-305', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1715 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 49, 35);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 49, 35, 'Migration: ' || 'UNREF-305');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-306' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-306', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2170 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 62) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 35, 62);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 35, 62, 'Migration: ' || 'UNREF-306');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-307' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-307', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV-5-525-4L' OR product_name = 'DAVIES LIQUID TILE GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'DV-5-525-4L', v_branch_id, 0, 1095) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1095);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1095, 'Migration: ' || 'UNREF-307');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-308' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-308', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1017.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 55, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 55, 18.5, 'Migration: ' || 'UNREF-308');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-309' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-309', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 736 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B1490-1L' OR product_name = 'BOYSEN LTC LAMP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN LTC LAMP BLACK 1L', 'B1490-1L', v_branch_id, 0, 92) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 92);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 92, 'Migration: ' || 'UNREF-309');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-310' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-310', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 760 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TC-21-1/4L' OR product_name = 'DAVIES OTC THALO BLUE 1/4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES OTC THALO BLUE 1/4L', 'TC-21-1/4L', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 95, 'Migration: ' || 'UNREF-310');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-311' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-311', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 95 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TC-33-1/4L' OR product_name = 'DAVIES OTC THALO GREEN 1/4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES OTC THALO GREEN 1/4L', 'TC-33-1/4L', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 95, 'Migration: ' || 'UNREF-311');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-312' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-312', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5580 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'OTH10AD-1L' OR product_name = 'NIPPON FLATTENING AGENT PASTE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLATTENING AGENT PASTE 1L', 'OTH10AD-1L', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 620);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 620, 'Migration: ' || 'UNREF-312');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-313' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-313', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1332 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWAC-7242-1/4L' OR product_name = 'WELCOAT ACRY-TILE TINTING COLOR PHTHALO BLUE PWAC-7242') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO BLUE PWAC-7242', 'PWAC-7242-1/4L', v_branch_id, 0, 111) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 111);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 111, 'Migration: ' || 'UNREF-313');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-314' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-314', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1206 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWAC-9042-1L' OR product_name = 'WELCOAT ACRY-TILE TINTING COLOR PHTHALO GREEN PWAC-9042') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO GREEN PWAC-9042', 'PWAC-9042-1L', v_branch_id, 0, 402) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 402);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 402, 'Migration: ' || 'UNREF-314');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-315' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-315', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 922 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWAC-2142-1L' OR product_name = 'WELCOAT ACRY-TILE TINTING COLOR PERMANENT RED PWAC-2142') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT ACRY-TILE TINTING COLOR PERMANENT RED PWAC-2142', 'PWAC-2142-1L', v_branch_id, 0, 461) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 461);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 461, 'Migration: ' || 'UNREF-315');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-316' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-316', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1692 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWAC-5042-1/4L' OR product_name = 'WELCOAT ACRY-TILE TINTING COLOR HANSA YELLOW PWAC-5042') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT ACRY-TILE TINTING COLOR HANSA YELLOW PWAC-5042', 'PWAC-5042-1/4L', v_branch_id, 0, 141) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 141);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 141, 'Migration: ' || 'UNREF-316');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-317' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-317', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1230 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-791' OR product_name = 'BOYSEN PERMACOAT FLAT LATEX BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN PERMACOAT FLAT LATEX BLACK 4L', 'B-791', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 615, 'Migration: ' || 'UNREF-317');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-318' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-318', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1197 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TCLT-11-1L' OR product_name = 'DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L', 'TCLT-11-1L', v_branch_id, 0, 399) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 399);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 399, 'Migration: ' || 'UNREF-318');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-319' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-319', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1197 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TCLT-60-1L' OR product_name = 'DAVIES LIQUID-TILE TINTING COLOR BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES LIQUID-TILE TINTING COLOR BLACK 1L', 'TCLT-60-1L', v_branch_id, 0, 399) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 399);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 399, 'Migration: ' || 'UNREF-319');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-320' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-320', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 475 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TC-60-1/4L' OR product_name = 'DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L', 'TC-60-1/4L', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 95, 'Migration: ' || 'UNREF-320');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-321' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-321', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 162 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 18) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 18);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 18, 'Migration: ' || 'UNREF-321');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-322' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-322', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1635 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1711' OR product_name = 'BOYSEN ACRYTEX CAST 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX CAST 4L', 'B-1711', v_branch_id, 0, 545) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 545);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 545, 'Migration: ' || 'UNREF-322');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-323' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-323', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4590 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-710' OR product_name = 'BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'B-710', v_branch_id, 0, 765) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 765);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 765, 'Migration: ' || 'UNREF-323');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-324' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-324', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4384 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1710' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'B-1710', v_branch_id, 0, 1096) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1096);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1096, 'Migration: ' || 'UNREF-324');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-325' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-325', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7380 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 820) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 820);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 820, 'Migration: ' || 'UNREF-325');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-326' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-326', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDG-4L' OR product_name = 'PLATONE QDE GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE GREEN 4L', 'PLQDG-4L', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-326');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-327' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-327', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BPAD' OR product_name = 'BUFFING PAD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BUFFING PAD', 'BPAD', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 650, 'Migration: ' || 'UNREF-327');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-328' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-328', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WQD1150-4L' OR product_name = 'WELCOAT REGULAR QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'WQD1150-4L', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 570);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 570, 'Migration: ' || 'UNREF-328');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-329' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-329', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1883 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGRG-4L' OR product_name = 'POLYGLOSS PU RED GOLD 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU RED GOLD 4L', 'PGRG-4L', v_branch_id, 0, 1883) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1883);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1883, 'Migration: ' || 'UNREF-329');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-330' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-330', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1883 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTG-4L' OR product_name = 'POLYGLOSS PU PHTHALO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU PHTHALO GREEN 4L', 'PGTG-4L', v_branch_id, 0, 1883) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1883);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1883, 'Migration: ' || 'UNREF-330');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-331' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-331', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 223 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGYG-4L' OR product_name = 'POLYGLOSS PU YELLOW GOLD 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'PGYG-4L', v_branch_id, 0, 223) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 223);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 223, 'Migration: ' || 'UNREF-331');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-332' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-332', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3188 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGO-4L' OR product_name = 'POLYGLOSS PU GLEAMIST ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'PGGO-4L', v_branch_id, 0, 3188) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3188);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3188, 'Migration: ' || 'UNREF-332');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-333' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-333', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 546 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-7000' OR product_name = 'RAIN OR SHINE PREPA WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'ROS-7000', v_branch_id, 0, 546) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 546);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 546, 'Migration: ' || 'UNREF-333');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-334' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-334', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 115 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 23) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 23);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 23, 'Migration: ' || 'UNREF-334');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-335' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-335', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 65);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 65, 'Migration: ' || 'UNREF-335');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-336' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-336', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZHI-TBLCK' OR product_name = 'PYLOX HEAT RESISTANT BLACK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX HEAT RESISTANT BLACK', 'PLYZHI-TBLCK', v_branch_id, 0, 150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 150, 'Migration: ' || 'UNREF-336');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-337' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-337', '2026-04-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-337');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-338' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-338', '2026-04-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-338');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-339' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-339', '2026-04-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-339');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 150, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1509.76 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 23.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 64, 23.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 64, 23.59, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 855 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'GLAZERB-4L', v_branch_id, 0, 855) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 855);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 855, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1550, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1493 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 1493) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1493);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1493, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 695 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-739' OR product_name = 'COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L', 'ROS-739', v_branch_id, 0, 695) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 695);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 695, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2448 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 2448) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2448);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2448, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 1730) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1730);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1730, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1830 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 1830) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1830);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1830, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03653' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03653', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 28, 'Migration: ' || 'CSI-03653');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 11040 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 920);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 920, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7080 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 590);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 590, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9312 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 388) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 388);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 388, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4260 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 355) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 355);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 355, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1160, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1744 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT701' OR product_name = 'NAX PREMILA MT701 FAST VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'MT701', v_branch_id, 0, 1744) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1744);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1744, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03654' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03654', '2026-04-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1668 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1668, 'Migration: ' || 'CSI-03654');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03656' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03656', '2026-04-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 695 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'RSW-4L' OR product_name = 'RAIN OR SHINE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE WHITE 4L', 'RSW-4L', v_branch_id, 0, 695) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 695);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 695, 'Migration: ' || 'CSI-03656');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03656' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03656', '2026-04-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 650, 'Migration: ' || 'CSI-03656');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-360' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-360', '2026-04-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2325 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-4L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'NAT719-4L', v_branch_id, 0, 2325) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2325);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2325, 'Migration: ' || 'UNREF-360');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-361' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-361', '2026-04-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 540 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT192' OR product_name = 'NAX NAT-192 TTC BRIGHT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'NAT192', v_branch_id, 0, 540) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 540);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 540, 'Migration: ' || 'UNREF-361');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-362' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-362', '2026-04-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 425 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT320' OR product_name = 'NAX NAT-320 TTC GOLD YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'NAT320', v_branch_id, 0, 425) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 425);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 425, 'Migration: ' || 'UNREF-362');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-363' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-363', '2026-04-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-363');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-364' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-364', '2026-04-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 70 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 70);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 70, 'Migration: ' || 'UNREF-364');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-365' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-365', '2026-04-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-365');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-366' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-366', '2026-04-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 820 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 820) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 820);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 820, 'Migration: ' || 'UNREF-366');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-367' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-367', '2026-04-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 675 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX10100' OR product_name = 'NAX NAT-10100 NH-585 PEARL WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'NAX10100', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 675, 'Migration: ' || 'UNREF-367');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-368' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-368', '2026-04-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-368');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-369' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-369', '2026-04-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-369');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1920 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 160, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8640 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 720);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 720, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1850, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 650, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 665 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 665, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 900, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1330 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 665, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03664' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 95, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-379' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-379', '2026-04-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-379');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-380' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-380', '2026-04-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 661 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 661, 'Migration: ' || 'UNREF-380');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-381' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-381', '2026-04-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1668 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1668, 'Migration: ' || 'UNREF-381');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-382' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-382', '2026-04-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1159' OR product_name = 'NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'NAT1159', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-382');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-383' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-383', '2026-04-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 425 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT320' OR product_name = 'NAX NAT-320 TTC GOLD YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'NAT320', v_branch_id, 0, 425) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 425);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 425, 'Migration: ' || 'UNREF-383');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-384' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-384', '2026-04-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 640 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 640, 'Migration: ' || 'UNREF-384');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-385' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-385', '2026-04-30', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1518 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1518) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1518);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1518, 'Migration: ' || 'UNREF-385');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-386' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-386', '2026-05-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-386');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-387' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-387', '2026-05-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLY- BT-ALUM-4L' OR product_name = 'POLYGLOSS-BRIGHT ALUMINUM 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'POLY- BT-ALUM-4L', v_branch_id, 0, 1950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1950, 'Migration: ' || 'UNREF-387');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-388' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-388', '2026-05-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-388');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-389' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-389', '2026-05-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 675 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 675, 'Migration: ' || 'UNREF-389');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-390' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-390', '2026-05-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-390');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-391' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-391', '2026-05-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1157' OR product_name = 'NAX NAT-1157 TTC BRIGHT COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'NAT1157', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-391');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-392' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-392', '2026-05-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT147' OR product_name = 'NAX NAT-147 TTC THRENE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'NAT147', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1120, 'Migration: ' || 'UNREF-392');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-393' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-393', '2026-05-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 6000, 'Migration: ' || 'UNREF-393');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-394' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-394', '2026-05-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-394');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-395' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-395', '2026-05-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || 'UNREF-395');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1159' OR product_name = 'NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'NAT1159', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1120, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1600, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 600, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1150, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WEBER' OR product_name = 'SPRAY GUN F-75G WEBER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SPRAY GUN F-75G WEBER', 'WEBER', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 700);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 700, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1488 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 31) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 48, 31);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 48, 31, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2050 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLY- BT-ALUM-4L' OR product_name = 'POLYGLOSS-BRIGHT ALUMINUM 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'POLY- BT-ALUM-4L', v_branch_id, 0, 2050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2050, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 900, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8660 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2165) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2165);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2165, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03680' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03680', '2026-05-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2600, 'Migration: ' || 'CSI-03680');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4680 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 780, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2000, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1850, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SAFARE-4L' OR product_name = 'ROS-SAFARI BROWN_4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROS-SAFARI BROWN_4L', 'ROS-SAFARE-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 750, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 19.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 200, 19.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 200, 19.5, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 19.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 300, 19.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 300, 19.5, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7232 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 22.6) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 320, 22.6);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 320, 22.6, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1632 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 68) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 68);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 68, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 2200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2200, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03681' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03681', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 11200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 20, 560);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 20, 560, 'Migration: ' || 'CSI-03681');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03682' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03682', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 20, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 20, 650, 'Migration: ' || 'CSI-03682');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03682' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03682', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 22200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1850, 'Migration: ' || 'CSI-03682');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-03682' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-03682', '2026-05-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 20, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 20, 650, 'Migration: ' || 'CSI-03682');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-419' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-419', '2026-05-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-419');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-420' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-420', '2026-05-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-420');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-421' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-421', '2026-05-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2048 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT607' OR product_name = 'NAX PREMILA MT607 AUTUMN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'MT607', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2048, 'Migration: ' || 'UNREF-421');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-422' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-422', '2026-05-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-422');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-423' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-423', '2026-05-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-423');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-424' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-424', '2026-05-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1587-4L' OR product_name = 'NIPPON EXTREME QDU BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLUE 4L', 'NXU1587-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-424');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-425' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-425', '2026-05-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-425');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-426' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-426', '2026-05-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-426');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-427' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-427', '2026-05-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-1L' OR product_name = 'NAX PREMILA MT100 WHITE HS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'MT100-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-427');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-428' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-428', '2026-05-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5050 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT136' OR product_name = 'NAX PREMILA MT136 METALLIC ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'MT136', v_branch_id, 0, 5050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 5050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 5050, 'Migration: ' || 'UNREF-428');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-429' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-429', '2026-05-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-429');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-430' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-430', '2026-05-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-430');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-431' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-431', '2026-05-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 450, 'Migration: ' || 'UNREF-431');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-432' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-432', '2026-05-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT002-1L' OR product_name = 'NAX PREMILA MT002 CRYSTAL SILVER FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'MT002-1L', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || 'UNREF-432');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-433' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-433', '2026-05-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 661 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 661, 'Migration: ' || 'UNREF-433');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-434' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-434', '2026-05-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 834 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 834) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 834);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 834, 'Migration: ' || 'UNREF-434');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-435' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-435', '2026-05-19', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2325 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-4L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'NAT719-4L', v_branch_id, 0, 2325) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2325);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2325, 'Migration: ' || 'UNREF-435');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-436' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-436', '2026-05-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1994 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT023' OR product_name = 'NAX PREMILA MT023 HIGH SPARKLE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'MT023', v_branch_id, 0, 1994) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1994);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1994, 'Migration: ' || 'UNREF-436');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-437' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-437', '2026-05-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-437');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-438' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-438', '2026-05-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-438');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-439' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-439', '2026-05-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1160, 'Migration: ' || 'UNREF-439');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-440' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-440', '2026-05-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1593 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || 'UNREF-440');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-441' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-441', '2026-05-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1550 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1550, 'Migration: ' || 'UNREF-441');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-442' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-442', '2026-05-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1668 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1668, 'Migration: ' || 'UNREF-442');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-443' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-443', '2026-05-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 765 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-710' OR product_name = 'BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'B-710', v_branch_id, 0, 765) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 765);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 765, 'Migration: ' || 'UNREF-443');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-444' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-444', '2026-05-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 615 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-791' OR product_name = 'BOYSEN PERMACOAT FLAT LATEX BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN PERMACOAT FLAT LATEX BLACK 4L', 'B-791', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 615, 'Migration: ' || 'UNREF-444');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-445' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-445', '2026-05-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-445');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-446' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-446', '2026-05-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-446');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-447' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-447', '2026-05-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-447');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-448' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-448', '2026-05-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-448');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-449' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-449', '2026-05-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1110 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT149' OR product_name = 'NAX NAT-149 TTC DARK MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'NAT149', v_branch_id, 0, 1110) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1110);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1110, 'Migration: ' || 'UNREF-449');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-450' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-450', '2026-05-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 422 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT715-1L' OR product_name = 'NAX NAT-715 TTC FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'NAT715-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 422, 'Migration: ' || 'UNREF-450');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-451' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-451', '2026-05-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-4L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'NAT1110-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2400, 'Migration: ' || 'UNREF-451');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-452' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-452', '2026-05-29', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-452');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-453' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-453', '2026-06-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1518 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1518) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1518);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1518, 'Migration: ' || 'UNREF-453');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-454' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-454', '2026-06-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 70 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 70);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 70, 'Migration: ' || 'UNREF-454');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-455' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-455', '2026-06-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-455');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-456' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-456', '2026-06-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 834 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 834) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 834);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 834, 'Migration: ' || 'UNREF-456');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-367' OR product_name = 'CANDY TUFF ROS-367 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'ROS-367', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 650, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 500, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1587-4L' OR product_name = 'NIPPON EXTREME QDU BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLUE 4L', 'NXU1587-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1000, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1450, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-2133' OR product_name = 'BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT', 'PWTCO-2133', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 100, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3250 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 650, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- UH SO RED -4L' OR product_name = 'RAIN OR SHINE- UH SO RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE- UH SO RED 4L', 'ROS- UH SO RED -4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 650, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004053' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004053', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- HAPPY DAYS-4L' OR product_name = 'RAIN OR SHINE- HAPPY DAYS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'ROS- HAPPY DAYS-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 650, 'Migration: ' || 'CSI-004053');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 650, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-6133' OR product_name = 'BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'PWTCO-6133', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 100, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BRIDE-4L' OR product_name = 'ROS-BRIDAL GOWN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROS-BRIDAL GOWN-4L', 'ROS-BRIDE-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 650, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 14400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 600, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 650, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1600, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 2200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2200, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1850, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8640 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2160, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004054' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004054', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 276 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 23) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 23);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 23, 'Migration: ' || 'CSI-004054');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004055' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004055', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 50, 'Migration: ' || 'CSI-004055');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004055' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004055', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 1950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1950, 'Migration: ' || 'CSI-004055');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004055' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004055', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 216 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 18) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 18);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 18, 'Migration: ' || 'CSI-004055');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-480' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-480', '2026-06-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-480');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-481' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-481', '2026-06-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-481');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-482' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-482', '2026-06-10', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-482');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-483' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-483', '2026-06-10', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT103' OR product_name = 'NAX PREMILA MT103 WHITE LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'MT103', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-483');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-484' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-484', '2026-06-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1157' OR product_name = 'NAX NAT-1157 TTC BRIGHT COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'NAT1157', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-484');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-485' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-485', '2026-06-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-485');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-486' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-486', '2026-06-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT071' OR product_name = 'NAX PREMILA MT071 MICA BASE 5B BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'MT071', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || 'UNREF-486');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-487' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-487', '2026-06-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2440 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2440);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2440, 'Migration: ' || 'UNREF-487');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-488' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-488', '2026-06-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-488');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-489' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-489', '2026-06-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9760 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2440);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2440, 'Migration: ' || 'UNREF-489');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-490' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-490', '2026-06-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-490');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-491' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-491', '2026-06-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-4L' OR product_name = 'EXTREME QDU MIXING 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 4L', 'EXTREMEMIX-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'UNREF-491');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-492' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-492', '2026-06-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1485 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-492');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-493' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-493', '2026-06-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-4L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'NAT1110-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2400, 'Migration: ' || 'UNREF-493');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-494' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-494', '2026-06-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3600, 'Migration: ' || 'UNREF-494');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-495' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-495', '2026-06-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1550 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1550, 'Migration: ' || 'UNREF-495');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-496' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-496', '2026-06-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-4L' OR product_name = 'EXTREME QDU MIXING 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 4L', 'EXTREMEMIX-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'UNREF-496');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-497' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-497', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 19.75, 200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 19.75, 200, 'Migration: ' || 'UNREF-497');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-498' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-498', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-4L' OR product_name = 'QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L', 'QDEMIX-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 800);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 800, 'Migration: ' || 'UNREF-498');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-499' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-499', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 106445 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 43.625, 2440);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 43.625, 2440, 'Migration: ' || 'UNREF-499');
  END;

END $MIGRATION$;
