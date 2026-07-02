-- Migration Script for Stock-In Data
-- Generated from Google Sheet: https://docs.google.com/spreadsheets/d/1liXCxpBDBtNqk-eW1G0RWICNwtWtBaec8n7P7Z3UhQE/

DO $$
DECLARE
  v_supplier_id uuid;
  v_log_id uuid;
  v_inv_id uuid;
  v_branch_id uuid;
BEGIN
  -- Always target the Main Distribution branch
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' ORDER BY name LIMIT 1;
  IF v_branch_id IS NULL THEN
    SELECT id INTO v_branch_id FROM public.branches ORDER BY created_at LIMIT 1;
  END IF;

  -- ==============================================
  -- Invoice: CSI-33977 | 2026-05-30 | GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'CSI-33977') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-33977', '2026-05-30', 125886.8)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-33977' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 50, 1451.8, 1887.34, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 50, cost = 1451.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 50, 1451.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 50, 'Historical Stock In: CSI-33977', '2026-05-30');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 50, 'Historical Stock In: CSI-33977', 1451.8, 72590, '2026-05-30');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Paint', 'CRO-MT1/2', 30, 1451.8, 1887.34, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 30, cost = 1451.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 30, 1451.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 30, 'Historical Stock In: CSI-33977', '2026-05-30');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 30, 'Historical Stock In: CSI-33977', 1451.8, 43554, '2026-05-30');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Paint', 'PYLZPRGR-145', 120, 81.19, 105.55, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 120, cost = 81.19 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 120, 81.19);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 120, 'Historical Stock In: CSI-33977', '2026-05-30');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 120, 'Historical Stock In: CSI-33977', 81.19, 9742.8, '2026-05-30');

  -- ==============================================
  -- Invoice: INV_06/4-11/26 | 2026-06-04 | INVENTORY - JUNE 4-11, 2026
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 4-11, 2026' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('INVENTORY - JUNE 4-11, 2026') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'INV_06/4-11/26') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'INV_06/4-11/26', '2026-06-04', 14247624.38)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'INV_06/4-11/26' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 1, 1451.8, 1887.34, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 1451.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 1451.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 1451.8, 1451.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA ACRYTILE CAST 4L', 'Paint', 'ALPATC-4L', 8, 550.53, 715.69, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 550.53 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 550.53);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 550.53, 4404.24, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATFLWHT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA ACRYTILE FLAT WHITE 4L', 'Paint', 'ALPATFLWHT-4L', 12, 888.96, 1155.65, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 888.96 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 888.96);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 888.96, 10667.52, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA ACRYTILE REDUCER 4L', 'Paint', 'ALPATR-4L', 6, 500, 650.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 500 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 500);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 500, 3000, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATSGWHT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA ACRYTILE SG WHITE 4L', 'Paint', 'ALPATSGWHT-4L', 4, 929.58, 1208.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 929.58 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 929.58);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 929.58, 3718.32, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT2' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CROCO MASKING TAPE 2 48MM (1X24)', 'Paint', 'CRO-MT2', 2, 1448.4, 1882.92, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 1448.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 1448.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 1448.4, 2896.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBUMBR-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC BURNT UMBER 1/4L', 'Paint', 'ALPOTCBUMBR-1/4L', 24, 79.42, 103.25, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 79.42 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 79.42);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 79.42, 1906.08, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCVENRD-CAN' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC VENETIAN RED 1/4L', 'Paint', 'ALPOTCVENRD-CAN', 44, 80.77, 105.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 44, cost = 80.77 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 44, 80.77);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 44, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 44, 'Historical Stock In: INV_06/4-11/26', 80.77, 3553.88, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA FLAT LATEX WHITE 4L', 'Paint', 'ALPFLXWHT-4L', 14, 568.58, 739.15, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 568.58 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 568.58);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 568.58, 7960.12, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUSLR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA POLYURETHANE FLOOR SEALER W/CATALYST 4L', 'Paint', 'ALPPUSLR-4L', 20, 1064.95, 1384.44, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1064.95 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1064.95);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1064.95, 21299, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUTC-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA POLYURETHANE FLOOR TOPCOAT W/CATALYST 4L', 'Paint', 'ALPPUTC-4L', 20, 1344.73, 1748.15, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1344.73 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1344.73);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1344.73, 26894.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CROCO MASKING TAPE 1 24MM (1X48)', 'Paint', 'CRO-MT1', 22, 1448.4, 1882.92, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1448.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1448.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1448.4, 31864.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('APLUS LACQUER THINNER 4L', 'Paint', 'APLT-4L', 220, 517.27, 672.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 220, cost = 517.27 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 220, 517.27);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 220, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 220, 'Historical Stock In: INV_06/4-11/26', 517.27, 113799.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA POLYURETHANE REDUCER 4L', 'Paint', 'ALPPUR-4L', 6, 694.93, 903.41, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 694.93 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 694.93);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 694.93, 4169.58, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('2B PAINT BRUSH #1', 'Paint', '2BPB-1', 2, 168, 218.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 168 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 168);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 168, 336, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('2B PAINT BRUSH #1 1/2', 'Paint', '2BPB-1 1/2', 10, 246.4, 320.32, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 246.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 246.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 246.4, 2464, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('2B PAINT BRUSH #2 1/2', 'Paint', '2BPB-2 1/2', 4, 432, 561.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 432 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 432);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 432, 1728, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-3' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('2B PAINT BRUSH #3', 'Paint', '2BPB-3', 8, 726.4, 944.32, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 726.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 726.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 726.4, 5811.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPTRL-7' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('2B PAINT ROLLER #7 W/HANDLE', 'Paint', '2BPTRL-7', 250, 58.5, 76.05, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 250, cost = 58.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 250, 58.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 250, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 250, 'Historical Stock In: INV_06/4-11/26', 58.5, 14625, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPGLXWHT-16L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 16L', 'Paint', 'ALPGLXWHT-16L', 2, 2608.23, 3390.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 2608.23 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 2608.23);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 2608.23, 5216.46, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC BLACK 1/4L', 'Paint', 'ALPLTCBLK-1/4L', 45, 27.98, 36.37, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 45, cost = 27.98 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 45, 27.98);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 45, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 45, 'Historical Stock In: INV_06/4-11/26', 27.98, 1259.1, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1/4L', 'Paint', 'ALPLTCBS-1/4L', 24, 37, 48.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 37 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 37);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 37, 888, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC BURNT UMBER 1/4L', 'Paint', 'ALPLTCBU-1/4L', 24, 37, 48.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 37 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 37);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 37, 888, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCRS-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC RAW SIENNA 1/4L', 'Paint', 'ALPLTCRS-1/4L', 24, 36.1, 46.93, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 36.1 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 36.1);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 36.1, 866.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC THALO BLUE 1/4L', 'Paint', 'ALPLTCTB-1/4L', 18, 37, 48.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 18, cost = 37 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 18, 37);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: INV_06/4-11/26', 37, 666, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC THALO GREEN 1/4L', 'Paint', 'ALPLTCTG-1/4L', 24, 37, 48.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 37 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 37);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 37, 888, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC VENETIAN RED 1/4L', 'Paint', 'ALPLTCVR-1/4L', 24, 34.75, 45.18, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 34.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 34.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 34.75, 834, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBR-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC BULLETIN RED 1/4L', 'Paint', 'ALPOTCBR-1/4L', 36, 87.54, 113.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 87.54 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 87.54);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 87.54, 3151.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBS-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC BURNT SIENNA 1/4L', 'Paint', 'ALPOTCBS-1/4L', 39, 76.71, 99.72, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 39, cost = 76.71 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 39, 76.71);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 39, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 39, 'Historical Stock In: INV_06/4-11/26', 76.71, 2991.69, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCFYO-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC FRENCH YELLOW OCHRE 1/4L', 'Paint', 'ALPOTCFYO-1/4L', 12, 77.62, 100.91, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 77.62 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 77.62);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 77.62, 931.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCHY-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC HANZA YELLOW 1/4L', 'Paint', 'ALPOTCHY-1/4L', 36, 91.15, 118.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 91.15 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 91.15);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 91.15, 3281.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCLB-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC LAMP BLACK 1/4L', 'Paint', 'ALPOTCLB-1/4L', 24, 71.3, 92.69, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 71.3 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 71.3);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 71.3, 1711.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCRS-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC RAW SIENNA 1/4L', 'Paint', 'ALPOTCRS-1/4L', 24, 77.62, 100.91, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 77.62 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 77.62);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 77.62, 1862.88, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCRU-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC RAW UMBER 1/4L', 'Paint', 'ALPOTCRU-1/4L', 36, 72.2, 93.86, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 72.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 72.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 72.2, 2599.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCTB-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC THALO BLUE 1/4L', 'Paint', 'ALPOTCTB-1/4L', 24, 80.77, 105.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 80.77 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 80.77);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 80.77, 1938.48, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCTG-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA OTC THALO GREEN 1/4L', 'Paint', 'ALPOTCTG-1/4L', 32, 80.77, 105.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 32, cost = 80.77 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 32, 80.77);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 32, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 32, 'Historical Stock In: INV_06/4-11/26', 80.77, 2584.64, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1L', 'Paint', 'ALPLTCBS-1L', 12, 105.59, 137.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 105.59 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 105.59);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 105.59, 1267.08, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC BURNT UMBER 1L', 'Paint', 'ALPLTCBU-1L', 24, 105.59, 137.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 105.59 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 105.59);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 105.59, 2534.16, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVQDCG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES QDE CRYSTAL GREEN 4L', 'Paint', 'DVQDCG-4L', 19, 851, 1106.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 851 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 851);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 851, 16169, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC THALO BLUE 1L', 'Paint', 'ALPLTCTB-1L', 10, 105.59, 137.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 105.59 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 105.59);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 105.59, 1055.9, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITTH-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DO IT URETHANE THINNER 4L', 'Paint', 'DOITTH-4L', 24, 548, 712.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 548 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 548);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 548, 13152, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO BODY FILLER WITH HARDENER 4L', 'Paint', 'DOMBF-4L', 498, 514.05, 668.26, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 498, cost = 514.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 498, 514.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 498, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 498, 'Historical Stock In: INV_06/4-11/26', 514.05, 255996.9, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'GLEENTB-4L', 20, 1094.8, 1423.24, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1094.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1094.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1094.8, 21896, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Paint', 'MEG3901-4L', 20, 950, 1235.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 950 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 950);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 950, 19000, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX EXTREME EPOXY ENAMEL BLACK W/HARDENER 4L', 'Paint', 'NXE1988', -2, 1110, 1443.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + -2, cost = 1110 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, -2, 1110);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', -2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', -2, 'Historical Stock In: INV_06/4-11/26', 1110, -2220, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Paint', 'NXE4090', -3, 1310, 1703.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + -3, cost = 1310 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, -3, 1310);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', -3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', -3, 'Historical Stock In: INV_06/4-11/26', 1310, -3930, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1313' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX EXTREME EPOXY ENAMEL YELLOW WITH HARDENER 4L', 'Paint', 'NXE1313', 10, 1305, 1696.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1305 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1305);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1305, 13050, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Paint', 'SOB642', 102, 800, 1040.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 102, cost = 800 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 102, 800);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 102, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 102, 'Historical Stock In: INV_06/4-11/26', 800, 81600, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1110-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 4, 2490, 3237.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 2490 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 2490);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 2490, 9960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC THALO GREEN 1L', 'Paint', 'ALPLTCTG-1L', 12, 105.59, 137.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 105.59 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 105.59);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 105.59, 1267.08, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTR-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC TOLUIDINE RED 1L', 'Paint', 'ALPLTCTR-1L', 12, 100.18, 130.23, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 100.18 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 100.18);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 100.18, 1202.16, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 3, 2573, 3344.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 3, cost = 2573 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 3, 2573);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: INV_06/4-11/26', 2573, 7719, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA LTC VENETIAN RED 1L', 'Paint', 'ALPLTCVR-1L', 12, 99.28, 129.06, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 99.28 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 99.28);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 99.28, 1191.36, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 6, 4980, 6474.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 4980 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 4980);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 4980, 29880, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SNDMSTER-36' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CUMI SANDMASTER FLOOR SANDING #36 (50MTR)', 'Paint', 'SNDMSTER-36', 1, 9590, 12467.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 9590 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 9590);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 9590, 9590, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO BODY FILLER WITH HARDENER 1L', 'Paint', 'DOMBF-1L', 528, 154.56, 200.93, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 528, cost = 154.56 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 528, 154.56);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 528, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 528, 'Historical Stock In: INV_06/4-11/26', 154.56, 81607.68, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-B' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 BLACK B', 'Paint', 'ECO100-B', 12, 360, 468.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 360 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 360);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 360, 4320, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS100' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CUMI SUPREME FLOOR SANDING #100', 'Paint', 'CUMISPREME-FS100', 4, 5575.48, 7248.12, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 5575.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 5575.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 5575.48, 22301.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-CB' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 COBALT BLUE CB', 'Paint', 'ECO100-CB', 13, 3410, 4433.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 3410 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 3410);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 3410, 44330, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-EY' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 HS YELLOW EY', 'Paint', 'ECO100-EY', 11, 1370, 1781.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 1370 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 1370);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 1370, 15070, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-V' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 MAGENTA V', 'Paint', 'ECO100-V', 12, 1030, 1339.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1030 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1030);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1030, 12360, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-T' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 MEDIUM YELLOW T', 'Paint', 'ECO100-T', 11, 1160, 1508.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 1160 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 1160);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 1160, 12760, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-A' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 ORGANIC YELLOW A 1L', 'Paint', 'ECO100-A', 10, 1100, 1430.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1100 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1100);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1100, 11000, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-OG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 OXIDE GREEN OG', 'Paint', 'ECO100-OG', 13, 1880, 2444.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 1880 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 1880);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 1880, 24440, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 55, 2158, 2805.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 55, cost = 2158 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 55, 2158);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 55, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 55, 'Historical Stock In: INV_06/4-11/26', 2158, 118690, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-E' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 PHTHALO BLUE E', 'Paint', 'ECO100-E', 12, 580, 754.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 580 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 580);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 580, 6960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-D' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 PHTHALO GREEN D', 'Paint', 'ECO100-D', 7, 590, 767.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 590 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 590);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 590, 4130, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-R' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 R ORGANIC RED 1L', 'Paint', 'ECO100-R', 12, 580, 754.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 580 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 580);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 580, 6960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-HT' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 RED HT', 'Paint', 'ECO100-HT', 11, 2100, 2730.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 2100 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 2100);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 2100, 23100, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-LR' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 RED LR', 'Paint', 'ECO100-LR', 11, 2260, 2938.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 2260 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 2260);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 2260, 24860, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-F' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 RED OXIDE F', 'Paint', 'ECO100-F', 6, 610, 793.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 610 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 610);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 610, 3660, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-OR' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 RED OXIDE OR', 'Paint', 'ECO100-OR', 5, 640, 832.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 640 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 640);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 640, 3200, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-KX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ECO 100 WHITE KX', 'Paint', 'ECO100-KX', 12, 630, 819.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 630 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 630);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 630, 7560, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB745' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Paint', 'SOB745', 48, 691, 898.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 48, cost = 691 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 48, 691);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 48, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 48, 'Historical Stock In: INV_06/4-11/26', 691, 33168, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX108', 5436, 545, 708.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5436, cost = 545 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5436, 545);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5436, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5436, 'Historical Stock In: INV_06/4-11/26', 545, 2962620, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Paint', 'NAX141', 1248, 430, 559.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1248, cost = 430 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1248, 430);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1248, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1248, 'Historical Stock In: INV_06/4-11/26', 430, 536640, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX301' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Paint', 'NAX301', 42, 830, 1079.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 42, cost = 830 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 42, 830);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 42, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 42, 'Historical Stock In: INV_06/4-11/26', 830, 34860, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Paint', 'PRI3634', 792, 415, 539.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 792, cost = 415 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 792, 415);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 792, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 792, 'Historical Stock In: INV_06/4-11/26', 415, 328680, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', 14, 806, 1047.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 806 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 806);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 806, 11284, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT103' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 10, 1353, 1758.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1353 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1353);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1353, 13530, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX1062' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 2, 581, 755.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 581 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 581);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 581, 1162, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 12, 996, 1294.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 996 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 996);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 996, 11952, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1107' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 13, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 889, 11557, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1110-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 8, 806, 1047.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 806 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 806);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 806, 6448, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1113' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 13, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 889, 11557, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1114' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 11, 676, 878.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 676 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 676);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 676, 7436, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1153' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 17, 913, 1186.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 913 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 913);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 913, 15521, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1157' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 18, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 18, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 18, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: INV_06/4-11/26', 889, 16002, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1158' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 14, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 889, 12446, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1160' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 12, 830, 1079.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 830 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 830);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 830, 9960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 11, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 889, 9779, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1163' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 20, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 889, 17780, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1164' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 41, 830, 1079.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 41, cost = 830 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 41, 830);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 41, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 41, 'Historical Stock In: INV_06/4-11/26', 830, 34030, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1165' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 17, 972, 1263.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 972 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 972);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 972, 16524, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1166' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 20, 1470, 1911.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1470 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1470);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1470, 29400, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1167' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 22, 1079, 1402.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1079 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1079);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1079, 23738, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1171' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 28, 1055, 1371.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 1055 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 1055);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 1055, 29540, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1172' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 22, 1079, 1402.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1079 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1079);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1079, 23738, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1173' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 8, 1719, 2234.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1719 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1719);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1719, 13752, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1175' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 10, 930, 1209.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 930 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 930);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 930, 9300, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1180' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 22, 1660, 2158.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1660 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1660);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1660, 36520, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1300' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 18, 2200, 2860.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 18, cost = 2200 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 18, 2200);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: INV_06/4-11/26', 2200, 39600, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1301' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 17, 2200, 2860.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 2200 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 2200);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 2200, 37400, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1303' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 26, 2200, 2860.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 26, cost = 2200 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 26, 2200);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 26, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 26, 'Historical Stock In: INV_06/4-11/26', 2200, 57200, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1304' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 7, 2200, 2860.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 2200 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 2200);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 2200, 15400, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1305' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 23, 1743, 2265.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 23, cost = 1743 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 23, 1743);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 23, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 23, 'Historical Stock In: INV_06/4-11/26', 1743, 40089, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 22, 1411, 1834.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1411 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1411);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1411, 31042, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT149' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 10, 1544, 2007.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1544 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1544);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1544, 15440, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT158-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158-1L', 17, 1345, 1748.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 1345 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 1345);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 1345, 22865, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT180' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 10, 1030, 1339.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1030 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1030);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1030, 10300, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT190' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 10, 465, 604.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 465 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 465);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 465, 4650, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 12, 706, 917.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 706 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 706);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 706, 8472, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT196' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 13, 1577, 2050.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 1577 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 1577);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 1577, 20501, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT210' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 16, 1826, 2373.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1826 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1826);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1826, 29216, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT305' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 12, 1494, 1942.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1494 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1494);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1494, 17928, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT320' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 29, 540, 702.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 540 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 540);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 540, 15660, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Paint', 'NAT321', 15, 1079, 1402.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 1079 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 1079);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 1079, 16185, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Paint', 'SOB757', 1652, 620, 806.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1652, cost = 620 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1652, 620);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1652, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1652, 'Historical Stock In: INV_06/4-11/26', 620, 1024240, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT380' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 19, 1295, 1683.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 1295 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 1295);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 1295, 24605, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT390' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 16, 482, 626.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 482 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 482);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 482, 7712, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT3974' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', 35, 557, 724.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 35, cost = 557 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 35, 557);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 35, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 35, 'Historical Stock In: INV_06/4-11/26', 557, 19495, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT410' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 8, 847, 1101.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 847 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 847);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 847, 6776, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 28, 415, 539.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 415 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 415);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 415, 11620, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT490' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 19, 664, 863.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 664 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 664);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 664, 12616, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NF146G-5KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NF146G-5KG', 1, 1278, 1661.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 1278 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 1278);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 1278, 1278, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HIPROF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA TEXTURED COATING HI PROFILE FLAT WHITE 4L', 'Paint', 'HIPROF-4L', 8, 622.73, 809.55, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 622.73 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 622.73);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 622.73, 4981.84, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NF145W-5KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', 2, 1278, 1661.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 1278 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 1278);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 1278, 2556, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'LOPROF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA TEXTURED COATING LOW PROFILE FLAT WHITE 4L', 'Paint', 'LOPROF-4L', 8, 654.31, 850.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 654.31 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 654.31);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 654.31, 5234.48, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT530' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 16, 1245, 1618.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1245 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1245);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1245, 19920, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT550' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 15, 515, 669.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 515 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 515);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 515, 7725, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT555' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 12, 565, 734.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 565 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 565);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 565, 6780, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT556' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 19, 747, 971.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 747 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 747);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 747, 14193, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT557' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 20, 540, 702.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 540 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 540);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 540, 10800, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT595' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 16, 581, 755.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 581 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 581);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 581, 9296, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT705-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 17, 430, 559.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 430 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 430);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 430, 7310, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT706-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 27, 430, 559.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 27, cost = 430 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 27, 430);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 27, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 27, 'Historical Stock In: INV_06/4-11/26', 430, 11610, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT707-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 15, 580, 754.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 580 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 580);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 580, 8700, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 6, 706, 917.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 706 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 706);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 706, 4236, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 4, 515, 669.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 515 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 515);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 515, 2060, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT716' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 27, 515, 669.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 27, cost = 515 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 27, 515);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 27, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 27, 'Historical Stock In: INV_06/4-11/26', 515, 13905, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT720' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 29, 747, 971.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 747 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 747);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 747, 21663, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT725' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 29, 723, 939.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 723 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 723);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 723, 20967, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT727' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 29, 1162, 1510.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 1162 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 1162);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 1162, 33698, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT729' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 53, 889, 1155.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 53, cost = 889 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 53, 889);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 53, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 53, 'Historical Stock In: INV_06/4-11/26', 889, 47117, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT733' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 24, 515, 669.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 515 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 515);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 515, 12360, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT736' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 23, 747, 971.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 23, cost = 747 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 23, 747);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 23, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 23, 'Historical Stock In: INV_06/4-11/26', 747, 17181, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT740' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 18, 557, 724.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 18, cost = 557 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 18, 557);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: INV_06/4-11/26', 557, 10026, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT745' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 29, 996, 1294.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 996 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 996);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 996, 28884, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Paint', 'PRI1680', 8, 605, 786.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 605 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 605);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 605, 4840, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA FF151 FLIP FLAT ADJ 1L', 'Paint', 'FF151', 79, 1000, 1300.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 79, cost = 1000 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 79, 1000);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 79, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 79, 'Historical Stock In: INV_06/4-11/26', 1000, 79000, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06M' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 10, 3569, 4639.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 3569 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 3569);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 3569, 35690, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT001' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 19, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 2241, 42579, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 4, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 2241, 8964, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 8, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2241, 17928, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 12, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2241, 26892, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT006' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 12, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2241, 26892, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT008' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 8, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2241, 17928, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 22, 1909, 2481.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 1909 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 1909);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 1909, 41998, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT023' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 9, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 2075, 18675, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA4021' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 4, 1245, 1618.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 1245 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 1245);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 1245, 4980, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT025' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 7, 1909, 2481.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1909 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1909);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1909, 13363, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 7, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 2241, 15687, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT030' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 32, 1909, 2481.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 32, cost = 1909 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 32, 1909);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 32, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 32, 'Historical Stock In: INV_06/4-11/26', 1909, 61088, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT033' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 12, 2241, 2913.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2241 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2241);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2241, 26892, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT050' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 10, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 3071, 30710, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT051' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 24, 3320, 4316.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 3320 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 3320);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 3320, 79680, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 4, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 3071, 12284, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT065' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 12, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 3071, 36852, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1983' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 16, 1245, 1618.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1245 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1245);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1245, 19920, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT066' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 7, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 3071, 21497, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 8, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 3071, 24568, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 24, 3569, 4639.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 3569 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 3569);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 3569, 85656, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 12, 3569, 4639.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 3569 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 3569);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 3569, 42828, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT071' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 12, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 3071, 36852, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT072' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 12, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 3071, 36852, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT075' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 10, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 3071, 30710, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT076' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 19, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 3071, 58349, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT078' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 14, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 3071, 42994, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 8, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 3071, 24568, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT080' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 12, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 3071, 36852, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 9, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 3071, 27639, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 4, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 3071, 12284, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT085' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 11, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 3071, 33781, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT086' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 8, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 3071, 24568, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT093' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 13, 3071, 3992.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 3071 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 3071);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 3071, 39923, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', 5, 5810, 7553.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 5810 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 5810);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 5810, 29050, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT103' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 2, 1245, 1618.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 1245 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 1245);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 1245, 2490, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 9, 3320, 4316.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 3320 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 3320);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 3320, 29880, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 6, 4980, 6474.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 4980 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 4980);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 4980, 29880, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT170' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 11, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 2075, 22825, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT172' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 11, 3154, 4100.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 3154 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 3154);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 3154, 34694, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT175' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 31, 1992, 2589.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 31, cost = 1992 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 31, 1992);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 31, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 31, 'Historical Stock In: INV_06/4-11/26', 1992, 61752, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1372' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 115, 1494, 1942.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 115, cost = 1494 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 115, 1494);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 115, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 115, 'Historical Stock In: INV_06/4-11/26', 1494, 171810, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 20, 1162, 1510.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1162 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1162);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1162, 23240, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 13, 1204, 1565.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 1204 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 1204);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 1204, 15652, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', 12, 1909, 2481.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1909 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1909);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1909, 22908, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT301' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 16, 2573, 3344.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 2573 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 2573);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 2573, 41168, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT302' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 13, 2158, 2805.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 2158 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 2158);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 2158, 28054, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT303' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 15, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 2075, 31125, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT304' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 9, 3486, 4531.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 3486 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 3486);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 3486, 31374, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT305' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 13, 1951, 2536.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 1951 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 1951);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 1951, 25363, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT307' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 9, 2988, 3884.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 2988 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 2988);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 2988, 26892, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1131' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPELAC ACE RED TRIPLE 8 4L', 'Paint', 'NPA1131', 14, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 2075, 29050, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT401' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 7, 2656, 3452.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 2656 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 2656);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 2656, 18592, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT405' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 32, 3611, 4694.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 32, cost = 3611 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 32, 3611);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 32, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 32, 'Historical Stock In: INV_06/4-11/26', 3611, 115552, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1487' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 5, 1494, 1942.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1494 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1494);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1494, 7470, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ACCENT BASE MATEX CC 5L', 'Paint', 'ABM-5L', 24, 659, 856.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 659 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 659);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 659, 15816, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ASKM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ARKHON SKIM COAT 4L', 'Paint', 'ASKM-4L', 15, 347.46, 451.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 347.46 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 347.46);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 347.46, 5211.9, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DEEP BASE MATEX CC 5L', 'Paint', 'DBM-5L', 12, 670, 871.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 670 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 670);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 670, 8040, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPABFC-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON MULTI-PURPOSE ACCENT BASE FLOOR COATING 5L', 'Paint', 'MPABFC-5L', 1, 1616, 2100.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 1616 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 1616);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 1616, 1616, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON PASTEL BASE MATEX CC 5L', 'Paint', 'PBM-5L', 17, 714, 928.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 714 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 714);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 714, 12138, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT501' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 19, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 2075, 39425, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 7, 2117, 2752.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 2117 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 2117);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 2117, 14819, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NCGL-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON CELAR GLOSS LACQUER 4L', 'Paint', 'NCGL-4L', 27, 627, 815.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 27, cost = 627 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 27, 627);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 27, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 27, 'Historical Stock In: INV_06/4-11/26', 627, 16929, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 12, 2365.5, 3075.15, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2365.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2365.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2365.5, 28386, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPCGV-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON CLEAR GLOSS VARNISH 4L', 'Paint', 'NPCGV-5L', 42, 1390, 1807.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 42, cost = 1390 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 42, 1390);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 42, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 42, 'Historical Stock In: INV_06/4-11/26', 1390, 58380, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT506' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 10, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 2075, 20750, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 5, 2905, 3776.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 2905 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 2905);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 2905, 14525, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CUMI SUPREME FLOOR SANDING #60', 'Paint', 'CUMISPREME-FS60', 2, 6388.2, 8304.66, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 6388.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 6388.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 6388.2, 12776.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS80' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('CUMI SUPREME FLOOR SANDING #80', 'Paint', 'CUMISPREME-FS80', 3, 7434, 9664.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 3, cost = 7434 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 3, 7434);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: INV_06/4-11/26', 7434, 22302, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT508' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 5, 2573, 3344.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 2573 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 2573);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 2573, 12865, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVEPOPTCH-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES EPO PATCH SET 4L', 'Paint', 'DVEPOPTCH-4L', 6, 2655, 3451.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 2655 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 2655);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 2655, 15930, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT601' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 4, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 2075, 8300, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 6, 2490, 3237.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 2490 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 2490);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 2490, 14940, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT603' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 10, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 2075, 20750, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 12, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2075, 24900, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT606' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 7, 1909, 2481.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1909 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1909);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1909, 13363, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 8, 2158, 2805.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2158 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2158);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2158, 17264, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 5, 1992, 2589.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1992 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1992);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1992, 9960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT704' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 8, 2905, 3776.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2905 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2905);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2905, 23240, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT705' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 5, 2075, 2697.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 2075 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 2075);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 2075, 10375, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 11, 1743, 2265.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 1743 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 1743);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 1743, 19173, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT803' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 10, 1826, 2373.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1826 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1826);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1826, 18260, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 5, 1826, 2373.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1826 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1826);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1826, 9130, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT805' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 8, 1826, 2373.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1826 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1826);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1826, 14608, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT806' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 8, 1826, 2373.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1826 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1826);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1826, 14608, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBLK-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES OIL TINTING COLOR BLACK 1/4L', 'Paint', 'DVOTCBLK-1/4L', 2, 80, 104.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 80 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 80);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 80, 160, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBLTNRD-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES OIL TINTING COLOR BULLETIN RED 1/4L', 'Paint', 'DVOTCBLTNRD-1/4L', 4, 96, 124.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 96 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 96);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 96, 384, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBSNA-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES OIL TINTING COLOR BURNT SIENNA 1/4L', 'Paint', 'DVOTCBSNA-1/4L', 16, 87, 113.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 87 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 87);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 87, 1392, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCRWSNA-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES OIL TINTING COLOR RAW SIENNA 1/4L', 'Paint', 'DVOTCRWSNA-1/4L', 1, 79, 102.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 79 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 79);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 79, 79, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCVNRED-1/4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DAVIES OIL TINTING COLOR VENETIAN RED 1/4L', 'Paint', 'DVOTCVNRED-1/4L', 8, 90, 117.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 90 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 90);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 90, 720, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOIT-CAT' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DO IT URETHANE CATALYST CAN', 'Paint', 'DOIT-CAT', 36, 225.82, 293.57, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 225.82 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 225.82);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 225.82, 8129.52, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NDFL-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DEAD FLAT LACQUER 4L', 'Paint', 'NDFL-4L', 27, 643, 835.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 27, cost = 643 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 27, 643);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 27, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 27, 'Historical Stock In: INV_06/4-11/26', 643, 17361, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DPB-4' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DRAGONFLY PAINT BRUSH 4', 'Paint', 'DPB-4', 72, 93.33, 121.33, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 72, cost = 93.33 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 72, 93.33);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 72, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 72, 'Historical Stock In: INV_06/4-11/26', 93.33, 6719.76, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT807' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 7, 1743, 2265.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1743 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1743);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1743, 12201, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER #60', 'Paint', 'EA60', 400, 29.7, 38.61, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 400, cost = 29.7 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 400, 29.7);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 400, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 400, 'Historical Stock In: INV_06/4-11/26', 29.7, 11880, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA80' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER #80', 'Paint', 'EA80', 300, 27.5, 35.75, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 300, cost = 27.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 300, 27.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 300, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 300, 'Historical Stock In: INV_06/4-11/26', 27.5, 8250, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1000' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 1000', 'Paint', 'EA1000', 600, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 600, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 600, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 600, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 600, 'Historical Stock In: INV_06/4-11/26', 20.35, 12210, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 120', 'Paint', 'EA120', 500, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 500, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 500, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 500, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 500, 'Historical Stock In: INV_06/4-11/26', 20.35, 10175, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 2000', 'Paint', 'EA2000', 500, 27.5, 35.75, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 500, cost = 27.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 500, 27.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 500, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 500, 'Historical Stock In: INV_06/4-11/26', 27.5, 13750, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCABSG-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L', 'Paint', 'DCABSG-5L', 37, 895, 1163.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 37, cost = 895 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 37, 895);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 37, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 37, 'Historical Stock In: INV_06/4-11/26', 895, 33115, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCDBSG-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L', 'Paint', 'DCDBSG-5L', 12, 914, 1188.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 914 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 914);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 914, 10968, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L', 'Paint', 'DCPBSG-5L', 20, 972, 1263.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 972 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 972);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 972, 19440, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA220' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 220', 'Paint', 'EA220', 300, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 300, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 300, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 300, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 300, 'Historical Stock In: INV_06/4-11/26', 20.35, 6105, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L', 'Paint', 'DCTBSG-5L', 8, 934, 1214.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 934 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 934);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 934, 7472, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT903' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 7, 1743, 2265.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1743 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1743);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1743, 12201, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 240', 'Paint', 'EA240', 900, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 900, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 900, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 900, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 900, 'Historical Stock In: INV_06/4-11/26', 20.35, 18315, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 114, 1560, 2028.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 114, cost = 1560 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 114, 1560);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 114, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 114, 'Historical Stock In: INV_06/4-11/26', 1560, 177840, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT904' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 7, 1743, 2265.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1743 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1743);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1743, 12201, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA320' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 320', 'Paint', 'EA320', 100, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 100, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 100, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: INV_06/4-11/26', 20.35, 2035, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 3, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 3, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 3, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: INV_06/4-11/26', 1710, 5130, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NB200-HARD' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA NB200 HARDENER', 'Paint', 'NB200-HARD', 1, 685, 890.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 685 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 685);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 685, 685, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 400', 'Paint', 'EA400', 800, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 800, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 800, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 800, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 800, 'Historical Stock In: INV_06/4-11/26', 20.35, 16280, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4406-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 11, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 1710, 18810, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9200', 59, 925, 1202.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 59, cost = 925 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 59, 925);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 59, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 59, 'Historical Stock In: INV_06/4-11/26', 925, 54575, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 600', 'Paint', 'EA600', 500, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 500, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 500, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 500, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 500, 'Historical Stock In: INV_06/4-11/26', 20.35, 10175, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9700', 132, 1145, 1488.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 132, cost = 1145 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 132, 1145);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 132, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 132, 'Historical Stock In: INV_06/4-11/26', 1145, 151140, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 800', 'Paint', 'EA800', 600, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 600, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 600, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 600, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 600, 'Historical Stock In: INV_06/4-11/26', 20.35, 12210, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 11, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 1710, 18810, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITSHLDALL-BOT' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Paint', 'DOITSHLDALL-BOT', 144, 131.25, 170.63, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 144, cost = 131.25 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 144, 131.25);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 144, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 144, 'Historical Stock In: INV_06/4-11/26', 131.25, 18900, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 59, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 59, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 59, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 59, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 59, 'Historical Stock In: INV_06/4-11/26', 1710, 100890, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', 108, 1560, 2028.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 108, cost = 1560 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 108, 1560);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 108, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 108, 'Historical Stock In: INV_06/4-11/26', 1560, 168480, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 21, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 21, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 21, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 21, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 21, 'Historical Stock In: INV_06/4-11/26', 1710, 35910, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON MULTI-PURPOSE TINT BASE FLOOR COATING 5L', 'Paint', 'MPTBFC-5L', 3, 1686, 2191.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 3, cost = 1686 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 3, 1686);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: INV_06/4-11/26', 1686, 5058, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MTLPRRO-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON METAL PRIMER RED OXIDE 4L', 'Paint', 'MTLPRRO-4L', 4, 490, 637.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 490 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 490);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 490, 1960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPPBFC-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON MULTI-PURPOSE PASTEL BASE FLOOR COATING 5L', 'Paint', 'MPPBFC-5L', 1, 1756, 2282.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 1756 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 1756);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: INV_06/4-11/26', 1756, 1756, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEWHTE-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE NON-REFLECTIVE WHITE 5L', 'Paint', 'NONREFLCTVEWHTE-5L', 8, 1124, 1461.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1124 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1124);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1124, 8992, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFBLACK-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE REFLECTIVE BLACK 5L', 'Paint', 'ROADLNEREFBLACK-5L', 7, 1184, 1539.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1184 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1184);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1184, 8288, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFWHTE-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE REFLECTIVE WHITE 5L', 'Paint', 'ROADLNEREFWHTE-5L', 8, 1184, 1539.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1184 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1184);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1184, 9472, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ACCENT BASE MATEX CC 1L', 'Paint', 'ABM-1L', 7, 174, 226.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 174 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 174);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 174, 1218, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PUTTYKNI #4' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('JAPAN PUTTY KNIFE #4 BLUE', 'Paint', 'PUTTYKNI #4', 80, 9, 11.70, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 80, cost = 9 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 80, 9);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 80, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 80, 'Historical Stock In: INV_06/4-11/26', 9, 720, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ALPHA CHROMA QDE WHITE 1L', 'Paint', 'ALPQDWHT-1L', 24, 194.94, 253.42, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 194.94 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 194.94);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 194.94, 4678.56, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGAB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE HIGH GLOSS ACCENT BASE 1L', 'Paint', 'PLTHGAB-1L', 16, 274, 356.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 274 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 274);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 274, 4384, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGDB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE HIGH GLOSS DEEP BASE 1L', 'Paint', 'PLTHGDB-1L', 20, 280, 364.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 280 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 280);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 280, 5600, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 12, 2100, 2730.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2100 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2100);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2100, 25200, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 6, 1475.33, 1917.93, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 1475.33 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 1475.33);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 1475.33, 8851.98, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPCGV-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON CLEAR GLOSS VARNISH 1L', 'Paint', 'NPCGV-1L', 108, 427, 555.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 108, cost = 427 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 108, 427);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 108, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 108, 'Historical Stock In: INV_06/4-11/26', 427, 46116, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQBLK-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER BLACK 4L', 'Paint', 'DOMLCQBLK-4L', 60, 760, 988.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 60, cost = 760 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 60, 760);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 60, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 60, 'Historical Stock In: INV_06/4-11/26', 760, 45600, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DEEP BASE MATEX CC 1L', 'Paint', 'DBM-1L', 6, 176, 228.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 176 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 176);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 176, 1056, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGPB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE HIGH GLOSS PASTEL BASE 1L', 'Paint', 'PLTHGPB-1L', 20, 298, 387.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 298 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 298);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 298, 5960, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGTB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE HIGH GLOSS TINT BASE 1L', 'Paint', 'PLTHGTB-1L', 20, 286, 371.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 286 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 286);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 286, 5720, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX NAX21 URETHANE HARDENER', 'Paint', 'NAX21', 349, 165, 214.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 349, cost = 165 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 349, 165);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 349, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 349, 'Historical Stock In: INV_06/4-11/26', 165, 57585, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 12, 770, 1001.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 770 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 770);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 770, 9240, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQGLDTNR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER GOLD TONER 4L', 'Paint', 'DOMLCQGLDTNR-4L', 12, 868, 1128.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 868 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 868);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 868, 10416, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NFP-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON FLATTENING PASTE 1L', 'Paint', 'NFP-1L', 12, 650, 845.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 650 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 650);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 650, 7800, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ACCENT BASE MATEX CC 15L', 'Paint', 'ABM-15L', 5, 1877, 2440.10, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1877 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1877);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1877, 9385, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DEEP BASE MATEX CC 15L', 'Paint', 'DBM-15L', 4, 1912, 2485.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 1912 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 1912);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 1912, 7648, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON PASTEL BASE MATEX CC 15L', 'Paint', 'PBM-15L', 8, 2036, 2646.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2036 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2036);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2036, 16288, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCABSG-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L', 'Paint', 'DCABSG-15L', 4, 2551, 3316.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 2551 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 2551);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 2551, 10204, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCDBSG-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L', 'Paint', 'DCDBSG-15L', 7, 2606, 3387.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 2606 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 2606);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 2606, 18242, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 4, 234, 304.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 234 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 234);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 234, 936, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQINTRD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER INTERNATIONAL RED 4L', 'Paint', 'DOMLCQINTRD-4L', 12, 896, 1164.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 896 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 896);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 896, 10752, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQLY-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER LEMON YELLOW 4L', 'Paint', 'DOMLCQLY-4L', 16, 1016, 1320.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1016 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1016);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1016, 16256, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMETCRSE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER METALLIC COARSE 4L', 'Paint', 'DOMLCQMETCRSE-4L', 28, 826.4, 1074.32, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 826.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 826.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 826.4, 23139.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMETFNE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER METALLIC FINE 4L', 'Paint', 'DOMLCQMETFNE-4L', 24, 826.4, 1074.32, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 826.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 826.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 826.4, 19833.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMO-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER MOLYBDATE ORANGE 4L', 'Paint', 'DOMLCQMO-4L', 8, 894.4, 1162.72, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 894.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 894.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 894.4, 7155.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQPUTYWH-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER PUTTY WHITE 4L', 'Paint', 'DOMLCQPUTYWH-4L', 28, 778.4, 1011.92, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 778.4 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 778.4);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 778.4, 21795.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQTHBL-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER THALO BLUE 4L', 'Paint', 'DOMLCQTHBL-4L', 12, 879.2, 1142.96, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 879.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 879.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 879.2, 10550.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQTHGR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER THALO GREEN 4L', 'Paint', 'DOMLCQTHGR-4L', 4, 879.2, 1142.96, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 879.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 879.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 879.2, 3516.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQWHTE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('DOMINO AUTO LACQUER WHITE 4L', 'Paint', 'DOMLCQWHTE-4L', 20, 760, 988.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 760 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 760);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 760, 15200, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAECY-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5625 CATERPILLAR YELLOW 4L', 'Paint', 'GLAECY-4L', 12, 793.48, 1031.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 793.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 793.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 793.48, 9521.76, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU BON RED 4L', 'Paint', 'PGBNRED-4L', 12, 1965.2, 2554.76, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1965.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1965.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1965.2, 23582.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEIR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5642 INTERNATIONAL RED 4L', 'Paint', 'GLAEIR-4L', 4, 793.48, 1031.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 793.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 793.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 793.48, 3173.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEFR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5645 FIRE RED 4L', 'Paint', 'GLAEFR-4L', 4, 793.48, 1031.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 793.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 793.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 793.48, 3173.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5648 MAROON 4L', 'Paint', 'GLAEMRN-4L', 8, 793.48, 1031.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 793.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 793.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 793.48, 6347.84, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAETG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5655 THALO GREEN 4L', 'Paint', 'GLAETG-4L', 8, 793.48, 1031.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 793.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 793.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 793.48, 6347.84, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAETB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5665 THALO BLUE 4L', 'Paint', 'GLAETB-4L', 8, 772.55, 1004.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 772.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 772.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 772.55, 6180.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU BRIGHT ALUMINUM 4L', 'Paint', 'PGBRTALUM-4L', 8, 1796.05, 2334.87, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1796.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1796.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1796.05, 14368.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L', 'Paint', 'DCTBSG-15L', 3, 2661, 3459.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 3, cost = 2661 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 3, 2661);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: INV_06/4-11/26', 2661, 7983, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEBLK-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5690 BLACK 4L', 'Paint', 'GLAEBLK-4L', 10, 708.1, 920.53, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 708.1 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 708.1);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 708.1, 7081, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5695 METALLIC FINE 4L', 'Paint', 'GLAEMF-4L', 8, 772.55, 1004.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 772.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 772.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 772.55, 6180.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMC-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5696 METALLIC COURSE 4L', 'Paint', 'GLAEMC-4L', 8, 772.55, 1004.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 772.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 772.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 772.55, 6180.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEFB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER AUTO ENAMEL 5699 FLAT BLACK 4L', 'Paint', 'GLAEFB-4L', 4, 772.55, 1004.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 772.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 772.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 772.55, 3090.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEPENCATYLW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER EPOXY ENAMEL CATERPILLAR YELLOW W/H 4L', 'Paint', 'GLEPENCATYLW-4L', 4, 1136.55, 1477.52, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 1136.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 1136.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 1136.55, 4546.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEPENTHGRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('GLAZER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'GLEPENTHGRN-4L', 8, 1094.8, 1423.24, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 1094.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 1094.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 1094.8, 8758.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUPBRSH' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('OMEGA CUP BRUSH 3INXM10X1.50MM TWISTED WHITE', 'Paint', 'CUPBRSH', 4, 112, 145.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 112 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 112);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 112, 448, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON PREMIUM HS CLEAR W/H 1L', 'Paint', 'HSCLR-1L', 72, 625, 812.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 72, cost = 625 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 72, 625);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 72, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 72, 'Historical Stock In: INV_06/4-11/26', 625, 45000, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TBM-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON TINT BASE MATEX CC 1L', 'Paint', 'TBM-1L', 4, 180, 234.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 180 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 180);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 180, 720, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('OMEGA DOUBLE SIDED WOOL BUFFING PAD 8IN', 'Paint', 'BUFFPAD', 60, 580, 754.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 60, cost = 580 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 60, 580);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 60, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 60, 'Historical Stock In: INV_06/4-11/26', 580, 34800, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TRAY' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 29, 32, 41.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 29, cost = 32 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 29, 32);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: INV_06/4-11/26', 32, 928, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONSAG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PIONEER NON-SAG MARINE EPOXY A&B', 'Paint', 'NONSAG-4L', 2, 2564.32, 3333.62, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 2564.32 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 2564.32);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 2564.32, 5128.64, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZANTPR-12' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Paint', 'PYLZANTPR-12', 108, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 108, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 108, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 108, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 108, 'Historical Stock In: INV_06/4-11/26', 79.86, 8624.88, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR 1L', 'Paint', 'NP8100T-1L', 242, 1355, 1761.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 242, cost = 1355 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 242, 1355);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 242, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 242, 'Historical Stock In: INV_06/4-11/26', 1355, 327910, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTMRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU GLEAMIST MAROON 4L', 'Paint', 'PGGLEMSTMRN-4L', 8, 3003.05, 3903.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 3003.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 3003.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 3003.05, 24024.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZAY-06' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 110, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 110, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 110, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 110, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 110, 'Historical Stock In: INV_06/4-11/26', 79.86, 8784.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTORNGE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGLEMSTORNGE-4L', 8, 3003.05, 3903.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 3003.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 3003.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 3003.05, 24024.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTRED-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU GLEAMIST RED 4L', 'Paint', 'PGGLEMSTRED-4L', 11, 3003.05, 3903.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 11, cost = 3003.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 11, 3003.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: INV_06/4-11/26', 3003.05, 33033.55, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTWHT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGLEMSTWHT-4L', 7, 3003.05, 3903.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 3003.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 3003.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 3003.05, 21021.35, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTYLW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGLEMSTYLW-4L', 4, 3003.05, 3903.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 3003.05 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 3003.05);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 3003.05, 12012.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLTYLW-4L', 7, 1776.5, 2309.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1776.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1776.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1776.5, 12435.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMRNTNR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU MAROON TONER 4L', 'Paint', 'PGMRNTNR-4L', 5, 1987.3, 2583.49, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1987.3 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1987.3);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1987.3, 9936.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDCRSE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU MICA RED COARSE 4L', 'Paint', 'PGMICARDCRSE-4L', 14, 2660.5, 3458.65, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 2660.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 2660.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 2660.5, 37247, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDFNE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMICARDFNE-4L', 13, 2660.5, 3458.65, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 2660.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 2660.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 2660.5, 34586.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMLYORNGE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU MOLY ORANGE 4L', 'Paint', 'PGMLYORNGE-4L', 10, 1776.5, 2309.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 1776.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 1776.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 1776.5, 17765, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDGRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU PEARL FROSTED GREEN 4L', 'Paint', 'PGPRLFRSTDGRN-4L', 12, 2900.2, 3770.26, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2900.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2900.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2900.2, 34802.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDRD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU PEARL FROSTED RED 4L', 'Paint', 'PGPRLFRSTDRD-4L', 4, 2900.2, 3770.26, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 2900.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 2900.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 2900.2, 11600.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDYL-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU PEARL FROSTED YELLOW 4L', 'Paint', 'PGPRLFRSTDYL-4L', 5, 2900.2, 3770.26, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 2900.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 2900.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 2900.2, 14501, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLWHT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU PEARL WHITE 4L', 'Paint', 'PGPRLWHT-4L', 12, 2900.2, 3770.26, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 2900.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 2900.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 2900.2, 34802.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRMRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU PERMANENT MAROON 4L', 'Paint', 'PGPRMRN-4L', 8, 2312, 3005.60, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 2312 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 2312);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 2312, 18496, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRDGLD-4L', 5, 1776.5, 2309.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 1776.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 1776.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 1776.5, 8882.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHGRN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU THALO GREEN 4L', 'Paint', 'PGTHGRN-4L', 9, 1776.5, 2309.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 1776.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 1776.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 1776.5, 15988.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU VIOLET TONER 4L', 'Paint', 'PGVIOTNR-4L', 10, 2291.6, 2979.08, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 2291.6 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 2291.6);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 2291.6, 22916, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTC-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-101 TERRA COTTA 4L', 'Paint', 'RSTC-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZCANRED-801' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PYLZCANRED-801', 58, 82.28, 106.96, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 58, cost = 82.28 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 58, 82.28);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 58, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 58, 'Historical Stock In: INV_06/4-11/26', 82.28, 4772.24, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZCLR-01' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER CLEAR 01', 'Paint', 'PYLZCLR-01', 93, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 93, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 93, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 93, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 93, 'Historical Stock In: INV_06/4-11/26', 79.86, 7426.98, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 10, 891, 1158.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 891 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 891);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 891, 8910, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PYLZDR-17', 22, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 79.86, 1756.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EPOXY THINNER 4L', 'Paint', 'EPOXYTHNR-4L', 222, 480, 624.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 222, cost = 480 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 222, 480);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 222, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 222, 'Historical Stock In: INV_06/4-11/26', 480, 106560, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDISIL-701' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PYLZDISIL-701', 28, 97.92, 127.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 97.92 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 97.92);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 97.92, 2741.76, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4184-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU CINQUASIA VIOLET 4L', 'Paint', 'NXU4184-4L', 6, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 1710, 10260, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4197-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU MAGENTA 4L', 'Paint', 'NXU4197-4L', 6, 1910, 2483.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 1910 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 1910);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 1910, 11460, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4168-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU MAROON 4L', 'Paint', 'NXU4168-4L', 12, 1910, 2483.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1910 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1910);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1910, 22920, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURANGE-601' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PYLZFLOURANGE-601', 28, 127.16, 165.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 127.16 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 127.16);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 127.16, 3560.48, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'XTRMEQDWARMYLW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 16, 1710, 2223.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1710 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1710);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1710, 27360, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUPNK-603' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PYLZFLOUPNK-603', 48, 127.16, 165.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 48, cost = 127.16 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 48, 127.16);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 48, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 48, 'Historical Stock In: INV_06/4-11/26', 127.16, 6103.68, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPJOINTCMPND-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Paint', 'MPJOINTCMPND-5L', 4, 378, 491.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 378 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 378);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 378, 1512, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDLY-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 8, 965, 1254.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 965 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 965);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 965, 7720, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURED-602' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER FLOURESCENT RED 602', 'Paint', 'PYLZFLOURED-602', 36, 127.16, 165.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 127.16 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 127.16);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 127.16, 4577.76, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEBLK-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE NON-REFLECTIVE BLACK 5L', 'Paint', 'NONREFLCTVEBLK-5L', 7, 1124, 1461.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1124 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1124);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1124, 7868, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEYEL-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE NON-REFLECTIVE YELLOW 5L', 'Paint', 'NONREFLCTVEYEL-5L', 7, 1124, 1461.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1124 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1124);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1124, 7868, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFYLW-5L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ROADLINE REFLECTIVE YELLOW 5L', 'Paint', 'ROADLNEREFYLW-5L', 7, 1184, 1539.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 1184 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 1184);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 1184, 8288, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUVIO-604' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PYLZFLOUVIO-604', 10, 127.16, 165.31, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 10, cost = 127.16 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 10, 127.16);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 10, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 10, 'Historical Stock In: INV_06/4-11/26', 127.16, 1271.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUYEL-600' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER FLOURESCENT YELLOW 600', 'Paint', 'PYLZFLOUYEL-600', 12, 123.42, 160.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 123.42 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 123.42);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 123.42, 1481.04, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PYLZGLBLK-48', 54, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 54, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 54, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 54, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 54, 'Historical Stock In: INV_06/4-11/26', 79.86, 4312.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PINNACLE EPOXY ENAMEL CLEAR W/H 4L', 'Paint', 'PINEPENCLR-4L', 18, 924.48, 1201.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 18, cost = 924.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 18, 924.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: INV_06/4-11/26', 924.48, 16640.64, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENINTRD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PINNACLE EPOXY ENAMEL INTERNATIONAL RED W/H 4L', 'Paint', 'PINEPENINTRD-4L', 16, 1056.24, 1373.11, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1056.24 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1056.24);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1056.24, 16899.84, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PINNACLE EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'PINEPENLY-4L', 60, 1056.24, 1373.11, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 60, cost = 1056.24 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 60, 1056.24);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 60, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 60, 'Historical Stock In: INV_06/4-11/26', 1056.24, 63374.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 6, 234, 304.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 234 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 234);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 234, 1404, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L', 'Paint', 'DCTBSG-1L', 12, 224, 291.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 224 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 224);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 224, 2688, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGYLGLD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYLGLD-4L', 15, 2283.1, 2968.03, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 2283.1 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 2283.1);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 2283.1, 34246.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HS-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON HS FILLER 1L', 'Paint', 'HS-1L', -11, 545, 708.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + -11, cost = 545 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, -11, 545);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', -11, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', -11, 'Historical Stock In: INV_06/4-11/26', 545, -5995, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGYLOXDE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS PU YELLOW OXIDE 4L', 'Paint', 'PGYLOXDE-4L', 17, 1776.5, 2309.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 17, cost = 1776.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 17, 1776.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 17, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 17, 'Historical Stock In: INV_06/4-11/26', 1776.5, 30200.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON PASTEL BASE MATEX CC 1L', 'Paint', 'PBM-1L', 6, 188, 244.40, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 6, cost = 188 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 6, 188);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: INV_06/4-11/26', 188, 1128, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLD-705' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PYLZGLD-705', 60, 95.04, 123.55, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 60, cost = 95.04 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 60, 95.04);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 60, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 60, 'Historical Stock In: INV_06/4-11/26', 95.04, 5702.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGRY-45' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER GRAY 45', 'Paint', 'PYLZGRY-45', 36, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 79.86, 2874.96, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZHTRSTSIL-709' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PYLZHTRSTSIL-709', 28, 146.2, 190.06, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 28, cost = 146.2 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 28, 146.2);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 28, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 28, 'Historical Stock In: INV_06/4-11/26', 146.2, 4093.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HIHEAT' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PLYOX LAZER HI-HEAT BLACK', 'Paint', 'HIHEAT', 84, 150.5, 195.65, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 84, cost = 150.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 84, 150.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 84, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 84, 'Historical Stock In: INV_06/4-11/26', 150.5, 12642, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZLTGR-33' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PYLZLTGR-33', 50, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 50, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 50, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 50, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 50, 'Historical Stock In: INV_06/4-11/26', 79.86, 3993, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZMTBLK-47' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER MATT BLACK 47', 'Paint', 'PYLZMTBLK-47', 48, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 48, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 48, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 48, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 48, 'Historical Stock In: INV_06/4-11/26', 79.86, 3833.28, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZMTW-03' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PYLZMTW-03', 46, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 46, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 46, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 46, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 46, 'Historical Stock In: INV_06/4-11/26', 79.86, 3673.56, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSSG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-115 STONE GRAY 4L', 'Paint', 'RSSG-4L', 8, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 631.75, 5054, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTOG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-171 TOUCH OF GRAY 4L', 'Paint', 'RSTOG-4L', 4, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 631.75, 2527, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-175 ROMANCE 4L', 'Paint', 'RSR-4L', 12, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 631.75, 7581, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSNP-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-223 NICOLE PINK 4L', 'Paint', 'RSNP-4L', 14, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 14, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 14, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 14, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 14, 'Historical Stock In: INV_06/4-11/26', 631.75, 8844.5, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSOSR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-298 OH SO RED 4L', 'Paint', 'RSOSR-4L', 16, 812.25, 1055.92, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 812.25 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 812.25);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 812.25, 12996, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSIP-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-313 IRVINE PEACH 4L', 'Paint', 'RSIP-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-367 CANDY TUFT 4L', 'Paint', 'RSCT-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSMW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-368 MY WAY 4L', 'Paint', 'RSMW-4L', 8, 690.41, 897.53, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 690.41 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 690.41);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 690.41, 5523.28, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSS-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-381 SERENITY 4L', 'Paint', 'RSS-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSC-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-513 CITRUS 4L', 'Paint', 'RSC-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSIL-42' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PYLZSIL-42', 60, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 60, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 60, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 60, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 60, 'Historical Stock In: INV_06/4-11/26', 79.86, 4791.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSKBL-22' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PYLZSKBL-22', 2, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 79.86, 159.72, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZVIO-20' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PYLZVIO-20', 22, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 22, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 22, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 22, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 22, 'Historical Stock In: INV_06/4-11/26', 79.86, 1756.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZWH-02' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', 38, 79.86, 103.82, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 38, cost = 79.86 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 38, 79.86);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 38, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 38, 'Historical Stock In: INV_06/4-11/26', 79.86, 3034.68, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-15L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 9, 2550, 3315.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 2550 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 2550);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 2550, 22950, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Paint', 'ROBRC-1KG', 218, 582.67, 757.47, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 218, cost = 582.67 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 218, 582.67);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 218, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 218, 'Historical Stock In: INV_06/4-11/26', 582.67, 127022.06, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBPNTSTRNR' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 39, 6.65, 8.65, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 39, cost = 6.65 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 39, 6.65);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 39, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 39, 'Historical Stock In: INV_06/4-11/26', 6.65, 259.35, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLLQWX-50ML' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMELESS LIQUID WAX 50ML', 'Paint', 'TLLQWX-50ML', 250, 44.8, 58.24, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 250, cost = 44.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 250, 44.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 250, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 250, 'Historical Stock In: INV_06/4-11/26', 44.8, 11200, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMELESS RUBBING COMPOUND 630GRMS', 'Paint', 'TLRUBCMP-CAN', 54, 373.1, 485.03, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 54, cost = 373.1 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 54, 373.1);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 54, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 54, 'Historical Stock In: INV_06/4-11/26', 373.1, 20147.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMELESS RUBBING COMPOUND SACHET', 'Paint', 'TLRUBCMP-SACHET', 100, 37.8, 49.14, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 100, cost = 37.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 100, 37.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: INV_06/4-11/26', 37.8, 3780, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RST-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-518 TEMPTATION 4L', 'Paint', 'RST-4L', 5, 735.54, 956.20, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 5, cost = 735.54 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 5, 735.54);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 5, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 5, 'Historical Stock In: INV_06/4-11/26', 735.54, 3677.7, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSSB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-538 SAFARI BROWN 4L', 'Paint', 'RSSB-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBGWN-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-559 BRIDAL GOWN 4L', 'Paint', 'RSBGWN-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-618 HAPPY DAYS 4L', 'Paint', 'RSHD-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'RSTLPS-4L', 12, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 631.75, 7581, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSGB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-678 GOLDEN BUTTER 4L', 'Paint', 'RSGB-4L', 20, 690.41, 897.53, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 690.41 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 690.41);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 690.41, 13808.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-701 BAGUIO GREEN 4L', 'Paint', 'RSBG-4L', 20, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 631.75, 12635, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCNT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-739 COCONUT 4L', 'Paint', 'RSCNT-4L', 24, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 631.75, 15162, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-818 CHINA WHITE 4L', 'Paint', 'RSCW-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSFM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-829 FRESHMINT 4L', 'Paint', 'RSFM-4L', 4, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 631.75, 2527, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSLO-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-888 LUCKY ORANGE 4L', 'Paint', 'RSLO-4L', 16, 1308.63, 1701.22, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 1308.63 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 1308.63);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 1308.63, 20938.08, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'RSCM-4L', 8, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 631.75, 5054, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE ROS-938 MARGIE 4L', 'Paint', 'RSM-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSXG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-1000 XTRA GLOSS 4L', 'Paint', 'RSXG-4L', 7, 609.19, 791.95, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 7, cost = 609.19 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 7, 609.19);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: INV_06/4-11/26', 609.19, 4264.33, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-111 BLACK 4L', 'Paint', 'RSB-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSL-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-309 LAVENDER 4L', 'Paint', 'RSL-4L', 16, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 631.75, 10108, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSA-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-363 ANGELINA 4L', 'Paint', 'RSA-4L', 8, 631.75, 821.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 631.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 631.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 631.75, 5054, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-393 FOXY 4L', 'Paint', 'RSF-4L', 12, 749.08, 973.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 749.08 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 749.08);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 749.08, 8988.96, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSAB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('RAIN OR SHINE RS-833 ALMOST BLACK 4L', 'Paint', 'RSAB-4L', 8, 731.75, 951.27, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 731.75 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 731.75);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 731.75, 5854, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACFRED-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC FIRE RED 4L', 'Paint', 'TOACFRED-4L', 15, 1186.96, 1543.05, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 1186.96 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 1186.96);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 1186.96, 17804.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACGLDTNR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC GOLD TONER 4L', 'Paint', 'TOACGLDTNR-4L', 12, 1320.16, 1716.21, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1320.16 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1320.16);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1320.16, 15841.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACINTRD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC INTERNATIONAL RED 4L', 'Paint', 'TOACINTRD-4L', 2, 1186.96, 1543.05, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 2, cost = 1186.96 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 2, 1186.96);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: INV_06/4-11/26', 1186.96, 2373.92, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACLMNYLW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC LEMON YELLOW 4L', 'Paint', 'TOACLMNYLW-4L', 32, 942.76, 1225.59, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 32, cost = 942.76 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 32, 942.76);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 32, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 32, 'Historical Stock In: INV_06/4-11/26', 942.76, 30168.32, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETCRSE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC METALLIC COARSE 4L', 'Paint', 'TOACMETCRSE-4L', 20, 1033.78, 1343.91, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1033.78 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1033.78);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1033.78, 20675.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETFNE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC METALLIC FINE 4L', 'Paint', 'TOACMETFNE-4L', 20, 1033.78, 1343.91, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1033.78 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1033.78);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1033.78, 20675.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMORNGE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC MOLYBDATE ORANGE 4L', 'Paint', 'TOACMORNGE-4L', 12, 922.78, 1199.61, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 922.78 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 922.78);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 922.78, 11073.36, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACPG-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC PRIMER GRAY 4L', 'Paint', 'TOACPG-4L', 12, 876.9, 1139.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 876.9 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 876.9);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 876.9, 10522.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACPW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC PRIMER WHITE 4L', 'Paint', 'TOACPW-4L', 19, 876.9, 1139.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 19, cost = 876.9 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 19, 876.9);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: INV_06/4-11/26', 876.9, 16661.1, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACREDGLD-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC RED GOLD 4L', 'Paint', 'TOACREDGLD-4L', 20, 1168.46, 1519.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 1168.46 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 1168.46);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 1168.46, 23369.2, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOACTB-4L', 13, 1140.34, 1482.44, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 13, cost = 1140.34 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 13, 1140.34);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: INV_06/4-11/26', 1140.34, 14824.42, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8300-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ULTRA 8300F CRYSTAL 2K CLEAR W/H 1L', 'Paint', 'NP8300-1L', 41, 1505, 1956.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 41, cost = 1505 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 41, 1505);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 41, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 41, 'Historical Stock In: INV_06/4-11/26', 1505, 61705, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI122' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PP BUMPER PRIMER CLEAR 1L', 'Paint', 'PRI122', 23, 665, 864.50, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 23, cost = 665 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 23, 665);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 23, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 23, 'Historical Stock In: INV_06/4-11/26', 665, 15295, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('POLYGLOSS ZINC-PRIMER BASED GREEN W/CAT 1L', 'Paint', 'PGZNCPR-1L', 81, 397.8, 517.14, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 81, cost = 397.8 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 81, 397.8);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 81, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 81, 'Historical Stock In: INV_06/4-11/26', 397.8, 32221.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'UNDRCOATGUN' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WEBER UNDERCOATING SPRAY GUN 616A', 'Paint', 'UNDRCOATGUN', 15, 576, 748.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 15, cost = 576 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 15, 576);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: INV_06/4-11/26', 576, 8640, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 4L', 'Paint', 'WCFWE-4L', 24, 626.34, 814.24, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 626.34 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 626.34);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 626.34, 15032.16, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCGLXWHT-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 1L', 'Paint', 'WCGLXWHT-1L', 36, 140.79, 183.03, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 140.79 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 140.79);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 140.79, 5068.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 4L', 'Paint', 'WCMPRO-4L', 4, 413.35, 537.36, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 4, cost = 413.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 4, 413.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: INV_06/4-11/26', 413.35, 1653.4, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('USA EPOXY PRIMER WHITE W/H 1L', 'Paint', 'USAEPW-1L', 24, 183, 237.90, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 24, cost = 183 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 24, 183);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: INV_06/4-11/26', 183, 4392, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('USA EPOXY PRIMER RED OXIDE W/H 1L', 'Paint', 'USAEPRO-1L', 48, 166, 215.80, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 48, cost = 166 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 48, 166);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 48, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 48, 'Historical Stock In: INV_06/4-11/26', 166, 7968, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE BLACK 1L', 'Paint', 'WCQDBLK-1L', 12, 151.62, 197.11, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 151.62 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 151.62);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 151.62, 1819.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WCQDBLK-4L', 20, 613.7, 797.81, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 20, cost = 613.7 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 20, 613.7);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 20, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 20, 'Historical Stock In: INV_06/4-11/26', 613.7, 12274, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCALORNGE-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE CALIFORNIA ORANGE 4L', 'Paint', 'WCQDCALORNGE-4L', 9, 884.45, 1149.79, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 884.45 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 884.45);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 884.45, 7960.05, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCB-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 1L', 'Paint', 'WCQDCB-1L', 12, 151.62, 197.11, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 151.62 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 151.62);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 151.62, 1819.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCB-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 4L', 'Paint', 'WCQDCB-4L', 16, 559.55, 727.41, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 16, cost = 559.55 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 16, 559.55);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 16, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 16, 'Historical Stock In: INV_06/4-11/26', 559.55, 8952.8, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTHGR-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC THALO GREEN 4L', 'Paint', 'TOACTHGR-4L', 12, 1050.06, 1365.08, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 12, cost = 1050.06 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 12, 1050.06);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: INV_06/4-11/26', 1050.06, 12600.72, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Paint', 'TOAT-4L', 570, 636.48, 827.42, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 570, cost = 636.48 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 570, 636.48);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 570, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 570, 'Historical Stock In: INV_06/4-11/26', 636.48, 362793.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACW-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT ACRYLIC WHITE 4L', 'Paint', 'TOACW-4L', 9, 922.78, 1199.61, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 9, cost = 922.78 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 9, 922.78);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 9, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 9, 'Historical Stock In: INV_06/4-11/26', 922.78, 8305.02, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Paint', 'TOBF-1L', 252, 167.67, 217.97, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 252, cost = 167.67 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 252, 167.67);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 252, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 252, 'Historical Stock In: INV_06/4-11/26', 167.67, 42252.84, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Paint', 'TOBF-4L', 440, 611.34, 794.74, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 440, cost = 611.34 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 440, 611.34);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 440, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 440, 'Historical Stock In: INV_06/4-11/26', 611.34, 268989.6, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOUT-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('TIMEOUT URETHANE THINNER 4L', 'Paint', 'TOUT-4L', 36, 698.88, 908.54, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 36, cost = 698.88 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 36, 698.88);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: INV_06/4-11/26', 698.88, 25159.68, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDM-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('WELCOAT REGULAR QDE MAROON 4L', 'Paint', 'WCQDM-4L', 8, 694.93, 903.41, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 8, cost = 694.93 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 8, 694.93);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: INV_06/4-11/26', 694.93, 5559.44, '2026-06-04');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAS535' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Paint', 'NAS535', -3, 750, 975.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + -3, cost = 750 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, -3, 750);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', -3, 'Historical Stock In: INV_06/4-11/26', '2026-06-04');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', -3, 'Historical Stock In: INV_06/4-11/26', 750, -2250, '2026-06-04');

  -- ==============================================
  -- Invoice: NO-REF-1 | 2026-06-16 | JULIUS CAESAR AYING
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'JULIUS CAESAR AYING' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('JULIUS CAESAR AYING') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'NO-REF-1') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'NO-REF-1', '2026-06-16', 20500)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'NO-REF-1' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('OLD NEWS', 'Paint', 'MSC', 500, 41, 53.30, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 500, cost = 41 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 500, 41);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 500, 'Historical Stock In: NO-REF-1', '2026-06-16');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 500, 'Historical Stock In: NO-REF-1', 41, 20500, '2026-06-16');

  -- ==============================================
  -- Invoice: NO-REF-2 | 2026-06-25 | NIPPON PAINT (COATINGS) PHILS. INC.
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('NIPPON PAINT (COATINGS) PHILS. INC.') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'NO-REF-2') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'NO-REF-2', '2026-06-25', 13000)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'NO-REF-2' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPSPGUN' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('NAX PRO SPRAY GUN', 'Paint', 'NPSPGUN', 1, 13000, 16900.00, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1, cost = 13000 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1, 13000);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: NO-REF-2', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: NO-REF-2', 13000, 13000, '2026-06-25');

  -- ==============================================
  -- Invoice: CSI-12780 | 2026-06-25 | QUADGROUP DISTRIBUTION INC.
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'QUADGROUP DISTRIBUTION INC.' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('QUADGROUP DISTRIBUTION INC.') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'CSI-12780') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'CSI-12780', '2026-06-25', 108515)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'CSI-12780' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 1500', 'Paint', 'EA1500', 1000, 25.3, 32.89, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1000, cost = 25.3 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1000, 25.3);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1000, 'Historical Stock In: CSI-12780', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1000, 'Historical Stock In: CSI-12780', 25.3, 25300, '2026-06-25');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 1200', 'Paint', 'EA1200', 1500, 16.5, 21.45, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1500, cost = 16.5 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1500, 16.5);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1500, 'Historical Stock In: CSI-12780', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1500, 'Historical Stock In: CSI-12780', 16.5, 24750, '2026-06-25');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA100' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER #100', 'Paint', 'EA100', 300, 25.3, 32.89, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 300, cost = 25.3 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 300, 25.3);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 300, 'Historical Stock In: CSI-12780', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 300, 'Historical Stock In: CSI-12780', 25.3, 7590, '2026-06-25');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 120', 'Paint', 'EA120', 1500, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1500, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1500, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1500, 'Historical Stock In: CSI-12780', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1500, 'Historical Stock In: CSI-12780', 20.35, 30525, '2026-06-25');

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NULL THEN
    INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
    VALUES ('EAGLE SANDPAPER 240', 'Paint', 'EA240', 1000, 20.35, 26.46, v_branch_id)
    RETURNING id INTO v_inv_id;
  ELSE
    UPDATE public.inventory SET quantity = quantity + 1000, cost = 20.35 WHERE id = v_inv_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_log_id, v_inv_id, 1000, 20.35);

  INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
  VALUES (v_inv_id, 'paints', 'inbound', 1000, 'Historical Stock In: CSI-12780', '2026-06-25');

  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
  VALUES (v_inv_id, v_branch_id, 'IN', 1000, 'Historical Stock In: CSI-12780', 20.35, 20350, '2026-06-25');

END $$;
