-- Migration for Valencia Stock In Part 1
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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 366 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 30.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 30.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 30.5, 'Migration: ' || 'CSI-03664');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-1' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-1', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT904' OR product_name = 'NAX PREMILA MT904 SHADOWN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'MT904', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-1');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-2' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-2', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4683 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT903' OR product_name = 'NAX PREMILA MT903 SUN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'MT903', v_branch_id, 0, 1561) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1561);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1561, 'Migration: ' || 'UNREF-2');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-3' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-3', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT902' OR product_name = 'NAX PREMILA MT902 GRASS GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT902 GRASS GREEN 1L', 'MT902', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-3');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-4' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-4', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT807' OR product_name = 'NAX PREMILA MT807 VACANCE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'MT807', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-4');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-5' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-5', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3186 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT806' OR product_name = 'NAX PREMILA MT806 HERMES BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'MT806', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1593, 'Migration: ' || 'UNREF-5');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-6' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-6', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1593 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT805' OR product_name = 'NAX PREMILA MT805 CUSTOM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'MT805', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || 'UNREF-6');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-7' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-7', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || 'UNREF-7');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-8' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-8', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3186 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT803' OR product_name = 'NAX PREMILA MT803 FRESH BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'MT803', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1593, 'Migration: ' || 'UNREF-8');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-9' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-9', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT801' OR product_name = 'NAX PREMILA MT801 CYANINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'MT801', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-9');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-10' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-10', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7584 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT705' OR product_name = 'NAX PREMILA MT705 FLORA VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'MT705', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1896, 'Migration: ' || 'UNREF-10');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-11' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-11', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4779 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT704' OR product_name = 'NAX PREMILA MT704 FINE VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'MT704', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-11');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-12' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-12', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2048, 'Migration: ' || 'UNREF-12');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-13' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-13', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3216 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT606' OR product_name = 'NAX PREMILA MT606 GIRAFFE YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'MT606', v_branch_id, 0, 1608) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1608);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1608, 'Migration: ' || 'UNREF-13');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-14' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-14', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2048 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT604' OR product_name = 'NAX PREMILA MT604 EXTRA MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'MT604', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2048, 'Migration: ' || 'UNREF-14');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-15' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-15', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5688 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT603' OR product_name = 'NAX PREMILA MT603 CINQUASIA BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'MT603', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-15');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-16' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-16', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6906 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT602' OR product_name = 'NAX PREMILA MT602 PEGASUS MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'MT602', v_branch_id, 0, 2302) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2302);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2302, 'Migration: ' || 'UNREF-16');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-17' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-17', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5547 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT601' OR product_name = 'NAX PREMILA MT601 IRON RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT601 IRON RED 1L', 'MT601', v_branch_id, 0, 1849) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1849);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1849, 'Migration: ' || 'UNREF-17');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-18' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-18', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4698 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT508' OR product_name = 'NAX PREMILA MT508 INDIAN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'MT508', v_branch_id, 0, 2349) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2349);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2349, 'Migration: ' || 'UNREF-18');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-19' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-19', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8601 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT507' OR product_name = 'NAX PREMILA MT507 RUBY RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'MT507', v_branch_id, 0, 2867) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2867);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2867, 'Migration: ' || 'UNREF-19');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-20' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-20', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5688 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT506' OR product_name = 'NAX PREMILA MT506 CINQUASIA RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'MT506', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-20');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-21' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-21', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT505' OR product_name = 'NAX PREMILA MT505 SPARK RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'MT505', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2900, 'Migration: ' || 'UNREF-21');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-22' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-22', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6144 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT501' OR product_name = 'NAX PREMILA MT501 STRONG RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'MT501', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2048, 'Migration: ' || 'UNREF-22');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-23' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-23', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1896 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT405' OR product_name = 'NAX PREMILA MT405 SUN ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'MT405', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1896, 'Migration: ' || 'UNREF-23');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-24' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-24', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4852 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT401' OR product_name = 'NAX PREMILA MT401 MAXIM ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'MT401', v_branch_id, 0, 2426) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2426);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2426, 'Migration: ' || 'UNREF-24');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-25' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-25', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5916 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT307' OR product_name = 'NAX PREMILA MT307 EXTRA YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'MT307', v_branch_id, 0, 2958) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2958);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2958, 'Migration: ' || 'UNREF-25');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-26' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-26', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3488 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT305' OR product_name = 'NAX PREMILA MT305 NATURAL YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'MT305', v_branch_id, 0, 1744) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1744);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1744, 'Migration: ' || 'UNREF-26');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-27' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-27', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT304' OR product_name = 'NAX PREMILA MT304 GAILY YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'MT304', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3600, 'Migration: ' || 'UNREF-27');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-28' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-28', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1896 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT303' OR product_name = 'NAX PREMILA MT303 FINE YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'MT303', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1896, 'Migration: ' || 'UNREF-28');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-29' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-29', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3792 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT302' OR product_name = 'NAX PREMILA MT302 JEWEL YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'MT302', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1896, 'Migration: ' || 'UNREF-29');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-30' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-30', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5688 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT301' OR product_name = 'NAX PREMILA MT301 MAPICO YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'MT301', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-30');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-31' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-31', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3336 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1668, 'Migration: ' || 'UNREF-31');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-32' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-32', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-32');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-33' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-33', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4360 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT201' OR product_name = 'NAX PREMILA MT201 BLUE BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'MT201', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1090, 'Migration: ' || 'UNREF-33');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-34' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-34', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3792 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT175' OR product_name = 'NAX PREMILA MT175 GRAPHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'MT175', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1896, 'Migration: ' || 'UNREF-34');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-35' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-35', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8988 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT172' OR product_name = 'NAX PREMILA MT172 OPAL COLOR 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'MT172', v_branch_id, 0, 2996) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2996);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2996, 'Migration: ' || 'UNREF-35');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-36' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-36', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2752 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT170' OR product_name = 'NAX PREMILA MT170 OPAL COLOR LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'MT170', v_branch_id, 0, 1376) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1376);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1376, 'Migration: ' || 'UNREF-36');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-37' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-37', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 10100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT136' OR product_name = 'NAX PREMILA MT136 METALLIC ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'MT136', v_branch_id, 0, 5050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 5050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 5050, 'Migration: ' || 'UNREF-37');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-38' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-38', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT134' OR product_name = 'NAX PREMILA MT134 METALLIC GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'MT134', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3600, 'Migration: ' || 'UNREF-38');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-39' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-39', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT103' OR product_name = 'NAX PREMILA MT103 WHITE LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'MT103', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1090, 'Migration: ' || 'UNREF-39');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-40' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-40', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12480 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-4L' OR product_name = 'NAX PREMILA MT100 WHITE HS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'MT100-4L', v_branch_id, 0, 4160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 4160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 4160, 'Migration: ' || 'UNREF-40');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-41' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-41', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6540 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-1L' OR product_name = 'NAX PREMILA MT100 WHITE HS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'MT100-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1090, 'Migration: ' || 'UNREF-41');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-42' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-42', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 6000, 'Migration: ' || 'UNREF-42');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-43' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-43', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT093' OR product_name = 'NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'MT093', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-43');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-44' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-44', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT086' OR product_name = 'NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'MT086', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-44');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-45' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-45', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT085' OR product_name = 'NAX PREMILA MT085 MICA BASE 4G GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'MT085', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-45');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-46' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-46', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT083' OR product_name = 'NAX PREMILA MT083 MICA BASE 4R RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'MT083', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-46');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-47' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-47', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT081' OR product_name = 'NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'MT081', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-47');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-48' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-48', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT080' OR product_name = 'NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'MT080', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-48');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-49' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-49', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT079' OR product_name = 'NAX PREMILA MT079 MICA BASE 2V VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'MT079', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-49');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-50' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-50', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT078' OR product_name = 'NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'MT078', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-50');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-51' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-51', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT076' OR product_name = 'NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'MT076', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-51');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-52' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-52', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT075' OR product_name = 'NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'MT075', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-52');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-53' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-53', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT072' OR product_name = 'NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'MT072', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-53');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-54' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-54', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT071' OR product_name = 'NAX PREMILA MT071 MICA BASE 5B BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'MT071', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-54');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-55' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-55', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 10950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06M' OR product_name = 'NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'MT06M', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3650, 'Migration: ' || 'UNREF-55');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-56' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-56', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06H' OR product_name = 'NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'MT06H', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3650, 'Migration: ' || 'UNREF-56');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-57' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-57', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06A' OR product_name = 'NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'MT06A', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3650, 'Migration: ' || 'UNREF-57');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-58' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-58', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT068' OR product_name = 'NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'MT068', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 6000, 'Migration: ' || 'UNREF-58');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-59' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-59', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT067' OR product_name = 'NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'MT067', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-59');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-60' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-60', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT066' OR product_name = 'NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'MT066', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-60');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-61' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-61', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT065' OR product_name = 'NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'MT065', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-61');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-62' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-62', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT061' OR product_name = 'NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'MT061', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-62');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-63' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-63', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT051' OR product_name = 'NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'MT051', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-63');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-64' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-64', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT050' OR product_name = 'NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'MT050', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || 'UNREF-64');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-65' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-65', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3990 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT033' OR product_name = 'NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'MT033', v_branch_id, 0, 1995) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1995);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1995, 'Migration: ' || 'UNREF-65');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-66' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-66', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1745 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT030' OR product_name = 'NAX PREMILA MT030 WHITE MET. SNOW FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'MT030', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-66');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-67' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-67', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT028' OR product_name = 'NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'MT028', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-67');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-68' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-68', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1745 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT025' OR product_name = 'NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'MT025', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-68');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-69' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-69', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5982 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT023' OR product_name = 'NAX PREMILA MT023 HIGH SPARKLE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'MT023', v_branch_id, 0, 1994) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1994);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1994, 'Migration: ' || 'UNREF-69');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-70' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-70', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1745 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT012' OR product_name = 'NAX PREMILA MT012 MET. BASE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'MT012', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-70');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-71' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-71', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT008' OR product_name = 'NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'MT008', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-71');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-72' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-72', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT006' OR product_name = 'NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'MT006', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2150, 'Migration: ' || 'UNREF-72');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-73' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-73', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT004' OR product_name = 'NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'MT004', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2150, 'Migration: ' || 'UNREF-73');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-74' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-74', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT003' OR product_name = 'NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'MT003', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || 'UNREF-74');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-75' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-75', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT002-1L' OR product_name = 'NAX PREMILA MT002 CRYSTAL SILVER FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'MT002-1L', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2150, 'Migration: ' || 'UNREF-75');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-76' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-76', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT001' OR product_name = 'NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'MT001', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-76');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-77' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-77', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1326 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX1062' OR product_name = 'NAX NAT-1062 QDU 040 SUPER WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'NAX1062', v_branch_id, 0, 442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 442, 'Migration: ' || 'UNREF-77');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-78' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-78', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3375 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX10100' OR product_name = 'NAX NAT-10100 NH-585 PEARL WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'NAX10100', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 675, 'Migration: ' || 'UNREF-78');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-79' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-79', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT992' OR product_name = 'NAX NAT-992 TTC BLACK NO.8 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'NAT992', v_branch_id, 0, 410) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 410);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 410, 'Migration: ' || 'UNREF-79');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-80' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-80', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 15180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1518) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 1518);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 1518, 'Migration: ' || 'UNREF-80');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-81' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-81', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4499 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-1L' OR product_name = 'NAX NAT-990 TTC BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 1L', 'NAT990-1L', v_branch_id, 0, 409) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 409);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 409, 'Migration: ' || 'UNREF-81');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-82' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-82', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4980 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT745' OR product_name = 'NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'NAT745', v_branch_id, 0, 830) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 830);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 830, 'Migration: ' || 'UNREF-82');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-83' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-83', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2820 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT740' OR product_name = 'NAX NAT-740 TTC ULTRA FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'NAT740', v_branch_id, 0, 470) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 470);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 470, 'Migration: ' || 'UNREF-83');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-84' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-84', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2055 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT736' OR product_name = 'NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'NAT736', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 685, 'Migration: ' || 'UNREF-84');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-85' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-85', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3924 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT733' OR product_name = 'NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'NAT733', v_branch_id, 0, 436) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 436);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 436, 'Migration: ' || 'UNREF-85');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-86' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-86', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4560 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT729' OR product_name = 'NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'NAT729', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 760);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 760, 'Migration: ' || 'UNREF-86');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-87' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-87', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 995 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT728' OR product_name = 'NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'NAT728', v_branch_id, 0, 995) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 995);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 995, 'Migration: ' || 'UNREF-87');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-88' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-88', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6510 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT727' OR product_name = 'NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'NAT727', v_branch_id, 0, 1085) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1085);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1085, 'Migration: ' || 'UNREF-88');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-89' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-89', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3912 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT725' OR product_name = 'NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'NAT725', v_branch_id, 0, 652) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 652);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 652, 'Migration: ' || 'UNREF-89');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-90' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-90', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3726 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT720' OR product_name = 'NAX NAT-720 TTC SPARKLE WHITE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'NAT720', v_branch_id, 0, 621) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 621);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 621, 'Migration: ' || 'UNREF-90');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-91' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-91', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-4L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'NAT719-4L', v_branch_id, 0, 2325) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2325);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2325, 'Migration: ' || 'UNREF-91');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-92' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-92', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5355 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-1L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'NAT719-1L', v_branch_id, 0, 595) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 595);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 595, 'Migration: ' || 'UNREF-92');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-93' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-93', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2532 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT716' OR product_name = 'NAX NAT-716 TTC SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'NAT716', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 422, 'Migration: ' || 'UNREF-93');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-94' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-94', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1266 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT715-1L' OR product_name = 'NAX NAT-715 TTC FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'NAT715-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 422, 'Migration: ' || 'UNREF-94');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-95' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-95', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4067 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT712-1L' OR product_name = 'NAX NAT-712 TTC MEDIUM FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'NAT712-1L', v_branch_id, 0, 581) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 581);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 581, 'Migration: ' || 'UNREF-95');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-96' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-96', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2490 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT595' OR product_name = 'NAX NAT-595 TTC CYANINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'NAT595', v_branch_id, 0, 498) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 498);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 498, 'Migration: ' || 'UNREF-96');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-97' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-97', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT557' OR product_name = 'NAX NAT-557 TTC BLUE NO.9 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'NAT557', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 450, 'Migration: ' || 'UNREF-97');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-98' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-98', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT556' OR product_name = 'NAX NAT-556 TTC BLUE NO.8 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'NAT556', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 620);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 620, 'Migration: ' || 'UNREF-98');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-99' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-99', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3102 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT555' OR product_name = 'NAX NAT-555 TTC BLUE NO.7 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'NAT555', v_branch_id, 0, 517) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 517);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 517, 'Migration: ' || 'UNREF-99');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-100' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-100', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 870 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT550' OR product_name = 'NAX NAT-550 TTC SUPER BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'NAT550', v_branch_id, 0, 435) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 435);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 435, 'Migration: ' || 'UNREF-100');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-101' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-101', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3270 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT530' OR product_name = 'NAX NAT-530 TTC FINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'NAT530', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1090, 'Migration: ' || 'UNREF-101');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-102' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-102', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT490' OR product_name = 'NAX NAT-490 TTC EVERGREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'NAT490', v_branch_id, 0, 500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 500, 'Migration: ' || 'UNREF-102');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-103' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-103', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4781 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT410' OR product_name = 'NAX NAT-410 TTC CYANINE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'NAT410', v_branch_id, 0, 683) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 683);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 683, 'Migration: ' || 'UNREF-103');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-104' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-104', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3303 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT390' OR product_name = 'NAX NAT-390 TTC IRON YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'NAT390', v_branch_id, 0, 367) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 367);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 367, 'Migration: ' || 'UNREF-104');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-105' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-105', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT380' OR product_name = 'NAX NAT-380 TTC SUPER YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'NAT380', v_branch_id, 0, 1035) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1035);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1035, 'Migration: ' || 'UNREF-105');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-106', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9867 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT321' OR product_name = 'NAX NAT-321 TTC HOSTAPERM YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'NAT321', v_branch_id, 0, 897) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 897);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 897, 'Migration: ' || 'UNREF-106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-107' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-107', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2975 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT320' OR product_name = 'NAX NAT-320 TTC GOLD YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'NAT320', v_branch_id, 0, 425) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 425);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 425, 'Migration: ' || 'UNREF-107');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-108' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-108', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT305' OR product_name = 'NAX NAT-305 TTC GREEN YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'NAT305', v_branch_id, 0, 1380) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1380);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1380, 'Migration: ' || 'UNREF-108');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-109' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-109', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9066 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT210' OR product_name = 'NAX NAT-210 TTC SUPER ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'NAT210', v_branch_id, 0, 1511) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1511);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1511, 'Migration: ' || 'UNREF-109');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-110' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-110', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 15750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT196' OR product_name = 'NAX NAT-196 TTC PURPLISH RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'NAT196', v_branch_id, 0, 1125) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 14, 1125);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 14, 1125, 'Migration: ' || 'UNREF-110');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-111' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-111', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT192' OR product_name = 'NAX NAT-192 TTC BRIGHT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'NAT192', v_branch_id, 0, 540) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 540);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 540, 'Migration: ' || 'UNREF-111');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-112' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-112', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1975 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT190' OR product_name = 'NAX NAT-190 TTC IRON RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-190 TTC IRON RED 1L', 'NAT190', v_branch_id, 0, 395) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 395);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 395, 'Migration: ' || 'UNREF-112');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-113' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-113', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5370 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT180' OR product_name = 'NAX NAT-180 TTC STRAWBERRY RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'NAT180', v_branch_id, 0, 895) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 895);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 895, 'Migration: ' || 'UNREF-113');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-114', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13320 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT149' OR product_name = 'NAX NAT-149 TTC DARK MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'NAT149', v_branch_id, 0, 1110) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1110);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1110, 'Migration: ' || 'UNREF-114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-115', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 10080 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT147' OR product_name = 'NAX NAT-147 TTC THRENE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'NAT147', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 1120, 'Migration: ' || 'UNREF-115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-116' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-116', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 15780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT143' OR product_name = 'NAX NAT-143 TTC FLAME RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'NAT143', v_branch_id, 0, 1315) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1315);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1315, 'Migration: ' || 'UNREF-116');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-117' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-117', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9252 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1305' OR product_name = 'NAX NAT-1305 TTC 211 MICA BASE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'NAT1305', v_branch_id, 0, 1542) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1542);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1542, 'Migration: ' || 'UNREF-117');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-118' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-118', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5868 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1304' OR product_name = 'NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'NAT1304', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1956, 'Migration: ' || 'UNREF-118');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-119' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-119', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 11736 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1303' OR product_name = 'NAX NAT-1303 TTC OMEGA PEARL 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'NAT1303', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1956, 'Migration: ' || 'UNREF-119');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-120', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1301' OR product_name = 'NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'NAT1301', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1956, 'Migration: ' || 'UNREF-120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-121' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-121', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1300' OR product_name = 'NAX NAT-1300 TTC CRYSTALLINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'NAT1300', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1956, 'Migration: ' || 'UNREF-121');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-122' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-122', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9258 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1180' OR product_name = 'NAX NAT-1180 TTC OYSTER WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'NAT1180', v_branch_id, 0, 1543) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1543);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1543, 'Migration: ' || 'UNREF-122');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-123' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-123', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3990 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1175' OR product_name = 'NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'NAT1175', v_branch_id, 0, 798) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 798);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 798, 'Migration: ' || 'UNREF-123');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-124' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-124', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9594 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1173' OR product_name = 'NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'NAT1173', v_branch_id, 0, 1599) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1599);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1599, 'Migration: ' || 'UNREF-124');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-125' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-125', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1172' OR product_name = 'NAX NAT-1172 TTC BRIGHT GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'NAT1172', v_branch_id, 0, 910) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 910);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 910, 'Migration: ' || 'UNREF-125');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-126' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-126', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5040 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1171' OR product_name = 'NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'NAT1171', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 840);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 840, 'Migration: ' || 'UNREF-126');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-127' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-127', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5040 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1167' OR product_name = 'NAX NAT-1167 TTC PALE GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'NAT1167', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 840);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 840, 'Migration: ' || 'UNREF-127');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-128' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-128', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5316 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1166' OR product_name = 'NAX NAT-1166 TTC EARTH BROWN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'NAT1166', v_branch_id, 0, 886) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 886);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 886, 'Migration: ' || 'UNREF-128');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-129' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-129', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1165' OR product_name = 'NAX NAT-1165 TTC HI-LITE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'NAT1165', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-129');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-130' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-130', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1920 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 640, 'Migration: ' || 'UNREF-130');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-131' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-131', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1163' OR product_name = 'NAX NAT-1163 TTC FINE GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'NAT1163', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 780, 'Migration: ' || 'UNREF-131');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-132' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-132', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4164 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1160' OR product_name = 'NAX NAT-1160 TTC RED COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'NAT1160', v_branch_id, 0, 694) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 694);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 694, 'Migration: ' || 'UNREF-132');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-133' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-133', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1158' OR product_name = 'NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'NAT1158', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 780, 'Migration: ' || 'UNREF-133');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-134' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-134', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2340 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1157' OR product_name = 'NAX NAT-1157 TTC BRIGHT COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'NAT1157', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 780, 'Migration: ' || 'UNREF-134');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-135' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-135', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1560 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1153' OR product_name = 'NAX NAT-1153 TTC SUPER RED MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'NAT1153', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 780, 'Migration: ' || 'UNREF-135');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-136' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-136', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2644 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1114' OR product_name = 'NAX NAT-1114 TTC GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'NAT1114', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 661, 'Migration: ' || 'UNREF-136');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-137' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-137', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1322 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1113' OR product_name = 'NAX NAT-1113 TTC FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'NAT1113', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 661, 'Migration: ' || 'UNREF-137');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-138' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-138', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-4L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'NAT1110-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 2400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 2400, 'Migration: ' || 'UNREF-138');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-139' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-139', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3810 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-1L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'NAT1110-1L', v_branch_id, 0, 635) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 635);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 635, 'Migration: ' || 'UNREF-139');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-140' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-140', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4674 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1107' OR product_name = 'NAX NAT-1107 TTC FINE RED MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'NAT1107', v_branch_id, 0, 779) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 779);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 779, 'Migration: ' || 'UNREF-140');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-141' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-141', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2589 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1106' OR product_name = 'NAX NAT-1106 TTC PEARL BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'NAT1106', v_branch_id, 0, 863) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 863);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 863, 'Migration: ' || 'UNREF-141');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-142' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-142', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7290 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT103' OR product_name = 'NAX NAT-103 TTC OPAL 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-103 TTC OPAL 1L', 'NAT103', v_branch_id, 0, 1215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1215);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1215, 'Migration: ' || 'UNREF-142');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-143' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-143', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1500, 'Migration: ' || 'UNREF-143');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-144' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-144', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7455 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10.5, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10.5, 710, 'Migration: ' || 'UNREF-144');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-145' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-145', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4966.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7.25, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7.25, 685, 'Migration: ' || 'UNREF-145');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-146' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-146', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5790 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 193) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 30, 193);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 30, 193, 'Migration: ' || 'UNREF-146');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-147' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-147', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4664.7 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.57, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.57, 710, 'Migration: ' || 'UNREF-147');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-148' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-148', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 828) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 828);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 828, 'Migration: ' || 'UNREF-148');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-149' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-149', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5360 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-15L' OR product_name = 'NIPPON DOU CLASSIC SG WHITE 715 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'DCSG715-15L', v_branch_id, 0, 2680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2680);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2680, 'Migration: ' || 'UNREF-149');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-150' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-150', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1890 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-5L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'DCF701-5L', v_branch_id, 0, 630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 630, 'Migration: ' || 'UNREF-150');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-151' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-151', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1320 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 165) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 165);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 165, 'Migration: ' || 'UNREF-151');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-152' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-152', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8520 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-15L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'DCF701-15L', v_branch_id, 0, 2130) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2130);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2130, 'Migration: ' || 'UNREF-152');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-153' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-153', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 14467 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 851) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 17, 851);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 17, 851, 'Migration: ' || 'UNREF-153');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-154' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-154', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9768 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-15L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'QSHG710-15L', v_branch_id, 0, 2442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2442, 'Migration: ' || 'UNREF-154');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-155' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-155', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3490 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDRB-4L' OR product_name = 'PLATONE QDE ROYAL BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLQDRB-4L', v_branch_id, 0, 698) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 698);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 698, 'Migration: ' || 'UNREF-155');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-156' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-156', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 732 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDJG-4L' OR product_name = 'PLATONE QDE JADE GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE JADE GREEN 4L', 'PLQDJG-4L', v_branch_id, 0, 732) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 732);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 732, 'Migration: ' || 'UNREF-156');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-157' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-157', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1546 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 773) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 773);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 773, 'Migration: ' || 'UNREF-157');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-158' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-158', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2004 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDCB-4L' OR product_name = 'PLATONE QDE CHOCOLATE BROWN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'PLQDCB-4L', v_branch_id, 0, 668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 668, 'Migration: ' || 'UNREF-158');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-159' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-159', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5288 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 661, 'Migration: ' || 'UNREF-159');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-160' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-160', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'XTRMEQDWARMYLW-4L' OR product_name = 'NIPPON EXTREME QDU WARM YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'XTRMEQDWARMYLW-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1630, 'Migration: ' || 'UNREF-160');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-161' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-161', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3260 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1630, 'Migration: ' || 'UNREF-161');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-162' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-162', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1550, 'Migration: ' || 'UNREF-162');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-163' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-163', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 19560 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1630, 'Migration: ' || 'UNREF-163');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-164' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-164', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6520 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1630, 'Migration: ' || 'UNREF-164');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-165' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-165', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 17, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 17, 50, 'Migration: ' || 'UNREF-165');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-166' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-166', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 360) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 360);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 360, 'Migration: ' || 'UNREF-166');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-167' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-167', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 510 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOUT-4L' OR product_name = 'TIMEOUT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT URETHANE THINNER 4L', 'TOUT-4L', v_branch_id, 0, 510) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 510);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 510, 'Migration: ' || 'UNREF-167');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-168' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-168', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4323 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 786) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5.5, 786);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5.5, 786, 'Migration: ' || 'UNREF-168');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-169' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-169', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 10800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 450, 'Migration: ' || 'UNREF-169');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-170' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-170', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3135 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5.7, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5.7, 550, 'Migration: ' || 'UNREF-170');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-171' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-171', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1030, 'Migration: ' || 'UNREF-171');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-172' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-172', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9145.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 871) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10.5, 871);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10.5, 871, 'Migration: ' || 'UNREF-172');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-173' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-173', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 25198 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 344) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 73.25, 344);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 73.25, 344, 'Migration: ' || 'UNREF-173');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-174' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-174', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 460) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 460);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 460, 'Migration: ' || 'UNREF-174');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-175' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-175', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 445) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 445);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 445, 'Migration: ' || 'UNREF-175');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-176' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-176', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6448 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 496) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 13, 496);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 13, 496, 'Migration: ' || 'UNREF-176');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-177' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-177', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 565 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUT3050-4KG' OR product_name = 'NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'PUT3050-4KG', v_branch_id, 0, 565) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 565);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 565, 'Migration: ' || 'UNREF-177');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-178' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-178', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE4090' OR product_name = 'NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'NXE4090', v_branch_id, 0, 1320) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 1320);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 1320, 'Migration: ' || 'UNREF-178');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-179' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-179', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 1050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 1050, 'Migration: ' || 'UNREF-179');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-180' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-180', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA4021' OR product_name = 'NIPPELAC ACE BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'NPA4021', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1000, 'Migration: ' || 'UNREF-180');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-181' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-181', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1983' OR product_name = 'NIPPELAC ACE JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE JET BLACK 4L', 'NPA1983', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 1050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 1050, 'Migration: ' || 'UNREF-181');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-182' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-182', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6720 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1372' OR product_name = 'NIPPELAC ACE LEMON YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'NPA1372', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1120, 'Migration: ' || 'UNREF-182');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-183' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-183', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 14800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1131' OR product_name = 'NIPPELAC ACE RED TRIPPLE 8 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE RED TRIPPLE 8 4L', 'NPA1131', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 1850, 'Migration: ' || 'UNREF-183');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-184' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-184', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7290 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1487' OR product_name = 'NIPPELAC ACE THALO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE THALO GREEN 4L', 'NPA1487', v_branch_id, 0, 1215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1215);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1215, 'Migration: ' || 'UNREF-184');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-185' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-185', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2100, 'Migration: ' || 'UNREF-185');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-186' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-186', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NB200' OR product_name = 'NAX PREMILA NB200 BINDER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB200 BINDER', 'NB200', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-186');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-187' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-187', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1030 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NB200-HAR' OR product_name = 'NAX PREMILA 2K NB200 HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA 2K NB200 HARDENER', 'NB200-HAR', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1030, 'Migration: ' || 'UNREF-187');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-188' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-188', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9225 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 615, 'Migration: ' || 'UNREF-188');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-189' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-189', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2640 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGL-4L' OR product_name = 'NIPPON CLEAR GLOSS LACQUER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON CLEAR GLOSS LACQUER 4L', 'NCGL-4L', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 660, 'Migration: ' || 'UNREF-189');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-190' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-190', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5510 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 190) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 29, 190);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 29, 190, 'Migration: ' || 'UNREF-190');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-191' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-191', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3571.92 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 363) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9.84, 363);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9.84, 363, 'Migration: ' || 'UNREF-191');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-192' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-192', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 550, 'Migration: ' || 'UNREF-192');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-193' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-193', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1342 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFI46G-5KG' OR product_name = 'NIPPON FLEXI-SEAL 146 GRAY 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'NFI46G-5KG', v_branch_id, 0, 1342) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1342);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1342, 'Migration: ' || 'UNREF-193');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-194' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-194', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2684 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1342) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1342);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1342, 'Migration: ' || 'UNREF-194');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-195' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-195', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2814 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS-5G' OR product_name = 'NIPPON ACRYLIC SKIMCOAT 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'NAS-5G', v_branch_id, 0, 402) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 402);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 402, 'Migration: ' || 'UNREF-195');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-196' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-196', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7920 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSKSMCOAT-BAG' OR product_name = 'BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'BSKSMCOAT-BAG', v_branch_id, 0, 495) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 16, 495);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 16, 495, 'Migration: ' || 'UNREF-196');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-197' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-197', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5265 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.75, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.75, 780, 'Migration: ' || 'UNREF-197');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-198' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-198', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 165 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBPNTSTRNR' OR product_name = 'ROBFILTER PAINT STRAINER 125M') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBFILTER PAINT STRAINER 125M', 'ROBPNTSTRNR', v_branch_id, 0, 11) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 11);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 11, 'Migration: ' || 'UNREF-198');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-199' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-199', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 665 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 95, 'Migration: ' || 'UNREF-199');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-200' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-200', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZVIO-20' OR product_name = 'PYLOX LAZER VIOLET 20') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER VIOLET 20', 'PLYZVIO-20', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 95, 'Migration: ' || 'UNREF-200');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-201' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-201', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 570 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSKBL-22' OR product_name = 'PYLOX LAZER SKY BLUE 22') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER SKY BLUE 22', 'PLYZSKBL-22', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 95, 'Migration: ' || 'UNREF-201');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-202' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-202', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 855 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 95, 'Migration: ' || 'UNREF-202');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-203' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-203', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 570 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZPRGR-145' OR product_name = 'PYLOX LAZER PRIMER GRAY 145') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER PRIMER GRAY 145', 'PLYZPRGR-145', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 95, 'Migration: ' || 'UNREF-203');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-204' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-204', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 665 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTW-03' OR product_name = 'PYLOX LAZER MATT WHITE 03') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER MATT WHITE 03', 'PLYZMTW-03', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 95, 'Migration: ' || 'UNREF-204');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-205' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-205', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 475 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZLTGR-33' OR product_name = 'PYLOX LAZER LIGHT GREEN 33') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER LIGHT GREEN 33', 'PLYZLTGR-33', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 95, 'Migration: ' || 'UNREF-205');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-206' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-206', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 648 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZHTRSIL-709' OR product_name = 'PYLOX LAZER HEAT RESISTANT SILVER 709') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'PLYZHTRSIL-709', v_branch_id, 0, 162) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 162);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 162, 'Migration: ' || 'UNREF-206');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-207' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-207', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1287 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGLD-705' OR product_name = 'PYLOX LAZER GOLD 705') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER GOLD 705', 'PLYZGLD-705', v_branch_id, 0, 117) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 117);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 117, 'Migration: ' || 'UNREF-207');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-208' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-208', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 95, 'Migration: ' || 'UNREF-208');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-209' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-209', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1215 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOUVIO-604' OR product_name = 'PYLOX LAZER FLOURESCENT VIOLET 604') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'PLYZFLOUVIO-604', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 135);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 135, 'Migration: ' || 'UNREF-209');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-210' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-210', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1215 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOURANGE-601' OR product_name = 'PYLOX LAZER FLOURESCENT ORANGE 601') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'PLYZFLOURANGE-601', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 135);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 135, 'Migration: ' || 'UNREF-210');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-211' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-211', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 405 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOURPNK-603' OR product_name = 'PYLOX LAZER FLOURESCENT PINK 603') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'PLYZFLOURPNK-603', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 135);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 135, 'Migration: ' || 'UNREF-211');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-212' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-212', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 570 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZDR-17' OR product_name = 'PYLOX LAZER DEEP RED 17') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER DEEP RED 17', 'PLYZDR-17', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 95, 'Migration: ' || 'UNREF-212');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-213' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-213', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1210 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCANRED-801' OR product_name = 'PYLOX LAZER CANDYTONE RED 801') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER CANDYTONE RED 801', 'PLYZCANRED-801', v_branch_id, 0, 110) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 110);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 110, 'Migration: ' || 'UNREF-213');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-214' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-214', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1170 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZDISIL-701' OR product_name = 'PYLOX LAZER DISTINGUISHED SILVER 701') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'PLYZDISIL-701', v_branch_id, 0, 117) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 117);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 117, 'Migration: ' || 'UNREF-214');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-215' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-215', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1140 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 95, 'Migration: ' || 'UNREF-215');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-216' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-216', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 760 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZAY-06' OR product_name = 'PYLOX LAZER ART YELLOW 06') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER ART YELLOW 06', 'PYLZAY-06', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 95, 'Migration: ' || 'UNREF-216');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-217' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-217', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 475 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZANTPR-12' OR product_name = 'PYLOX LAZER ANTI-RUST BROWN PRIMER 12') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'PYLZANTPR-12', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 95, 'Migration: ' || 'UNREF-217');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-218' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-218', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 312 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 12) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 26, 12);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 26, 12, 'Migration: ' || 'UNREF-218');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-219' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-219', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 330 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 15) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 22, 15);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 22, 15, 'Migration: ' || 'UNREF-219');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-220' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-220', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 40);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 40, 'Migration: ' || 'UNREF-220');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-221' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-221', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MPJOINTCMPND-5L' OR product_name = 'NIPPON MULTI-PURPOSE JOINT COMPOUND 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'MPJOINTCMPND-5L', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 400, 'Migration: ' || 'UNREF-221');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-222' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-222', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 217 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 31) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 31);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 31, 'Migration: ' || 'UNREF-222');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-223' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-223', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 891 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-4' OR product_name = 'DRAGONFLY PAINT BRUSH #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DRAGONFLY PAINT BRUSH #4', 'DPB-4', v_branch_id, 0, 99) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 99);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 99, 'Migration: ' || 'UNREF-223');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-224' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-224', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3507.604167 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 15.7291666666) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 223, 15.7291666666);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 223, 15.7291666666, 'Migration: ' || 'UNREF-224');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-225' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-225', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4671.5625 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 23.59375) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 198, 23.59375);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 198, 23.59375, 'Migration: ' || 'UNREF-225');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-226' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-226', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1920 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITSHLDALL-BOT' OR product_name = 'DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'DOITSHLDALL-BOT', v_branch_id, 0, 160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 160, 'Migration: ' || 'UNREF-226');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-227' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-227', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 990 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 495) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 495);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 495, 'Migration: ' || 'UNREF-227');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-228' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-228', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 150, 'Migration: ' || 'UNREF-228');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-229' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-229', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5265 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 585) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 585);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 585, 'Migration: ' || 'UNREF-229');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-230' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-230', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8624 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 308, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 308, 28, 'Migration: ' || 'UNREF-230');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-231' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-231', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1147 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 62, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 62, 18.5, 'Migration: ' || 'UNREF-231');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-232' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-232', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 945 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT2' OR product_name = 'CROCO MASKING TAPE #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #2', 'CRO-MT2', v_branch_id, 0, 63) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 63);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 63, 'Migration: ' || 'UNREF-232');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-233' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-233', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 37 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 18.5, 'Migration: ' || 'UNREF-233');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-234' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-234', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2627 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 142, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 142, 18.5, 'Migration: ' || 'UNREF-234');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-235' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-235', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7048.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 381, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 381, 18.5, 'Migration: ' || 'UNREF-235');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-236' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-236', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 647.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 35, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 35, 18.5, 'Migration: ' || 'UNREF-236');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-237' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-237', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4984 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 178, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 178, 28, 'Migration: ' || 'UNREF-237');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-238' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-238', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 1780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 1780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 1780, 'Migration: ' || 'UNREF-238');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-239' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-239', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2655 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4.5, 590);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4.5, 590, 'Migration: ' || 'UNREF-239');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-240' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-240', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2620 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT158' OR product_name = 'NAX NAT158 CINQUASIA VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'NAT158', v_branch_id, 0, 1310) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1310);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1310, 'Migration: ' || 'UNREF-240');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-241' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-241', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1688 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT705-1L' OR product_name = 'NAX NAT705 SUPER FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'NAT705-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 422, 'Migration: ' || 'UNREF-241');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-242' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-242', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2532 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT706-1L' OR product_name = 'NAX NAT706 MEDIUM COARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'NAT706-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 422, 'Migration: ' || 'UNREF-242');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-243' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-243', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2905 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT707-1L' OR product_name = 'NAX NAT707 HI-SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'NAT707-1L', v_branch_id, 0, 581) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 581);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 581, 'Migration: ' || 'UNREF-243');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-244' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-244', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2712.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 38.75, 70);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 38.75, 70, 'Migration: ' || 'UNREF-244');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-245' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-245', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 80.59 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-9033' OR product_name = 'PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT', 'PWTCO-9033', v_branch_id, 0, 80.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 80.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 80.59, 'Migration: ' || 'UNREF-245');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-246' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-246', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 80.59 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-6133' OR product_name = 'BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'PWTCO-6133', v_branch_id, 0, 80.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 80.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 80.59, 'Migration: ' || 'UNREF-246');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-247' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-247', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 72.02 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-4333' OR product_name = 'RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT', 'PWTCO-4333', v_branch_id, 0, 72.02) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 72.02);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 72.02, 'Migration: ' || 'UNREF-247');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-248' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-248', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 90.88 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-5033' OR product_name = 'HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM', 'PWTCO-5033', v_branch_id, 0, 90.88) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 90.88);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 90.88, 'Migration: ' || 'UNREF-248');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - MARCH 31, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-249' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-249', '2026-03-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4843.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEEKBOS-1L' OR product_name = 'MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'MEEKBOS-1L', v_branch_id, 0, 538.2) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 538.2);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 538.2, 'Migration: ' || 'UNREF-249');
  END;

END $MIGRATION$;
