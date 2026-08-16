-- Migration for Valencia Stock In Part 4
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
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-750' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-750', '2026-06-30', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-750');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-751' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-751', '2026-06-30', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-751');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-752' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-752', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT607' OR product_name = 'NAX PREMILA MT607 AUTUMN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'MT607', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-752');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-753' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-753', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.125, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.125, 0, 'Migration: ' || 'UNREF-753');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 680);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 680, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3280 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1640, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4113-4L' OR product_name = 'NIPPON EXTREME QDU RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU RED 4L', 'NXU4113-4L', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1800);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1800, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2280);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2280, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2360 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT003' OR product_name = 'NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'MT003', v_branch_id, 0, 2360) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2360);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2360, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 950, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-701' OR product_name = 'RAIN OR SHINE BAGUIO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'ROS-701', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 750, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004090' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004090', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGW-4L' OR product_name = 'POLYGLOSS PU GLEAMIST WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'PGGW-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1850, 'Migration: ' || 'CSI-004090');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004091' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004091', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3820 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 955) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 955);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 955, 'Migration: ' || 'CSI-004091');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004091' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004091', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-109' OR product_name = 'RAIN OR SHINE TULLE WHITE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE TULLE WHITE', 'ROS-109', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 750, 'Migration: ' || 'CSI-004091');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004091' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004091', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1100, 'Migration: ' || 'CSI-004091');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004091' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004091', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT503' OR product_name = 'NAX PREMILA MT503 THRENE RED G 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'MT503', v_branch_id, 0, 2300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2300);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2300, 'Migration: ' || 'CSI-004091');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004091' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004091', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 250);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 250, 'Migration: ' || 'CSI-004091');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-768' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-768', '2026-07-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901R-1L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'MEG3901R-1L', v_branch_id, 0, 200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 200, 'Migration: ' || 'UNREF-768');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-769' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-769', '2026-07-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1708 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.7, 2440);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.7, 2440, 'Migration: ' || 'UNREF-769');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-770' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-770', '2026-07-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 900, 'Migration: ' || 'UNREF-770');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-771' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-771', '2026-07-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2000, 'Migration: ' || 'UNREF-771');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-772' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-772', '2026-07-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.875, 3200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.875, 3200, 'Migration: ' || 'UNREF-772');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-773' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-773', '2026-07-02', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 200, 'Migration: ' || 'UNREF-773');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-774' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-774', '2026-07-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'UNREF-774');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-775' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-775', '2026-07-04', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 640, 'Migration: ' || 'UNREF-775');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-776' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-776', '2026-07-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'UNREF-776');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-777' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-777', '2026-07-04', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1110, 'Migration: ' || 'UNREF-777');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-778' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-778', '2026-07-04', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-778');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-779' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-779', '2026-07-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 900, 'Migration: ' || 'UNREF-779');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-780' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-780', '2026-07-07', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 900, 'Migration: ' || 'UNREF-780');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-781' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-781', '2026-07-10', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-15L' OR product_name = 'LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'LATEXMIX-15L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3200, 'Migration: ' || 'UNREF-781');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-782' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-782', '2026-07-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 40 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 40);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 40, 'Migration: ' || 'UNREF-782');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-783' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-783', '2026-07-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2160, 'Migration: ' || 'UNREF-783');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-784' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-784', '2026-07-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 525 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-1L' OR product_name = 'NAX NAT-1OO TTC WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1OO TTC WHITE 1L', 'NAT100-1L', v_branch_id, 0, 525) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 525);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 525, 'Migration: ' || 'UNREF-784');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-785' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-785', '2026-07-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-15L' OR product_name = 'NIPPON DOU CLASSIC SG WHITE 715 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'DCSG715-15L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-785');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-786' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-786', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.75, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.75, 0, 'Migration: ' || 'UNREF-786');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-787' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-787', '2026-07-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 103 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-20-1L' OR product_name = 'THALO BLUE ACRY-COLOR AC-20 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'AC-20-1L', v_branch_id, 0, 103) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 103);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 103, 'Migration: ' || 'UNREF-787');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-788' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-788', '2026-07-09', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALCROLTC -THALO BLUE-1L' OR product_name = 'ALPHA CROMA LTC THALO BLUE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CROMA LTC THALO BLUE', 'ALCROLTC -THALO BLUE-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-788');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-789' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-789', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-789');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-790' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-790', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGO-4L' OR product_name = 'POLYGLOSS PU GLEAMIST ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'PGGO-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-790');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-791' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-791', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGY-4L' OR product_name = 'POLYGLOSS PU GLEAMIST YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'PGGY-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-791');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-792' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-792', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-792');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-793' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-793', '2026-07-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1372' OR product_name = 'NIPPELAC ACE LEMON YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'NPA1372', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-793');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-794' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-794', '2026-07-14', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1587-4L' OR product_name = 'NIPPON EXTREME QDU BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLUE 4L', 'NXU1587-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-794');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-795' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-795', '2026-07-14', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-795');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-796' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-796', '2026-07-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-15L' OR product_name = 'NIPPON DOU CLASSIC SG WHITE 715 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'DCSG715-15L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-796');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-797' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-797', '2026-07-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALCROLTC -THALO BLUE-1L' OR product_name = 'ALPHA CROMA LTC THALO BLUE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CROMA LTC THALO BLUE', 'ALCROLTC -THALO BLUE-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 0, 'Migration: ' || 'UNREF-797');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-798' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-798', '2026-07-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-10-1L' OR product_name = 'TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'AC-10-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-798');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-799' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-799', '2026-07-15', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-823' OR product_name = 'VIBRANT RUBY ROS-823 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('VIBRANT RUBY ROS-823 RAIN OR SHINE 4L', 'ROS-823', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-799');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-800' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-800', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 940 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1161' OR product_name = 'NAX NAT-1161 TTC LAVENDER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'NAT1161', v_branch_id, 0, 940) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 940);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 940, 'Migration: ' || 'UNREF-800');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-801' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-801', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13440 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 560);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 560, 'Migration: ' || 'UNREF-801');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-802' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-802', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 875 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 875) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 875);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 875, 'Migration: ' || 'UNREF-802');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-803' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-803', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1910 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 955) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 955);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 955, 'Migration: ' || 'UNREF-803');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-804' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-804', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3240 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NLT-4L' OR product_name = 'NIPPON LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON LACQUER THINNER 4L', 'NLT-4L', v_branch_id, 0, 540) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 540);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 540, 'Migration: ' || 'UNREF-804');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-805' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-805', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 980 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1159' OR product_name = 'NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'NAT1159', v_branch_id, 0, 980) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 980);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 980, 'Migration: ' || 'UNREF-805');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-806' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-806', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1980 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 165) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 165);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 165, 'Migration: ' || 'UNREF-806');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-807' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-807', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4080 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 680);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 680, 'Migration: ' || 'UNREF-807');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-808' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-808', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 590);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 590, 'Migration: ' || 'UNREF-808');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-809' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-809', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 450, 'Migration: ' || 'UNREF-809');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-810' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-810', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 525 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-1L' OR product_name = 'NAX NAT-1OO TTC WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1OO TTC WHITE 1L', 'NAT100-1L', v_branch_id, 0, 525) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 525);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 525, 'Migration: ' || 'UNREF-810');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-811' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-811', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 130 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALCROLTC -THALO BLUE-1L' OR product_name = 'ALPHA CROMA LTC THALO BLUE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CROMA LTC THALO BLUE', 'ALCROLTC -THALO BLUE-1L', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 130);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 130, 'Migration: ' || 'UNREF-811');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-812' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-812', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1850, 'Migration: ' || 'UNREF-812');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-813' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-813', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGO-4L' OR product_name = 'POLYGLOSS PU GLEAMIST ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'PGGO-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3200, 'Migration: ' || 'UNREF-813');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-814' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-814', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGY-4L' OR product_name = 'POLYGLOSS PU GLEAMIST YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'PGGY-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3200, 'Migration: ' || 'UNREF-814');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-815' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-815', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1640 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1640, 'Migration: ' || 'UNREF-815');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-816' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-816', '2026-07-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-816');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-817' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-817', '2026-07-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-817');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-818' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-818', '2026-07-16', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT530' OR product_name = 'NAX NAT-530 TTC FINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'NAT530', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-818');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-819' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-819', '2026-07-17', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.25, 0, 'Migration: ' || 'UNREF-819');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-820' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-820', '2026-07-18', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITBLACK-4L' OR product_name = 'DO IT URETHANE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE BLACK 4L', 'DOITBLACK-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-820');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-821' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-821', '2026-07-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-821');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-822' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-822', '2026-07-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-822');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-823' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-823', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-823');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-824' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-824', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.5, 0, 'Migration: ' || 'UNREF-824');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-825' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-825', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5.825, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5.825, 0, 'Migration: ' || 'UNREF-825');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-826' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-826', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.375, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.375, 0, 'Migration: ' || 'UNREF-826');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-827' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-827', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 0, 'Migration: ' || 'UNREF-827');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-828' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-828', '2026-07-22', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || 'UNREF-828');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-829' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-829', '2026-07-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-15L' OR product_name = 'LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'LATEXMIX-15L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 0, 'Migration: ' || 'UNREF-829');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-830' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-830', '2026-07-20', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 35 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 35);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 35, 'Migration: ' || 'UNREF-830');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-831' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-831', '2026-07-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 100, 'Migration: ' || 'UNREF-831');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-832' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-832', '2026-07-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-832');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-833' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-833', '2026-07-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT136' OR product_name = 'NAX PREMILA MT136 METALLIC ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'MT136', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-833');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-834' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-834', '2026-07-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT083' OR product_name = 'NAX PREMILA MT083 MICA BASE 4R RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'MT083', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-834');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-835' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-835', '2026-07-21', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-835');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-836' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-836', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-836');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-837' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-837', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.825, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.825, 0, 'Migration: ' || 'UNREF-837');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-838' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-838', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-838');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-839' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-839', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.25, 0, 'Migration: ' || 'UNREF-839');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-840' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-840', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGAR-4L' OR product_name = 'POLYGLOSS PU APPLE RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU APPLE RED 4L', 'PGAR-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-840');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALCROLTC -THALO BLUE-1L' OR product_name = 'ALPHA CROMA LTC THALO BLUE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CROMA LTC THALO BLUE', 'ALCROLTC -THALO BLUE-1L', v_branch_id, 0, 150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 150, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYPRIMER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE PRIMER WHITE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'ACRYPRIMER-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 950, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 850, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1000, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 650, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 28.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 28.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 28.5, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 230);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 230, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 175) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 175);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 175, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTB-47' OR product_name = 'PYLOX MATT BLACK#47') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX MATT BLACK#47', 'PLYZMTB-47', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 90);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 90, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004106' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004106', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2450 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGAR-4L' OR product_name = 'POLYGLOSS PU APPLE RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU APPLE RED 4L', 'PGAR-4L', v_branch_id, 0, 2450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2450, 'Migration: ' || 'CSI-004106');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-851' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-851', '2026-07-25', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.125, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.125, 0, 'Migration: ' || 'UNREF-851');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.875, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.875, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1587-4L' OR product_name = 'NIPPON EXTREME QDU BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLUE 4L', 'NXU1587-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1750' OR product_name = 'REDUCER ACRYTEX B-1750 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('REDUCER ACRYTEX B-1750 BOYSEN 4L', 'B-1750', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.25, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZANTPR-12' OR product_name = 'PYLOX LAZER ANTI-RUST BROWN PRIMER 12') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'PYLZANTPR-12', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.075, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.075, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT003' OR product_name = 'NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'MT003', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-861' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-861', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-861');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-862' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-862', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.84375, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.84375, 0, 'Migration: ' || 'UNREF-862');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-863' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-863', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGW-4L' OR product_name = 'POLYGLOSS PU GLEAMIST WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'PGGW-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-863');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-864' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-864', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGGO-4L' OR product_name = 'POLYGLOSS PU GLEAMIST ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'PGGO-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-864');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-865' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-865', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.84375, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.84375, 0, 'Migration: ' || 'UNREF-865');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-866' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-866', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-866');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-867' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-867', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-4L' OR product_name = 'EXTREME QDU MIXING 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 4L', 'EXTREMEMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.375, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.375, 0, 'Migration: ' || 'UNREF-867');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-868' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-868', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-868');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-869' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-869', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-869');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFI46G-5KG' OR product_name = 'NIPPON FLEXI-SEAL 146 GRAY 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'NFI46G-5KG', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-871' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-871', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.875, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.875, 0, 'Migration: ' || 'UNREF-871');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBPNTSTRNR' OR product_name = 'ROBFILTER PAINT STRAINER 125M') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBFILTER PAINT STRAINER 125M', 'ROBPNTSTRNR', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-873' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-873', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.75, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.75, 0, 'Migration: ' || 'UNREF-873');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-874' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-874', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.625, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.625, 0, 'Migration: ' || 'UNREF-874');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT134' OR product_name = 'NAX PREMILA MT134 METALLIC GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'MT134', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-876' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-876', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT081' OR product_name = 'NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'MT081', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-876');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-877' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-877', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT075' OR product_name = 'NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'MT075', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-877');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-878' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-878', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT068' OR product_name = 'NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'MT068', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-878');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-109' OR product_name = 'RAIN OR SHINE TULLE WHITE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE TULLE WHITE', 'ROS-109', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1372' OR product_name = 'NIPPELAC ACE LEMON YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'NPA1372', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1983' OR product_name = 'NIPPELAC ACE JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE JET BLACK 4L', 'NPA1983', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.75, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.75, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT904' OR product_name = 'NAX PREMILA MT904 SHADOWN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'MT904', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT704' OR product_name = 'NAX PREMILA MT704 FINE VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'MT704', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT604' OR product_name = 'NAX PREMILA MT604 EXTRA MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'MT604', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT602' OR product_name = 'NAX PREMILA MT602 PEGASUS MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'MT602', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT501' OR product_name = 'NAX PREMILA MT501 STRONG RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'MT501', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-887' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-887', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYLICMIX-1L' OR product_name = 'ACRYLIC NP, TIMEOUT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ACRYLIC NP, TIMEOUT 1L', 'ACRYLICMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 0, 'Migration: ' || 'UNREF-887');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-888' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-888', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 29.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 29.25, 0, 'Migration: ' || 'UNREF-888');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-889' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-889', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.25, 0, 'Migration: ' || 'UNREF-889');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUT3050-4KG' OR product_name = 'NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'PUT3050-4KG', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-LTR' OR product_name = 'NIPPON METAL PRIMER RED OXIDE LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'NMPREDOX-LTR', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-892' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-892', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.9375, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.9375, 0, 'Migration: ' || 'UNREF-892');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-893' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-893', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-893');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXUMAGENTA-4L' OR product_name = 'NIPPON EXTREME MAGENTA 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME MAGENTA 4L', 'NXUMAGENTA-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-896' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-896', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 0, 'Migration: ' || 'UNREF-896');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-897' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-897', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.625, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.625, 0, 'Migration: ' || 'UNREF-897');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-898' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-898', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1161' OR product_name = 'NAX NAT-1161 TTC LAVENDER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'NAT1161', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.75, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.75, 0, 'Migration: ' || 'UNREF-898');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-899' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-899', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYLICMIX-1L' OR product_name = 'ACRYLIC NP, TIMEOUT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ACRYLIC NP, TIMEOUT 1L', 'ACRYLICMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9.5, 0, 'Migration: ' || 'UNREF-899');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-900' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-900', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 16.75, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 16.75, 0, 'Migration: ' || 'UNREF-900');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-901' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-901', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 29.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 29.25, 0, 'Migration: ' || 'UNREF-901');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-902' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-902', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 28.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 28.5, 0, 'Migration: ' || 'UNREF-902');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-903' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-903', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 0, 'Migration: ' || 'UNREF-903');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-904' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-904', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 32.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 32.5, 0, 'Migration: ' || 'UNREF-904');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-905' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-905', '2026-07-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-1L' OR product_name = 'GLAZER AUTO ENAMEL MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTO ENAMEL MIX 1L', 'AEMIX-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 0, 'Migration: ' || 'UNREF-905');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 24-25, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY - JUNE 24-25, 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-24-INV_06' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-24-INV_06', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 0, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 16, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 16, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY-JULY 27-28 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('INVENTORY-JULY 27-28 2026', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = '2026-27-INV_07' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, '2026-27-INV_07', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || '2026-27-INV_07');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1050 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-1L' OR product_name = 'NAX NAT-1OO TTC WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1OO TTC WHITE 1L', 'NAT100-1L', v_branch_id, 0, 525) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 525);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 525, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'GLAZERB-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 850, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 6150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 6150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 6150, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1905 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 1905) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1905);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1905, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2010 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 2010) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2010);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2010, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2280);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2280, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004115' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004115', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 11700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 975) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 975);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 975, 'Migration: ' || 'CSI-004115');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CS-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CS-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 13440 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 560);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 560, 'Migration: ' || 'CS-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 11880 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 660, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1280 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1280);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1280, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-223' OR product_name = 'RAIN OR SHINE NICOLE PINK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE NICOLE PINK 4L', 'ROS-223', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 750, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1800);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1800, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 955 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 955) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 955);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 955, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HDOIT' OR product_name = 'DO IT HARDENER 2K TOP COAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT HARDENER 2K TOP COAT', 'HDOIT', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 250);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 250, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYPRIMER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE PRIMER WHITE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'ACRYPRIMER-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 950, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004114' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004114', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 80 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALPHAC-RS-CAN' OR product_name = 'ALPHA CHROMA OTC RAW SEINA 1CAN') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA OTC RAW SEINA 1CAN', 'ALPHAC-RS-CAN', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 80);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 80, 'Migration: ' || 'CSI-004114');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-932' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-932', '2026-07-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-932');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-933' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-933', '2026-07-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-933');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-934' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-934', '2026-07-28', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-934');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-935' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-935', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYPRIMER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE PRIMER WHITE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'ACRYPRIMER-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-935');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-936' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-936', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALPHAC-RS-CAN' OR product_name = 'ALPHA CHROMA OTC RAW SEINA 1CAN') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA OTC RAW SEINA 1CAN', 'ALPHAC-RS-CAN', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-936');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-937' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-937', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-937');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-938' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-938', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'XTRMEQDWARMYLW-4L' OR product_name = 'NIPPON EXTREME QDU WARM YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'XTRMEQDWARMYLW-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-938');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-939' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-939', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDCB-4L' OR product_name = 'PLATONE QDE CHOCOLATE BROWN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'PLQDCB-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-939');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-940' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-940', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-940');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-941' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-941', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-941');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-942' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-942', '2026-07-31', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-942');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-943' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-943', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-943');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-944' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-944', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-944');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-945' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-945', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 0, 'Migration: ' || 'UNREF-945');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-946' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-946', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-946');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-947' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-947', '2026-08-01', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-947');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-948' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-948', '2026-08-03', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-40-1L' OR product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'AC-40-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-948');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-949' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-949', '2026-08-03', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-949');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-950' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-950', '2026-08-03', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT602' OR product_name = 'NAX PREMILA MT602 PEGASUS MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'MT602', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-950');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-951' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-951', '2026-08-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXUMAGENTA-4L' OR product_name = 'NIPPON EXTREME MAGENTA 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME MAGENTA 4L', 'NXUMAGENTA-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-951');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004118' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004118', '2026-08-03', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3960 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 660, 'Migration: ' || 'CSI-004118');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004118' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004118', '2026-08-03', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 750, 'Migration: ' || 'CSI-004118');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1970 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 1970) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1970);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1970, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3960 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 660, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2010 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 2010) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2010);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2010, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1000, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2100 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT701' OR product_name = 'NAX PREMILA MT701 FAST VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'MT701', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6720 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 560);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 560, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDW-4L' OR product_name = 'PLATONE QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE WHITE 4L', 'PLQDW-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 700);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 700, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004120' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004120', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 864 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GAETB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L', 'GAETB-4L', v_branch_id, 0, 864) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 864);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 864, 'Migration: ' || 'CSI-004120');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004125' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004125', '2026-08-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 750 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 750);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 750, 'Migration: ' || 'CSI-004125');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004125' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004125', '2026-08-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3960 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 660, 'Migration: ' || 'CSI-004125');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004125' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004125', '2026-08-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5520 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 460) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 460);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 460, 'Migration: ' || 'CSI-004125');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-965' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-965', '2026-08-04', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT023' OR product_name = 'NAX PREMILA MT023 HIGH SPARKLE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'MT023', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-965');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-966' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-966', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-966');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-967' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-967', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXUCINQVIO-4L' OR product_name = 'NIPPON EXTREME CINQUASA VIOLET 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME CINQUASA VIOLET 4L', 'NXUCINQVIO-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-967');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-968' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-968', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-968');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-969' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-969', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-969');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-970' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-970', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT701' OR product_name = 'NAX PREMILA MT701 FAST VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'MT701', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-970');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-971' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-971', '2026-08-05', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-971');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-972' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-972', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDW-4L' OR product_name = 'PLATONE QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE WHITE 4L', 'PLQDW-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-972');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-973' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-973', '2026-08-06', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GAETB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L', 'GAETB-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-973');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-974' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-974', '2026-08-07', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-4L' OR product_name = 'NAX PREMILA MT100 WHITE HS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'MT100-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-974');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-975' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-975', '2026-08-07', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-1L' OR product_name = 'NAX PREMILA MT100 WHITE HS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'MT100-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-975');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-976' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-976', '2026-08-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT321' OR product_name = 'NAX NAT-321 TTC HOSTAPERM YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'NAT321', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-976');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-977' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-977', '2026-08-08', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-977');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-978' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-978', '2026-08-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-978');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-979' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-979', '2026-08-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.25, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.25, 0, 'Migration: ' || 'UNREF-979');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-980' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-980', '2026-08-11', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-980');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-981' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-981', '2026-08-12', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT715-1L' OR product_name = 'NAX NAT-715 TTC FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'NAT715-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-981');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-982' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-982', '2026-08-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-982');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-983' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-983', '2026-08-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1158' OR product_name = 'NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'NAT1158', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-983');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-984' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-984', '2026-08-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-984');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-985' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-985', '2026-08-13', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOURANGE-601' OR product_name = 'PYLOX LAZER FLOURESCENT ORANGE 601') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'PLYZFLOURANGE-601', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-985');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-986' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-986', '2026-08-14', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-986');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-987' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-987', '2026-08-14', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-987');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-988' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-988', '2026-08-14', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-988');
  END;

END $MIGRATION$;
