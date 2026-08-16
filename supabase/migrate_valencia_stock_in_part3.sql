-- Migration for Valencia Stock In Part 3
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
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-500' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-500', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 465 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYLICMIX-1L' OR product_name = 'ACRYLIC NP, TIMEOUT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ACRYLIC NP, TIMEOUT 1L', 'ACRYLICMIX-1L', v_branch_id, 0, 310) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.5, 310);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.5, 310, 'Migration: ' || 'UNREF-500');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-501' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-501', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-4L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'LATEXMIX-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 900, 'Migration: ' || 'UNREF-501');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-502' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-502', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.75, 240);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.75, 240, 'Migration: ' || 'UNREF-502');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-503' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-503', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 23625 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.5625, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.5625, 3600, 'Migration: ' || 'UNREF-503');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-504' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-504', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 32467.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 36.075, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 36.075, 900, 'Migration: ' || 'UNREF-504');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-505' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-505', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 9125 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18.25, 500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18.25, 500, 'Migration: ' || 'UNREF-505');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-506' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-506', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 509.375 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4113-4L' OR product_name = 'NIPPON EXTREME QDU RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU RED 4L', 'NXU4113-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.3125, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.3125, 1630, 'Migration: ' || 'UNREF-506');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-507' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-507', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 280 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERW-1L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L', 'GLAZERW-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 280);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 280, 'Migration: ' || 'UNREF-507');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-508' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-508', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1485, 'Migration: ' || 'UNREF-508');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-509' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-509', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'UNREF-509');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-510' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-510', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-510');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-511' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-511', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-511');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-512' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-512', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1400, 'Migration: ' || 'UNREF-512');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-513' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-513', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-513');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCK TO SALES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('FROM STOCK TO SALES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-514' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-514', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2440, 'Migration: ' || 'UNREF-514');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-515' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-515', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 32, 'Migration: ' || 'UNREF-515');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 12600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 700);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 700, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 24, 600, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 12, 500, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1950 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 19.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 19.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 19.5, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 28, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 100, 28, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 850, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- HAPPY DAYS-4L' OR product_name = 'RAIN OR SHINE- HAPPY DAYS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'ROS- HAPPY DAYS-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 850, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-862' OR product_name = 'RAIN OR SHINE IVORY 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE IVORY 4L', 'ROS-862', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 850, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004078' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004078', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1600, 'Migration: ' || 'CSI-004078');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004079' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004079', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT103' OR product_name = 'NAX PREMILA MT103 WHITE LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'MT103', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1500, 'Migration: ' || 'CSI-004079');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004079' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004079', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4800 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 800);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 800, 'Migration: ' || 'CSI-004079');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004079' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004079', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3360 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NLT-4L' OR product_name = 'NIPPON LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON LACQUER THINNER 4L', 'NLT-4L', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 560);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 560, 'Migration: ' || 'CSI-004079');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004079' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004079', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT805' OR product_name = 'NAX PREMILA MT805 CUSTOM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'MT805', v_branch_id, 0, 2200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2200, 'Migration: ' || 'CSI-004079');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004079' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004079', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 10400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2600, 'Migration: ' || 'CSI-004079');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6500 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 100, 65);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 100, 65, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 850 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 850, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2340 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 195) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 195);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 195, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 2300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2300);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2300, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1000, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1850, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004080' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004080', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 855 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GAETB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L', 'GAETB-4L', v_branch_id, 0, 855) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 855);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 855, 'Migration: ' || 'CSI-004080');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('APC DISTRIBUTION - VALENCIA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-004084' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-004084', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 16200 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1350);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1350, 'Migration: ' || 'CSI-004084');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1344.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-100' OR product_name = 'WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L', 'ROS-SR-100', v_branch_id, 0, 672.4) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 672.4);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 672.4, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 570 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WQD1150-4L' OR product_name = 'WELCOAT REGULAR QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'WQD1150-4L', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 570);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 570, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 507.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7.25, 70);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7.25, 70, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 62 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 62) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 62);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 62, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 50, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 104 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOPT-BOT' OR product_name = 'UNO PAINT THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO PAINT THINNER BOT', 'UNOPT-BOT', v_branch_id, 0, 52) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 52);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 52, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 324 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-10-1L' OR product_name = 'TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'AC-10-1L', v_branch_id, 0, 108) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 108);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 108, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4095 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 585) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 585);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 585, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2250 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 45, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 45, 50, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 103 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-30-1L' OR product_name = 'THALO GREEN ACRY-COLOR AC-30 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('THALO GREEN ACRY-COLOR AC-30 1L DAVIES', 'AC-30-1L', v_branch_id, 0, 103) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 103);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 103, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 103 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-20-1L' OR product_name = 'THALO BLUE ACRY-COLOR AC-20 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'AC-20-1L', v_branch_id, 0, 103) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 103);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 103, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4480 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 160, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 160, 28, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3052 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA100' OR product_name = 'SAND PAPER #100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('SAND PAPER #100', 'EA100', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 109, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 109, 28, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 198 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'RUGBY' OR product_name = 'RUGBY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RUGBY', 'RUGBY', v_branch_id, 0, 66) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 66);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 66, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2730 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.5, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.5, 780, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 230 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-90-1L' OR product_name = 'RAW SIENNA ACRY-COLOR AC-90 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAW SIENNA ACRY-COLOR AC-90 1L DAVIES', 'AC-90-1L', v_branch_id, 0, 115) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 115);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 115, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2553 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 851) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 851);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 851, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-15L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'QSHG710-15L', v_branch_id, 0, 2442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 2442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 2442, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 190 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 190 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSKBL-22' OR product_name = 'PYLOX LAZER SKY BLUE 22') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER SKY BLUE 22', 'PLYZSKBL-22', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 190 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 95 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTW-03' OR product_name = 'PYLOX LAZER MATT WHITE 03') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER MATT WHITE 03', 'PLYZMTW-03', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 95 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZLTGR-33' OR product_name = 'PYLOX LAZER LIGHT GREEN 33') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER LIGHT GREEN 33', 'PLYZLTGR-33', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1235 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 13, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 13, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 135 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOUVIO-604' OR product_name = 'PYLOX LAZER FLOURESCENT VIOLET 604') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'PLYZFLOUVIO-604', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 135);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 135, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZFLOURANGE-601' OR product_name = 'PYLOX LAZER FLOURESCENT ORANGE 601') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'PLYZFLOURANGE-601', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 135);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 135, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 190 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 95, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCANRED-801' OR product_name = 'PYLOX LAZER CANDYTONE RED 801') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER CANDYTONE RED 801', 'PLYZCANRED-801', v_branch_id, 0, 110) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 110);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 110, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3290 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTOPC-1L' OR product_name = 'POLYGLOSS TOP COAT W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS TOP COAT W/H', 'PGTOPC-1L', v_branch_id, 0, 470) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 470);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 470, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 306.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 2450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.125, 2450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.125, 2450, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2508 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 836) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 836);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 836, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1396 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDRB-4L' OR product_name = 'PLATONE QDE ROYAL BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLQDRB-4L', v_branch_id, 0, 698) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 698);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 698, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 289.1875 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.4375, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.4375, 661, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 480 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 40);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 40, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2362.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 45) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 52.5, 45);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 52.5, 45, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 1200);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 1200, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 515 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 515) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 515);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 515, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 435 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NLT-4L' OR product_name = 'NIPPON LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON LACQUER THINNER 4L', 'NLT-4L', v_branch_id, 0, 435) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 435);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 435, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 550, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1845 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 615, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 620 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'OTH10AD-1L' OR product_name = 'NIPPON FLATTENING AGENT PASTE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLATTENING AGENT PASTE 1L', 'OTH10AD-1L', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 620);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 620, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 193.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.125, 1550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.125, 1550, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'XTRMEQDWARMYLW-4L' OR product_name = 'NIPPON EXTREME QDU WARM YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'XTRMEQDWARMYLW-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2088.28125 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.40625, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.40625, 1485, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4872.65625 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1485) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.28125, 1485);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.28125, 1485, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 720 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-5L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'DCF701-5L', v_branch_id, 0, 360) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 360);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 360, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2250 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 450, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 667.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 445) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.5, 445);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.5, 445, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 314.4 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 786) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.4, 786);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.4, 786, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 5150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1030, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1561 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT903' OR product_name = 'NAX PREMILA MT903 SUN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'MT903', v_branch_id, 0, 1561) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1561);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1561, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1593 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT805' OR product_name = 'NAX PREMILA MT805 CUSTOM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'MT805', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1593 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1593 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT803' OR product_name = 'NAX PREMILA MT803 FRESH BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'MT803', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4096 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT607' OR product_name = 'NAX PREMILA MT607 AUTUMN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'MT607', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2048, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4096 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT604' OR product_name = 'NAX PREMILA MT604 EXTRA MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'MT604', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2048, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4604 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT602' OR product_name = 'NAX PREMILA MT602 PEGASUS MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'MT602', v_branch_id, 0, 2302) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2302);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2302, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2867 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT507' OR product_name = 'NAX PREMILA MT507 RUBY RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'MT507', v_branch_id, 0, 2867) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2867);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2867, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT301' OR product_name = 'NAX PREMILA MT301 MAPICO YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'MT301', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 1896, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1090 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-4L' OR product_name = 'NAX PREMILA MT100 WHITE HS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'MT100-4L', v_branch_id, 0, 4160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 4160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 4160, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2180 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-1L' OR product_name = 'NAX PREMILA MT100 WHITE HS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'MT100-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1090, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT083' OR product_name = 'NAX PREMILA MT083 MICA BASE 4R RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'MT083', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT081' OR product_name = 'NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'MT081', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 3000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT078' OR product_name = 'NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'MT078', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06A' OR product_name = 'NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'MT06A', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3650, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT068' OR product_name = 'NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'MT068', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 6000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT067' OR product_name = 'NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'MT067', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT061' OR product_name = 'NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'MT061', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT051' OR product_name = 'NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'MT051', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT028' OR product_name = 'NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'MT028', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT004' OR product_name = 'NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'MT004', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 190 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 190) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 190);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 190, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1328.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1518) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.875, 1518);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.875, 1518, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2454 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-1L' OR product_name = 'NAX NAT-990 TTC BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 1L', 'NAT990-1L', v_branch_id, 0, 409) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 409);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 409, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 830 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT745' OR product_name = 'NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'NAT745', v_branch_id, 0, 830) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 830);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 830, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 940 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT740' OR product_name = 'NAX NAT-740 TTC ULTRA FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'NAT740', v_branch_id, 0, 470) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 470);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 470, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2325 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-4L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'NAT719-4L', v_branch_id, 0, 2325) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2325);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2325, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 422 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT715-1L' OR product_name = 'NAX NAT-715 TTC FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'NAT715-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 422, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4067 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT712-1L' OR product_name = 'NAX NAT-712 TTC MEDIUM FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'NAT712-1L', v_branch_id, 0, 581) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 581);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 581, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 422 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT705-1L' OR product_name = 'NAX NAT705 SUPER FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'NAT705-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 422, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 620 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT556' OR product_name = 'NAX NAT-556 TTC BLUE NO.8 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'NAT556', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 620);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 620, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 683 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT410' OR product_name = 'NAX NAT-410 TTC CYANINE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'NAT410', v_branch_id, 0, 683) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 683);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 683, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT390' OR product_name = 'NAX NAT-390 TTC IRON YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'NAT390', v_branch_id, 0, 367) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 367);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 367, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT320' OR product_name = 'NAX NAT-320 TTC GOLD YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'NAT320', v_branch_id, 0, 425) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 425);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 425, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1380 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT305' OR product_name = 'NAX NAT-305 TTC GREEN YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'NAT305', v_branch_id, 0, 1380) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1380);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1380, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT147' OR product_name = 'NAX NAT-147 TTC THRENE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'NAT147', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1120, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1965 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1304' OR product_name = 'NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'NAT1304', v_branch_id, 0, 1965) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1965);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1965, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1160' OR product_name = 'NAX NAT-1160 TTC RED COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'NAT1160', v_branch_id, 0, 694) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 694);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 694, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2400 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-4L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'NAT1110-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2400, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1107' OR product_name = 'NAX NAT-1107 TTC FINE RED MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'NAT1107', v_branch_id, 0, 779) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 779);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 779, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 863 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1106' OR product_name = 'NAX NAT-1106 TTC PEARL BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'NAT1106', v_branch_id, 0, 863) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 863);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 863, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 442 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX1062' OR product_name = 'NAX NAT-1062 QDU 040 SUPER WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'NAX1062', v_branch_id, 0, 442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 442, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 660 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE4090' OR product_name = 'NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'NXE4090', v_branch_id, 0, 1320) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 1320);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 1320, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1050 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1050, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4731.705 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 363) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 13.035, 363);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 13.035, 363, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7826 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 344) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 22.75, 344);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 22.75, 344, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6900 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 460) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 460);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 460, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1292.2 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.82, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.82, 710, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 723.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 193) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.75, 193);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.75, 193, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4281.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.25, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.25, 685, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3017.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4.25, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4.25, 710, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 15 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 15) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 15);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 15, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1760 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-701-4L' OR product_name = 'FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L', 'B-701-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2.75, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2.75, 640, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 645.3 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-678' OR product_name = 'GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L', 'ROS-678', v_branch_id, 0, 645.3) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 645.3);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 645.3, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1568 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 56, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 56, 28, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3163.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 171, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 171, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 740 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 40, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 40, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1512 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 54, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 54, 28, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 814 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 44, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 44, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1572.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 85, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 85, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 504 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 28) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 28);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 28, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1443 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 78, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 78, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1387.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 75, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 75, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2442 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 132, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 132, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 92.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 18.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 18.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 18.5, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 396 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-4' OR product_name = 'DRAGONFLY PAINT BRUSH #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DRAGONFLY PAINT BRUSH #4', 'DPB-4', v_branch_id, 0, 99) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 99);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 99, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4083.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 495) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8.25, 495);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8.25, 495, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 150, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 885 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.5, 590);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.5, 590, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2205 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITBLACK-4L' OR product_name = 'DO IT URETHANE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT URETHANE BLACK 4L', 'DOITBLACK-4L', v_branch_id, 0, 2205) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2205);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2205, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 320 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITSHLDALL-BOT' OR product_name = 'DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'DOITSHLDALL-BOT', v_branch_id, 0, 160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 160, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3690 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 820) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4.5, 820);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4.5, 820, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 95 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TC-60-1/4L' OR product_name = 'DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L', 'TC-60-1/4L', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 399 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TCLT-11-1L' OR product_name = 'DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L', 'TCLT-11-1L', v_branch_id, 0, 399) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 399);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 399, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 381.6 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 42.4) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 42.4);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 42.4, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 626.22 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 44.73) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 14, 44.73);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 14, 44.73, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 193.76 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 55.36) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3.5, 55.36);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3.5, 55.36, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1034.295 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 39.03) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 26.5, 39.03);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 26.5, 39.03, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3161.06 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 23.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 134, 23.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 134, 23.59, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 629.2 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 15.73) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 40, 15.73);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 40, 15.73, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 126 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT2' OR product_name = 'CROCO MASKING TAPE #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #2', 'CRO-MT2', v_branch_id, 0, 63) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 63);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 63, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 64 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 32) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 32);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 32, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 80.59 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-6133' OR product_name = 'BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'PWTCO-6133', v_branch_id, 0, 80.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 80.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 80.59, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2460 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B1490-1L' OR product_name = 'BOYSEN LTC LAMP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN LTC LAMP BLACK 1L', 'B1490-1L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 615, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 577 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-182' OR product_name = 'BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L', 'ROS-SR-182', v_branch_id, 0, 577) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 577);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 577, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4895 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1705' OR product_name = 'ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'B-1705', v_branch_id, 0, 979) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 979);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 979, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 620 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 62) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 62);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 62, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 840 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 35);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 35, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 65 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 65);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 65, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7564 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 496) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15.25, 496);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 15.25, 496, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1470 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'RSW-4L' OR product_name = 'RAIN OR SHINE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE WHITE 4L', 'RSW-4L', v_branch_id, 0, 735) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 735);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 735, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 125 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 25);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 25, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 81.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.125, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.125, 650, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 198 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 18) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 18);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 18, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2600 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PZPG-1L' OR product_name = 'POLYGLOSS-ZINCROMATE PRIMER GREEN-1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'PZPG-1L', v_branch_id, 0, 520) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 520);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 520, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALPHAGLOSS-4L' OR product_name = 'ALPHA CHROMA ACRYTILE GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'ALPHAGLOSS-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 70 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BBR-MINI' OR product_name = 'DRAGONFLY MINI BABY ROLLER #4 W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'BBR-MINI', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 35);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 35, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 125 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 25);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 25, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 65 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PTRL-7' OR product_name = 'DRAGONFLY PAINT ROLLER #7 W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'PTRL-7', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 65);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 65, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1607.34375 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 1905) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.84375, 1905);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.84375, 1905, 'Migration: ' || '2026-24-INV_06');

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
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 451) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0, 451);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0, 451, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1344 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SR-100' OR product_name = 'WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L', 'ROS-SR-100', v_branch_id, 0, 672) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 672);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 672, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1352.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 773) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.75, 773);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.75, 773, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 80.59 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-9033' OR product_name = 'PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT', 'PWTCO-9033', v_branch_id, 0, 80.59) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 80.59);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 80.59, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 342 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 18) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 19, 18);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 19, 18, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8120 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FF151' OR product_name = 'NIPPON FF151 FLOP CONTROL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FF151 FLOP CONTROL', 'FF151', v_branch_id, 0, 1160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 1160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 1160, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 8492.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 871) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9.75, 871);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 9.75, 871, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1744 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT701' OR product_name = 'NAX PREMILA MT701 FAST VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'MT701', v_branch_id, 0, 1744) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1744);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1744, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 3336 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1668, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6000 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 6000, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 7300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06H' OR product_name = 'NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'MT06H', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3650, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2150 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT003' OR product_name = 'NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'MT003', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1030 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NB200-HAR' OR product_name = 'NAX PREMILA 2K NB200 HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA 2K NB200 HARDENER', 'NB200-HAR', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1030, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2055 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT736' OR product_name = 'NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'NAT736', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 685, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1165' OR product_name = 'NAX NAT-1165 TTC HI-LITE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'NAT1165', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1280 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 640, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2340 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1159' OR product_name = 'NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'NAT1159', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 780, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 780 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1157' OR product_name = 'NAX NAT-1157 TTC BRIGHT COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'NAT1157', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2700 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX10100' OR product_name = 'NAX NAT-10100 NH-585 PEARL WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'NAX10100', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 675, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 216 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 12) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 18, 12);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 18, 12, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 90.88 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-5033' OR product_name = 'HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM', 'PWTCO-5033', v_branch_id, 0, 90.88) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 90.88);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 90.88, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 761 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'GLAZERB-4L', v_branch_id, 0, 761) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 761);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 761, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 760 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TC-21-1/4L' OR product_name = 'DAVIES OTC THALO BLUE 1/4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DAVIES OTC THALO BLUE 1/4L', 'TC-21-1/4L', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 95, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 349.8 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PWTCO-2133' OR product_name = 'BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT', 'PWTCO-2133', v_branch_id, 0, 87.45) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 87.45);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 87.45, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSAXGLWHTE-4L' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)', 'BSAXGLWHTE-4L', v_branch_id, 0, 1080) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1080);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1080, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 4384 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1710' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'B-1710', v_branch_id, 0, 1096) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1096);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1096, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 155 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 31) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 31);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 31, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2860 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.5, 440);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 6.5, 440, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 166.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-633' OR product_name = 'RAIN OR SHINE CHOCOLATE BROWN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE CHOCOLATE BROWN 4L', 'ROS-633', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.25, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.25, 665, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROSCB-1L' OR product_name = 'RAIN OR SHINE CHOCOLATE BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE CHOCOLATE BROWN 1L', 'ROSCB-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1330 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-701' OR product_name = 'RAIN OR SHINE BAGUIO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'ROS-701', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 665, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1181.25 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.75, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.75, 675, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 470.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTB-4L' OR product_name = 'POLYGLOSS PU PHTHALO BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU PHTHALO BLUE 4L', 'PGTB-4L', v_branch_id, 0, 1883) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.25, 1883);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.25, 1883, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1411 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMF-4L' OR product_name = 'POLYGLOSS PU MICA RED FINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'PGMF-4L', v_branch_id, 0, 2822) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 2822);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 2822, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 108.9375 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 1743) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.0625, 1743);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.0625, 1743, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2970.5 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 1828) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1.625, 1828);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1.625, 1828, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1387.1875 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 1930) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.71875, 1930);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.71875, 1930, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 650 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDW-4L' OR product_name = 'PLATONE QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE WHITE 4L', 'PLQDW-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 650, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-1L' OR product_name = 'PLATONE QDE BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 1L', 'PLQDB-1L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.1875, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.1875, 0, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 480 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SEALERMAX5170-4L' OR product_name = 'NIPPON SEALERMAX 5170 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON SEALERMAX 5170 4L', 'SEALERMAX5170-4L', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 960);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 960, 'Migration: ' || '2026-24-INV_06');

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
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPR7' OR product_name = 'NIPPON ROLLER PAINT #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ROLLER PAINT #7', 'NPR7', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 6305.625 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11.0625, 570);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 11.0625, 570, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2160 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSAXGLWHTE-4L' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)', 'BSAXGLWHTE-4L', v_branch_id, 0, 1080) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1080);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1080, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 2192 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1710' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'B-1710', v_branch_id, 0, 1096) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1096);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1096, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 425 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.5, 850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.5, 850, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1300 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- HAPPY DAYS-4L' OR product_name = 'RAIN OR SHINE- HAPPY DAYS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'ROS- HAPPY DAYS-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 650, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 243.75 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLY- BT-ALUM-4L' OR product_name = 'POLYGLOSS-BRIGHT ALUMINUM 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'POLY- BT-ALUM-4L', v_branch_id, 0, 1950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 0.125, 1950);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 0.125, 1950, 'Migration: ' || '2026-24-INV_06');

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
  UPDATE public.stock_in_logs SET total_amount = total_amount + 550 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRY- REDUCER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE REDUCER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ALPHA CHROMA ACRYTILE REDUCER', 'ACRY- REDUCER-4L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 550, 'Migration: ' || '2026-24-INV_06');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-740' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-740', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-740');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-741' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-741', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 1630 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4113-4L' OR product_name = 'NIPPON EXTREME QDU RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU RED 4L', 'NXU4113-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1630, 'Migration: ' || 'UNREF-741');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-742' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-742', '2026-06-23', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1550, 'Migration: ' || 'UNREF-742');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-743' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-743', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-743');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-744' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-744', '2026-06-24', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-744');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-745' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-745', '2026-06-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-745');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-746' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-746', '2026-06-27', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-746');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'EXPENSES' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('EXPENSES', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-747' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-747', '2026-06-27', 0) RETURNING id INTO v_stock_in_id;
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
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-747');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-748' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-748', '2026-06-27', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-748');

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES (COALESCE('TRANSFER TO MIXING AREA', 'UNKNOWN SUPPLIER'), v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  -- Create or get stock in log
  SELECT id INTO v_stock_in_id FROM public.stock_in_logs WHERE invoice_number = 'UNREF-749' AND branch_id = v_branch_id LIMIT 1;
  IF v_stock_in_id IS NULL THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'UNREF-749', '2026-06-30', 0) RETURNING id INTO v_stock_in_id;
  END IF;
  
  -- Update total amount
  UPDATE public.stock_in_logs SET total_amount = total_amount + 0 WHERE id = v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT503' OR product_name = 'NAX PREMILA MT503 THRENE RED G 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'MT503', v_branch_id, 0, 0) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 0);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 0, 'Migration: ' || 'UNREF-749');
  END;

END $MIGRATION$;
