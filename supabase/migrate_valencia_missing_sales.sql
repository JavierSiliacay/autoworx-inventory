
-- Migration for Valencia Missing Sales (No Receipt)
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
  BEGIN

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-120', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1700, 850, 'NAX RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1700, 'Migration: ' || 'NO-RECEIPT-120', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-121', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 40, 120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 40, 'Migration: ' || 'NO-RECEIPT-121', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-122', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, 'QDU GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-122', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-123', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, 'NAX SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'NO-RECEIPT-123', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-124', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'NO-RECEIPT-124', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-125', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-125', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-126', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-126', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-01', '2026-04-01'::timestamp, 'NO-RECEIPT-127', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-127', '2026-04-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-128', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 2300, 2300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 2300, 'Migration: ' || 'NO-RECEIPT-128', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-129', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'NO-RECEIPT-129', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-130', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'NO-RECEIPT-130', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-131', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 220, 440, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 220, 'Migration: ' || 'NO-RECEIPT-131', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-132', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-132', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-133', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-133', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-134', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'NO-RECEIPT-134', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-135', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, 'QDU SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-135', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-136', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 650, 3250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 650, 'Migration: ' || 'NO-RECEIPT-136', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-137', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'NO-RECEIPT-137', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-138', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 620, 620, 'QDU BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 620, 'Migration: ' || 'NO-RECEIPT-138', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-139', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-139', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-140', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-140', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-739' OR product_name = 'COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L', 'ROS-739', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-141', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'NO-RECEIPT-141', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-7000' OR product_name = 'RAIN OR SHINE PREPA WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'ROS-7000', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-142', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'NO-RECEIPT-142', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-143', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'NO-RECEIPT-143', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-144', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-144', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-02', '2026-04-02'::timestamp, 'NO-RECEIPT-145', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 145, 290, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 145, 'Migration: ' || 'NO-RECEIPT-145', '2026-04-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-06', '2026-04-06'::timestamp, 'NO-RECEIPT-146', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-146', '2026-04-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-147', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-147', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 5120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-148', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 5120, 160, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 5120, 'Migration: ' || 'NO-RECEIPT-148', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-149', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-149', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-150', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-150', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-151', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-151', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1027) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-152', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1027, 1027, 'AE LIGHT BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1027, 'Migration: ' || 'NO-RECEIPT-152', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-153', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-153', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-154', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'NO-RECEIPT-154', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-155', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'NO-RECEIPT-155', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-156', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, 'BLUE METALLIC', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-156', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-157', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'NO-RECEIPT-157', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-158', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-158', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-159', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-159', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-07', '2026-04-07'::timestamp, 'NO-RECEIPT-160', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-160', '2026-04-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-161', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'NO-RECEIPT-161', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-162', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-162', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-163', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-163', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-164', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-164', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-165', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-165', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-166', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-166', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-167', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 920, 230, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'NO-RECEIPT-167', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-168', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-168', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-169', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'NO-RECEIPT-169', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-170', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, '527 WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'NO-RECEIPT-170', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-171', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'NO-RECEIPT-171', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-172', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1840, 230, 'NAX RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1840, 'Migration: ' || 'NO-RECEIPT-172', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-08', '2026-04-08'::timestamp, 'NO-RECEIPT-173', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, 'EXT. QDU GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'NO-RECEIPT-173', '2026-04-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-174', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 700, 2100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 700, 'Migration: ' || 'NO-RECEIPT-174', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-175', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'NO-RECEIPT-175', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-176', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-176', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-177', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-177', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-178', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 760, 95, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 760, 'Migration: ' || 'NO-RECEIPT-178', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-179', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-179', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-180', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-180', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-181', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, 'QDU SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'NO-RECEIPT-181', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-182', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-182', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-183', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-183', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-184', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-184', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-185', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-185', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-186', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-186', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-187', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-187', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-09', '2026-04-09'::timestamp, 'NO-RECEIPT-188', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-188', '2026-04-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-189', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, 'QDU YELLOW', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'NO-RECEIPT-189', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-190', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'NO-RECEIPT-190', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-191', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 280, 35, 'QDE YELLOW', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 280, 'Migration: ' || 'NO-RECEIPT-191', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-192', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 280, 35, 'QDE YELLOW', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 280, 'Migration: ' || 'NO-RECEIPT-192', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-193', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'NO-RECEIPT-193', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-194', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-194', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-195', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-195', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-196', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3040, 190, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3040, 'Migration: ' || 'NO-RECEIPT-196', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-197', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 2880, 90, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 2880, 'Migration: ' || 'NO-RECEIPT-197', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-198', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 2880, 90, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 2880, 'Migration: ' || 'NO-RECEIPT-198', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-199', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 900, 225, 'POLYGLOSS RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 900, 'Migration: ' || 'NO-RECEIPT-199', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1440) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-200', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1440, 180, 'NAX BEIGE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1440, 'Migration: ' || 'NO-RECEIPT-200', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-201', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-201', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-202', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-202', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-203', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-203', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-204', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, 'PREMILA BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'NO-RECEIPT-204', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-205', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'NO-RECEIPT-205', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-206', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-206', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-207', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-207', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-10', '2026-04-10'::timestamp, 'NO-RECEIPT-208', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'NO-RECEIPT-208', '2026-04-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-11', '2026-04-11'::timestamp, 'NO-RECEIPT-209', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'NO-RECEIPT-209', '2026-04-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-11', '2026-04-11'::timestamp, 'NO-RECEIPT-210', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.375, 3200, 1200, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 3200, 'Migration: ' || 'NO-RECEIPT-210', '2026-04-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-11', '2026-04-11'::timestamp, 'NO-RECEIPT-211', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, 'QDU GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'NO-RECEIPT-211', '2026-04-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-11', '2026-04-11'::timestamp, 'NO-RECEIPT-212', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'NO-RECEIPT-212', '2026-04-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-11', '2026-04-11'::timestamp, 'NO-RECEIPT-213', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-213', '2026-04-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-214', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.75, 2600, 1950, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2600, 'Migration: ' || 'NO-RECEIPT-214', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-215', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 800, 1600, 'QDU SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 800, 'Migration: ' || 'NO-RECEIPT-215', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-216', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-216', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-217', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, 'NAX GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-217', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-218', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.1, 2400, 240, 'PREMILA GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.1, 2400, 'Migration: ' || 'NO-RECEIPT-218', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-219', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-219', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-220', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-220', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-221', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'NO-RECEIPT-221', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-222', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'NO-RECEIPT-222', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-13', '2026-04-13'::timestamp, 'NO-RECEIPT-223', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-223', '2026-04-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-14', '2026-04-14'::timestamp, 'NO-RECEIPT-224', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 720, 360, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'NO-RECEIPT-224', '2026-04-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-14', '2026-04-14'::timestamp, 'NO-RECEIPT-225', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 640, 80, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 640, 'Migration: ' || 'NO-RECEIPT-225', '2026-04-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-14', '2026-04-14'::timestamp, 'NO-RECEIPT-226', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, 'POLYGLOSS GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'NO-RECEIPT-226', '2026-04-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-15', '2026-04-15'::timestamp, 'NO-RECEIPT-227', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-227', '2026-04-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-15', '2026-04-15'::timestamp, 'NO-RECEIPT-228', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'NO-RECEIPT-228', '2026-04-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 190) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-15', '2026-04-15'::timestamp, 'NO-RECEIPT-229', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 190, 190, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 190, 'Migration: ' || 'NO-RECEIPT-229', '2026-04-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-15', '2026-04-15'::timestamp, 'NO-RECEIPT-230', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2880, 720, 'P19 RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2880, 'Migration: ' || 'NO-RECEIPT-230', '2026-04-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1360) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-16', '2026-04-16'::timestamp, 'NO-RECEIPT-231', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1360, 340, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1360, 'Migration: ' || 'NO-RECEIPT-231', '2026-04-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-16', '2026-04-16'::timestamp, 'NO-RECEIPT-232', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-232', '2026-04-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-233', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'NO-RECEIPT-233', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-234', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, 'NAX ARMY GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-234', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-235', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, 'NAX 1G3 GREY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-235', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-236', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, 'NAX SILVER 1D4', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-236', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-237', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'NO-RECEIPT-237', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-18', '2026-04-18'::timestamp, 'NO-RECEIPT-238', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.1875, 2880, 540, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 2880, 'Migration: ' || 'NO-RECEIPT-238', '2026-04-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-239', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'NO-RECEIPT-239', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-240', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-240', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-241', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, 'NAX BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-241', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-242', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'NO-RECEIPT-242', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-243', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1100, 550, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1100, 'Migration: ' || 'NO-RECEIPT-243', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-244', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'NO-RECEIPT-244', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-21', '2026-04-21'::timestamp, 'NO-RECEIPT-245', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'NO-RECEIPT-245', '2026-04-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-246', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'NO-RECEIPT-246', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-247', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-247', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-248', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-248', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-249', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-249', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-250', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2400, 1200, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2400, 'Migration: ' || 'NO-RECEIPT-250', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-251', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 650, 1300, 'QDU SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 650, 'Migration: ' || 'NO-RECEIPT-251', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-252', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-252', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-253', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 2880, 180, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 2880, 'Migration: ' || 'NO-RECEIPT-253', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-254', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-254', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-255', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-255', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-256', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'NO-RECEIPT-256', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-257', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 760, 380, 'QDU SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 760, 'Migration: ' || 'NO-RECEIPT-257', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-258', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-258', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-259', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 780, 390, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 780, 'Migration: ' || 'NO-RECEIPT-259', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-260', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-260', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-261', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'NO-RECEIPT-261', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-262', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-262', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-263', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-263', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-264', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'NO-RECEIPT-264', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-265', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, 'NAX SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-265', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-266', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 50, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 50, 'Migration: ' || 'NO-RECEIPT-266', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-267', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 65, 195, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 65, 'Migration: ' || 'NO-RECEIPT-267', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-22', '2026-04-22'::timestamp, 'NO-RECEIPT-268', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'NO-RECEIPT-268', '2026-04-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-23', '2026-04-23'::timestamp, 'NO-RECEIPT-269', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 4800, 300, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 4800, 'Migration: ' || 'NO-RECEIPT-269', '2026-04-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-23', '2026-04-23'::timestamp, 'NO-RECEIPT-270', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-270', '2026-04-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-23', '2026-04-23'::timestamp, 'NO-RECEIPT-271', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-271', '2026-04-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-23', '2026-04-23'::timestamp, 'NO-RECEIPT-272', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'NO-RECEIPT-272', '2026-04-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-23', '2026-04-23'::timestamp, 'NO-RECEIPT-273', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, 'NAX BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'NO-RECEIPT-273', '2026-04-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-274', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-274', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-275', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-275', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-276', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1200, 2400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1200, 'Migration: ' || 'NO-RECEIPT-276', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-277', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, 'QDU ARMY GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'NO-RECEIPT-277', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-278', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 600, 900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 600, 'Migration: ' || 'NO-RECEIPT-278', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-279', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-279', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-280', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-280', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-281', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-281', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-24', '2026-04-24'::timestamp, 'NO-RECEIPT-282', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 880, 440, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 880, 'Migration: ' || 'NO-RECEIPT-282', '2026-04-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-25', '2026-04-25'::timestamp, 'NO-RECEIPT-283', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-283', '2026-04-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-25', '2026-04-25'::timestamp, 'NO-RECEIPT-284', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'NO-RECEIPT-284', '2026-04-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-25', '2026-04-25'::timestamp, 'NO-RECEIPT-285', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-285', '2026-04-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-25', '2026-04-25'::timestamp, 'NO-RECEIPT-286', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 4000, 500, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4000, 'Migration: ' || 'NO-RECEIPT-286', '2026-04-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-287', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-287', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-288', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-288', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-289', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 35, 210, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 35, 'Migration: ' || 'NO-RECEIPT-289', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-290', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 95, 95, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 95, 'Migration: ' || 'NO-RECEIPT-290', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-291', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'NO-RECEIPT-291', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-27', '2026-04-27'::timestamp, 'NO-RECEIPT-292', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE: U25 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-292', '2026-04-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-293', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1560, 390, 'NAX PEARL', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1560, 'Migration: ' || 'NO-RECEIPT-293', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-294', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-294', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-295', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 240, 240, 'QDE YELLOW', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'NO-RECEIPT-295', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-296', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-296', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-297', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 960, 60, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'NO-RECEIPT-297', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1080) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-298', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1080, 270, 'NAX GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1080, 'Migration: ' || 'NO-RECEIPT-298', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-299', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, 'NAX RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'NO-RECEIPT-299', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-300', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'NO-RECEIPT-300', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-301', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-301', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-302', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-302', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-303', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-303', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-28', '2026-04-28'::timestamp, 'NO-RECEIPT-304', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-304', '2026-04-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-305', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 920, 230, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'NO-RECEIPT-305', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-306', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 1500, 4500, 'NAX RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 1500, 'Migration: ' || 'NO-RECEIPT-306', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-307', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 250, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 250, 'Migration: ' || 'NO-RECEIPT-307', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-308', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 95, 95, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 95, 'Migration: ' || 'NO-RECEIPT-308', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-309', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'NO-RECEIPT-309', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-310', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, 'NAX GOLD', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'NO-RECEIPT-310', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-311', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, '1D6 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-311', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-29', '2026-04-29'::timestamp, 'NO-RECEIPT-312', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 850, 1700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 850, 'Migration: ' || 'NO-RECEIPT-312', '2026-04-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-313', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1100, 2200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1100, 'Migration: ' || 'NO-RECEIPT-313', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-314', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 560, 560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 560, 'Migration: ' || 'NO-RECEIPT-314', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-315', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-315', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-316', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'NO-RECEIPT-316', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-317', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-317', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-318', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 210, 420, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 210, 'Migration: ' || 'NO-RECEIPT-318', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-LTR' OR product_name = 'NIPPON METAL PRIMER RED OXIDE LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'NMPREDOX-LTR', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-319', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'NO-RECEIPT-319', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-320', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 4000, 1000, 'REPACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 4000, 'Migration: ' || 'NO-RECEIPT-320', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-04-30', '2026-04-30'::timestamp, 'NO-RECEIPT-321', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, 'NAX BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'NO-RECEIPT-321', '2026-04-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-397', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 4000, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4000, 'Migration: ' || 'NO-RECEIPT-397', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-398', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-398', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-399', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 100, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 100, 'Migration: ' || 'NO-RECEIPT-399', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-400', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 100, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 100, 'Migration: ' || 'NO-RECEIPT-400', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-401', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-401', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-402', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-402', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-403', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'NO-RECEIPT-403', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-404', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 210, 210, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 210, 'Migration: ' || 'NO-RECEIPT-404', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-405', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'NO-RECEIPT-405', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-406', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-406', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-407', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-407', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-418', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-418', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-17', '2026-06-17'::timestamp, 'NO-RECEIPT-419', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-419', '2026-06-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-548', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'NO-RECEIPT-548', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-549', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-549', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-550', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'NO-RECEIPT-550', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-551', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-551', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-552', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-552', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-553', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-553', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-554', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-554', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-01', '2026-05-01'::timestamp, 'NO-RECEIPT-555', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'NO-RECEIPT-555', '2026-05-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-556', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-556', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-557', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'NO-RECEIPT-557', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-558', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-558', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-559', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'NO-RECEIPT-559', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-560', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-560', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-561', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:209 BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-561', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-562', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:A66 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-562', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-563', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'NO-RECEIPT-563', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-564', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'NO-RECEIPT-564', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-02', '2026-05-02'::timestamp, 'NO-RECEIPT-565', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'NO-RECEIPT-565', '2026-05-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-03', '2026-05-03'::timestamp, 'NO-RECEIPT-566', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-566', '2026-05-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-03', '2026-05-03'::timestamp, 'NO-RECEIPT-567', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-567', '2026-05-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-03', '2026-05-03'::timestamp, 'NO-RECEIPT-568', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2000, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2000, 'Migration: ' || 'NO-RECEIPT-568', '2026-05-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-03', '2026-05-03'::timestamp, 'NO-RECEIPT-569', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'NO-RECEIPT-569', '2026-05-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-05', '2026-05-05'::timestamp, 'NO-RECEIPT-579', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'NO-RECEIPT-579', '2026-05-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-580', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-580', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-581', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 185, 185, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 185, 'Migration: ' || 'NO-RECEIPT-581', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-582', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-582', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-583', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-583', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-584', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-584', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-585', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-585', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-586', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'NO-RECEIPT-586', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-587', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-587', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-588', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'NO-RECEIPT-588', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-06', '2026-05-06'::timestamp, 'NO-RECEIPT-589', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'NO-RECEIPT-589', '2026-05-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-590', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-590', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-591', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'NO-RECEIPT-591', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-592', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-592', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-593', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-593', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-594', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-594', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-595', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-595', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-596', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-596', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-597', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-597', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-598', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-598', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-599', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-599', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-07', '2026-05-07'::timestamp, 'NO-RECEIPT-600', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'NO-RECEIPT-600', '2026-05-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-601', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-601', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-602', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'NO-RECEIPT-602', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-603', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-603', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-604', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1280, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1280, 'Migration: ' || 'NO-RECEIPT-604', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-605', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-605', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-606', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-606', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-607', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-607', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-608', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-608', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-609', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'NO-RECEIPT-609', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-610', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'NO-RECEIPT-610', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-611', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'NO-RECEIPT-611', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-612', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 2700, 4050, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 2700, 'Migration: ' || 'NO-RECEIPT-612', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-613', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'NO-RECEIPT-613', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-614', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-614', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 275) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-615', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 275, 275, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 275, 'Migration: ' || 'NO-RECEIPT-615', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-08', '2026-05-08'::timestamp, 'NO-RECEIPT-616', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'NO-RECEIPT-616', '2026-05-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-619', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'NO-RECEIPT-619', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3413.33) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-620', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.375, 3413.33, 1279.99875, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 3413.33, 'Migration: ' || 'NO-RECEIPT-620', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTB-4L' OR product_name = 'POLYGLOSS PU PHTHALO BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU PHTHALO BLUE 4L', 'PGTB-4L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-621', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2720, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'NO-RECEIPT-621', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SAFARE-4L' OR product_name = 'ROS-SAFARI BROWN_4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROS-SAFARI BROWN_4L', 'ROS-SAFARE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-622', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'NO-RECEIPT-622', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BBR-MINI' OR product_name = 'DRAGONFLY MINI BABY ROLLER #4 W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'BBR-MINI', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-623', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-623', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-624', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-624', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-625', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'NO-RECEIPT-625', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-626', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-626', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-627', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2400, 300, 'CODE:U17 GREY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'NO-RECEIPT-627', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-628', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-628', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1' OR product_name = 'UNKNOWN ITEM 2B-PB-1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNKNOWN ITEM 2B-PB-1', '2B-PB-1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-629', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-629', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('0206-09-05', '0206-09-05'::timestamp, 'NO-RECEIPT-630', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 300, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 300, 'Migration: ' || 'NO-RECEIPT-630', '0206-09-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-631', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'NO-RECEIPT-631', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-632', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-632', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-633', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'NO-RECEIPT-633', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-367' OR product_name = 'CANDY TUFF ROS-367 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'ROS-367', v_branch_id, 0, 870) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-634', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 870, 2610, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 870, 'Migration: ' || 'NO-RECEIPT-634', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-635', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-635', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPR7' OR product_name = 'NIPPON ROLLER PAINT #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ROLLER PAINT #7', 'NPR7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-11', '2026-05-11'::timestamp, 'NO-RECEIPT-636', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'NO-RECEIPT-636', '2026-05-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-637', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-637', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-638', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-638', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-639', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 615, 2460, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 615, 'Migration: ' || 'NO-RECEIPT-639', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-640', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-640', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-641', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-641', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-12', '2026-05-12'::timestamp, 'NO-RECEIPT-642', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 16, 35, 560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 16, 35, 'Migration: ' || 'NO-RECEIPT-642', '2026-05-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-643', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-643', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BPAD' OR product_name = 'BUFFING PAD') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BUFFING PAD', 'BPAD', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-644', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1050, 1050, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1050, 'Migration: ' || 'NO-RECEIPT-644', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-645', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-645', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-646', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'NO-RECEIPT-646', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-647', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-647', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-648', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'NO-RECEIPT-648', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-649', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-649', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-650', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-650', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-651', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-651', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-652', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'NO-RECEIPT-652', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-13', '2026-05-13'::timestamp, 'NO-RECEIPT-653', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'NO-RECEIPT-653', '2026-05-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-654', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'NO-RECEIPT-654', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-655', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:1D6 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-655', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-656', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 2800, 5600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 2800, 'Migration: ' || 'NO-RECEIPT-656', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-657', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'NO-RECEIPT-657', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-658', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'NO-RECEIPT-658', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 6080) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-659', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 6080, 190, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 6080, 'Migration: ' || 'NO-RECEIPT-659', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-660', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1200, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1200, 'Migration: ' || 'NO-RECEIPT-660', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-14', '2026-05-14'::timestamp, 'NO-RECEIPT-662', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-662', '2026-05-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-663', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-663', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-664', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 3040, 380, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3040, 'Migration: ' || 'NO-RECEIPT-664', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-665', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:C17', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-665', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-666', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-666', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-667', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 95, 285, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 95, 'Migration: ' || 'NO-RECEIPT-667', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-15', '2026-05-15'::timestamp, 'NO-RECEIPT-668', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 95, 285, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 95, 'Migration: ' || 'NO-RECEIPT-668', '2026-05-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-669', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'NO-RECEIPT-669', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-670', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 300, 1200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 300, 'Migration: ' || 'NO-RECEIPT-670', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-671', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-671', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PTRL-7' OR product_name = 'DRAGONFLY PAINT ROLLER #7 W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'PTRL-7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-672', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'NO-RECEIPT-672', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-673', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'NO-RECEIPT-673', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-16', '2026-05-16'::timestamp, 'NO-RECEIPT-674', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-674', '2026-05-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BRIDE-4L' OR product_name = 'ROS-BRIDAL GOWN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROS-BRIDAL GOWN-4L', 'ROS-BRIDE-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-675', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'NO-RECEIPT-675', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-676', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'NO-RECEIPT-676', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-677', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'NO-RECEIPT-677', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-678', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-678', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-679', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'NO-RECEIPT-679', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-680', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-680', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-681', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-681', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-682', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 260, 260, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'NO-RECEIPT-682', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-683', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-683', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-684', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-684', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-685', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-685', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-686', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'NO-RECEIPT-686', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-687', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 100, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 100, 'Migration: ' || 'NO-RECEIPT-687', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-18', '2026-05-18'::timestamp, 'NO-RECEIPT-688', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-688', '2026-05-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-689', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'NO-RECEIPT-689', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-690', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'NO-RECEIPT-690', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-691', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-691', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-692', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-692', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-693', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-693', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-694', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-694', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-695', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-695', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-696', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-696', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-19', '2026-05-19'::timestamp, 'NO-RECEIPT-697', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 960, 120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 960, 'Migration: ' || 'NO-RECEIPT-697', '2026-05-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 5600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-20', '2026-05-20'::timestamp, 'NO-RECEIPT-698', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 5600, 2800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 5600, 'Migration: ' || 'NO-RECEIPT-698', '2026-05-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-20', '2026-05-20'::timestamp, 'NO-RECEIPT-699', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'NO-RECEIPT-699', '2026-05-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-20', '2026-05-20'::timestamp, 'NO-RECEIPT-700', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 2600, 2600, 'CODE: 1E7 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'NO-RECEIPT-700', '2026-05-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMF-4L' OR product_name = 'POLYGLOSS PU MICA RED FINE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'PGMF-4L', v_branch_id, 0, 2200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-701', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2200, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2200, 'Migration: ' || 'NO-RECEIPT-701', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-702', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'NO-RECEIPT-702', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-703', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'NO-RECEIPT-703', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-704', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'NO-RECEIPT-704', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-705', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'NO-RECEIPT-705', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-706', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-706', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-707', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 1000, 4000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 1000, 'Migration: ' || 'NO-RECEIPT-707', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-708', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-708', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-709', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-709', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-21', '2026-05-21'::timestamp, 'NO-RECEIPT-710', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-710', '2026-05-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-711', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-711', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-712', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-712', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-19', '2026-06-19'::timestamp, 'NO-RECEIPT-713', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-713', '2026-06-19'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-714', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'NO-RECEIPT-714', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-715', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-715', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-716', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 400, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 400, 'Migration: ' || 'NO-RECEIPT-716', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BBR-MINI' OR product_name = 'DRAGONFLY MINI BABY ROLLER #4 W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'BBR-MINI', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-717', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-717', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-718', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'NO-RECEIPT-718', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-719', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'NO-RECEIPT-719', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-720', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'NO-RECEIPT-720', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-721', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-721', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-722', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-722', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-723', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-723', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-724', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-724', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-22', '2026-05-22'::timestamp, 'NO-RECEIPT-725', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'NO-RECEIPT-725', '2026-05-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 730) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-726', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 730, 730, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 730, 'Migration: ' || 'NO-RECEIPT-726', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-727', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 570, 1710, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 570, 'Migration: ' || 'NO-RECEIPT-727', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-728', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-728', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-729', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE;IM GREY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-729', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 6080) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-730', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 6080, 380, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 6080, 'Migration: ' || 'NO-RECEIPT-730', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-23', '2026-05-23'::timestamp, 'NO-RECEIPT-731', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 4400, 2200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 4400, 'Migration: ' || 'NO-RECEIPT-731', '2026-05-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-25', '2026-05-25'::timestamp, 'NO-RECEIPT-732', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 260, 130, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 260, 'Migration: ' || 'NO-RECEIPT-732', '2026-05-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-25', '2026-05-25'::timestamp, 'NO-RECEIPT-733', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-733', '2026-05-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-25', '2026-05-25'::timestamp, 'NO-RECEIPT-734', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-734', '2026-05-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-4L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'LATEXMIX-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-26', '2026-05-26'::timestamp, 'NO-RECEIPT-735', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 900, 1800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 900, 'Migration: ' || 'NO-RECEIPT-735', '2026-05-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-26', '2026-05-26'::timestamp, 'NO-RECEIPT-736', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-736', '2026-05-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-26', '2026-05-26'::timestamp, 'NO-RECEIPT-737', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'NO-RECEIPT-737', '2026-05-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-27', '2026-05-27'::timestamp, 'NO-RECEIPT-738', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-738', '2026-05-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-27', '2026-05-27'::timestamp, 'NO-RECEIPT-739', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'NO-RECEIPT-739', '2026-05-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-27', '2026-05-27'::timestamp, 'NO-RECEIPT-740', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 250, 1250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 250, 'Migration: ' || 'NO-RECEIPT-740', '2026-05-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-27', '2026-05-27'::timestamp, 'NO-RECEIPT-741', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 640, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 640, 'Migration: ' || 'NO-RECEIPT-741', '2026-05-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-28', '2026-05-28'::timestamp, 'NO-RECEIPT-742', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 135, 270, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 135, 'Migration: ' || 'NO-RECEIPT-742', '2026-05-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZPRGR-145' OR product_name = 'PYLOX LAZER PRIMER GRAY 145') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER PRIMER GRAY 145', 'PLYZPRGR-145', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-28', '2026-05-28'::timestamp, 'NO-RECEIPT-743', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 135, 270, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 135, 'Migration: ' || 'NO-RECEIPT-743', '2026-05-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-744', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, 'CODE:COLOR RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'NO-RECEIPT-744', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-745', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'NO-RECEIPT-745', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-746', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-746', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-747', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 800, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 800, 'Migration: ' || 'NO-RECEIPT-747', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-748', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'NO-RECEIPT-748', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-749', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'NO-RECEIPT-749', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDG-4L' OR product_name = 'PLATONE QDE GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE GREEN 4L', 'PLQDG-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-750', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 900, 1800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 900, 'Migration: ' || 'NO-RECEIPT-750', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 265) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-751', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 265, 265, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 265, 'Migration: ' || 'NO-RECEIPT-751', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-29', '2026-05-29'::timestamp, 'NO-RECEIPT-752', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-752', '2026-05-29'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-30', '2026-05-30'::timestamp, 'NO-RECEIPT-753', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-753', '2026-05-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-05-30', '2026-05-30'::timestamp, 'NO-RECEIPT-754', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'NO-RECEIPT-754', '2026-05-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-20', '2026-06-20'::timestamp, 'NO-RECEIPT-856', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-856', '2026-06-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-20', '2026-06-20'::timestamp, 'NO-RECEIPT-858', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-858', '2026-06-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-22', '2026-06-22'::timestamp, 'NO-RECEIPT-923', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-923', '2026-06-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-22', '2026-06-22'::timestamp, 'NO-RECEIPT-924', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'NO-RECEIPT-924', '2026-06-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-22', '2026-06-22'::timestamp, 'NO-RECEIPT-963', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'NO-RECEIPT-963', '2026-06-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-22', '2026-06-22'::timestamp, 'NO-RECEIPT-964', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'NO-RECEIPT-964', '2026-06-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-987', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-987', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-988', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-988', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-989', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-989', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-990', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-990', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-991', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'NO-RECEIPT-991', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-992', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 800, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 800, 'Migration: ' || 'NO-RECEIPT-992', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 5760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-993', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 5760, 180, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 5760, 'Migration: ' || 'NO-RECEIPT-993', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-994', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-994', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-995', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, 'CODE:554 BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'NO-RECEIPT-995', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-996', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-996', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-997', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-997', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-998', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'NO-RECEIPT-998', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-999', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'NO-RECEIPT-999', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1000', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'NO-RECEIPT-1000', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1001', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'NO-RECEIPT-1001', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1002', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 2650, 2650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 2650, 'Migration: ' || 'NO-RECEIPT-1002', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 420) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1003', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 12, 420, 5040, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 12, 420, 'Migration: ' || 'NO-RECEIPT-1003', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1004', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1004', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1005', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1005', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-01', '2026-06-01'::timestamp, 'NO-RECEIPT-1006', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 960, 60, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'NO-RECEIPT-1006', '2026-06-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBPNTSTRNR' OR product_name = 'ROBFILTER PAINT STRAINER 125M') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBFILTER PAINT STRAINER 125M', 'ROBPNTSTRNR', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-22', '2026-06-22'::timestamp, 'NO-RECEIPT-1007', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1007', '2026-06-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1008', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1008', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1009', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2720, 680, 'CODE:W85 WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'NO-RECEIPT-1009', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 783) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1010', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.125, 783, 880.875, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.125, 783, 'Migration: ' || 'NO-RECEIPT-1010', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1011', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'NO-RECEIPT-1011', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1012', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1012', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1013', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1013', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-02', '2026-06-02'::timestamp, 'NO-RECEIPT-1014', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1014', '2026-06-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-03', '2026-06-03'::timestamp, 'NO-RECEIPT-1015', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1015', '2026-06-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-03', '2026-06-03'::timestamp, 'NO-RECEIPT-1016', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.2, 2700, 540, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2700, 'Migration: ' || 'NO-RECEIPT-1016', '2026-06-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-03', '2026-06-03'::timestamp, 'NO-RECEIPT-1017', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 100, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 100, 'Migration: ' || 'NO-RECEIPT-1017', '2026-06-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-03', '2026-06-03'::timestamp, 'NO-RECEIPT-1018', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1018', '2026-06-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-04', '2026-06-04'::timestamp, 'NO-RECEIPT-1019', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'NO-RECEIPT-1019', '2026-06-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-04', '2026-06-04'::timestamp, 'NO-RECEIPT-1020', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-1020', '2026-06-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-04', '2026-06-04'::timestamp, 'NO-RECEIPT-1021', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'NO-RECEIPT-1021', '2026-06-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROSCB-1L' OR product_name = 'RAIN OR SHINE CHOCOLATE BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE CHOCOLATE BROWN 1L', 'ROSCB-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-04', '2026-06-04'::timestamp, 'NO-RECEIPT-1022', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1022', '2026-06-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1023', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'NO-RECEIPT-1023', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1024', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1024', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1025', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1025', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1026', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'NO-RECEIPT-1026', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1027', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 16, 35, 560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 16, 35, 'Migration: ' || 'NO-RECEIPT-1027', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-05', '2026-06-05'::timestamp, 'NO-RECEIPT-1028', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'NO-RECEIPT-1028', '2026-06-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-06', '2026-06-06'::timestamp, 'NO-RECEIPT-1029', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2560, 320, 'CODE: 218 BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2560, 'Migration: ' || 'NO-RECEIPT-1029', '2026-06-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-06', '2026-06-06'::timestamp, 'NO-RECEIPT-1030', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'NO-RECEIPT-1030', '2026-06-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-08', '2026-06-08'::timestamp, 'NO-RECEIPT-1031', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'NO-RECEIPT-1031', '2026-06-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-08', '2026-06-08'::timestamp, 'NO-RECEIPT-1032', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-1032', '2026-06-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-08', '2026-06-08'::timestamp, 'NO-RECEIPT-1033', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1033', '2026-06-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-08', '2026-06-08'::timestamp, 'NO-RECEIPT-1034', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'NO-RECEIPT-1034', '2026-06-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2320) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-09', '2026-06-09'::timestamp, 'NO-RECEIPT-1035', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2320, 580, 'CODE:WAH RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2320, 'Migration: ' || 'NO-RECEIPT-1035', '2026-06-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-09', '2026-06-09'::timestamp, 'NO-RECEIPT-1036', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1036', '2026-06-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-09', '2026-06-09'::timestamp, 'NO-RECEIPT-1037', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'NO-RECEIPT-1037', '2026-06-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-09', '2026-06-09'::timestamp, 'NO-RECEIPT-1038', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'NO-RECEIPT-1038', '2026-06-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-09', '2026-06-09'::timestamp, 'NO-RECEIPT-1039', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'NO-RECEIPT-1039', '2026-06-09'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-10', '2026-06-10'::timestamp, 'NO-RECEIPT-1040', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 3400, 1700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 3400, 'Migration: ' || 'NO-RECEIPT-1040', '2026-06-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 2933.33) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-10', '2026-06-10'::timestamp, 'NO-RECEIPT-1041', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.375, 2933.33, 1099.99875, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 2933.33, 'Migration: ' || 'NO-RECEIPT-1041', '2026-06-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1045', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1045', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1046', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-1046', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1047', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'NO-RECEIPT-1047', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1048', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'NO-RECEIPT-1048', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1049', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1049', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1050', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1050', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1051', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1051', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1052', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1052', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-11', '2026-06-11'::timestamp, 'NO-RECEIPT-1053', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'NO-RECEIPT-1053', '2026-06-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1054', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-1054', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1055', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, 'CODE:U17 GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-1055', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-12', '2026-06-12'::timestamp, 'NO-RECEIPT-1056', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1056', '2026-06-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-12', '2026-06-12'::timestamp, 'NO-RECEIPT-1057', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'NO-RECEIPT-1057', '2026-06-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-12', '2026-06-12'::timestamp, 'NO-RECEIPT-1058', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1058', '2026-06-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-12', '2026-06-12'::timestamp, 'NO-RECEIPT-1059', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1059', '2026-06-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-12', '2026-06-12'::timestamp, 'NO-RECEIPT-1060', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-1060', '2026-06-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1061', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1061', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1062', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'NO-RECEIPT-1062', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1063', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1063', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1064', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1064', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1065', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'NO-RECEIPT-1065', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1066', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1066', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1067', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1067', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEEKBOS-1L' OR product_name = 'MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'MEEKBOS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1068', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'NO-RECEIPT-1068', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 60) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-13', '2026-06-13'::timestamp, 'NO-RECEIPT-1069', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 60, 60, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 60, 'Migration: ' || 'NO-RECEIPT-1069', '2026-06-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-15', '2026-06-15'::timestamp, 'NO-RECEIPT-1070', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1070', '2026-06-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-15', '2026-06-15'::timestamp, 'NO-RECEIPT-1071', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1071', '2026-06-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-15', '2026-06-15'::timestamp, 'NO-RECEIPT-1072', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, 'CODE:8X2 BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'NO-RECEIPT-1072', '2026-06-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-15', '2026-06-15'::timestamp, 'NO-RECEIPT-1073', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'NO-RECEIPT-1073', '2026-06-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-15', '2026-06-15'::timestamp, 'NO-RECEIPT-1074', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'NO-RECEIPT-1074', '2026-06-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-710' OR product_name = 'BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'B-710', v_branch_id, 0, 870) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-16', '2026-06-16'::timestamp, 'NO-RECEIPT-1075', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 870, 870, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 870, 'Migration: ' || 'NO-RECEIPT-1075', '2026-06-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-16', '2026-06-16'::timestamp, 'NO-RECEIPT-1076', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.5, 2800, 1400, 'CODE:ZLL', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'NO-RECEIPT-1076', '2026-06-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT740' OR product_name = 'NAX NAT-740 TTC ULTRA FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'NAT740', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-16', '2026-06-16'::timestamp, 'NO-RECEIPT-1077', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'NO-RECEIPT-1077', '2026-06-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1083', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'NO-RECEIPT-1083', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOPT-BOT' OR product_name = 'UNO PAINT THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO PAINT THINNER BOT', 'UNOPT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1123', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 80, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 80, 'Migration: ' || 'NO-RECEIPT-1123', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1124', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1760, 440, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1760, 'Migration: ' || 'NO-RECEIPT-1124', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-23', '2026-06-23'::timestamp, 'NO-RECEIPT-1125', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, 'CODE:1D4 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-1125', '2026-06-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2933.333333) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1141', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.1875, 2933.333333, 550, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 2933.333333, 'Migration: ' || 'NO-RECEIPT-1141', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1142', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 240, 480, 'PLATONE QDE BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'NO-RECEIPT-1142', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1143', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1143', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1144', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1144', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 860) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1145', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 860, 430, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 860, 'Migration: ' || 'NO-RECEIPT-1145', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1146', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'NO-RECEIPT-1146', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-24', '2026-06-24'::timestamp, 'NO-RECEIPT-1147', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'NO-RECEIPT-1147', '2026-06-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-25', '2026-06-25'::timestamp, 'NO-RECEIPT-1162', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1500, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1500, 'Migration: ' || 'NO-RECEIPT-1162', '2026-06-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-25', '2026-06-25'::timestamp, 'NO-RECEIPT-1163', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.125, 2000, 250, 'CODE: A6C COOL WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2000, 'Migration: ' || 'NO-RECEIPT-1163', '2026-06-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-25', '2026-06-25'::timestamp, 'NO-RECEIPT-1164', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'NO-RECEIPT-1164', '2026-06-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-26', '2026-06-26'::timestamp, 'NO-RECEIPT-1168', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:U33', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1168', '2026-06-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-26', '2026-06-26'::timestamp, 'NO-RECEIPT-1169', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1169', '2026-06-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-26', '2026-06-26'::timestamp, 'NO-RECEIPT-1170', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'NO-RECEIPT-1170', '2026-06-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-26', '2026-06-26'::timestamp, 'NO-RECEIPT-1171', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, 'CODE:3Q3 RED', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'NO-RECEIPT-1171', '2026-06-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 5200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-26', '2026-06-26'::timestamp, 'NO-RECEIPT-1172', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.75, 5200, 3900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 5200, 'Migration: ' || 'NO-RECEIPT-1172', '2026-06-26'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-1L' OR product_name = 'PLATONE QDE BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 1L', 'PLQDB-1L', v_branch_id, 0, 1066.666667) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1187', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.1875, 1066.666667, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 1066.666667, 'Migration: ' || 'NO-RECEIPT-1187', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1188', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1188', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1189', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1189', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1190', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1190', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1191', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1191', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-27', '2026-06-27'::timestamp, 'NO-RECEIPT-1192', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1192', '2026-06-27'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-28', '2026-06-28'::timestamp, 'NO-RECEIPT-1193', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 230, 690, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 230, 'Migration: ' || 'NO-RECEIPT-1193', '2026-06-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-28', '2026-06-28'::timestamp, 'NO-RECEIPT-1194', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'NO-RECEIPT-1194', '2026-06-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-28', '2026-06-28'::timestamp, 'NO-RECEIPT-1195', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 960, 240, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 960, 'Migration: ' || 'NO-RECEIPT-1195', '2026-06-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-28', '2026-06-28'::timestamp, 'NO-RECEIPT-1196', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1120, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1120, 'Migration: ' || 'NO-RECEIPT-1196', '2026-06-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-28', '2026-06-28'::timestamp, 'NO-RECEIPT-1197', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'NO-RECEIPT-1197', '2026-06-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1198', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 850, 850, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 850, 'Migration: ' || 'NO-RECEIPT-1198', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1199', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, 'CODE:W85 WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'NO-RECEIPT-1199', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1200', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, 'CODE:W85 PEARL', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'NO-RECEIPT-1200', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1201', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-1201', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1202', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'NO-RECEIPT-1202', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1203', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1203', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1204', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1204', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1205', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1205', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1206', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1206', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1207', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'NO-RECEIPT-1207', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1208', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1208', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1209', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 600, 1200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 600, 'Migration: ' || 'NO-RECEIPT-1209', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1210', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 570, 855, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 570, 'Migration: ' || 'NO-RECEIPT-1210', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1211', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-1211', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1983' OR product_name = 'NIPPELAC ACE JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPELAC ACE JET BLACK 4L', 'NPA1983', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1212', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1800, 450, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1800, 'Migration: ' || 'NO-RECEIPT-1212', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1213', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1213', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-06-30', '2026-06-30'::timestamp, 'NO-RECEIPT-1214', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'NO-RECEIPT-1214', '2026-06-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1215', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1215', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1216', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-1216', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1217', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1900, 950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1900, 'Migration: ' || 'NO-RECEIPT-1217', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1218', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-1218', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1219', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1219', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1222', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'NO-RECEIPT-1222', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-01', '2026-07-01'::timestamp, 'NO-RECEIPT-1223', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.75, 2400, 1800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2400, 'Migration: ' || 'NO-RECEIPT-1223', '2026-07-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901R-1L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'MEG3901R-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1236', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 300, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 300, 'Migration: ' || 'NO-RECEIPT-1236', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1237', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'NO-RECEIPT-1237', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1241', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-1241', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1242', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1242', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1243', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'NO-RECEIPT-1243', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1244', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1244', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-02', '2026-07-02'::timestamp, 'NO-RECEIPT-1245', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'NO-RECEIPT-1245', '2026-07-02'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1247', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.2, 2900, 580, 'CODE:595 ORANGE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2900, 'Migration: ' || 'NO-RECEIPT-1247', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1248', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'NO-RECEIPT-1248', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1249', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1249', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1250', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1250', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1252', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1252', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1253', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1253', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1254', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'NO-RECEIPT-1254', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1255', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'NO-RECEIPT-1255', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1256', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-1256', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1257', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-1257', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1258', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1258', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1259', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1259', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1260', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1260', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1261', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1261', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1262', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1262', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1263', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1263', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1264', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'NO-RECEIPT-1264', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1265', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1265', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 610) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1266', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 610, 610, 'OFF WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 610, 'Migration: ' || 'NO-RECEIPT-1266', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-03', '2026-07-03'::timestamp, 'NO-RECEIPT-1267', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1267', '2026-07-03'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-04', '2026-07-04'::timestamp, 'NO-RECEIPT-1273', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'NO-RECEIPT-1273', '2026-07-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-06', '2026-07-06'::timestamp, 'NO-RECEIPT-1277', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'NO-RECEIPT-1277', '2026-07-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-06', '2026-07-06'::timestamp, 'NO-RECEIPT-1284', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'NO-RECEIPT-1284', '2026-07-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-06', '2026-07-06'::timestamp, 'NO-RECEIPT-1285', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2400, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'NO-RECEIPT-1285', '2026-07-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-06', '2026-07-06'::timestamp, 'NO-RECEIPT-1286', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1286', '2026-07-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1288', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'NO-RECEIPT-1288', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1289', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'NO-RECEIPT-1289', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1290', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1290', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1291', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'NO-RECEIPT-1291', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1292', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1292', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1293', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'NO-RECEIPT-1293', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1294', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'NO-RECEIPT-1294', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1295', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'NO-RECEIPT-1295', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITSHLDALL-BOT' OR product_name = 'DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'DOITSHLDALL-BOT', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1296', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 185, 185, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 185, 'Migration: ' || 'NO-RECEIPT-1296', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1297', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 560, 1120, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 560, 'Migration: ' || 'NO-RECEIPT-1297', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1301', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'NO-RECEIPT-1301', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1302', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, 'CODE:393', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'NO-RECEIPT-1302', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1303', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1303', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1304', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1304', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1305', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'NO-RECEIPT-1305', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1306', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1306', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-07', '2026-07-07'::timestamp, 'NO-RECEIPT-1307', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 700, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 700, 'Migration: ' || 'NO-RECEIPT-1307', '2026-07-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-08', '2026-07-08'::timestamp, 'NO-RECEIPT-1309', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1309', '2026-07-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-08', '2026-07-08'::timestamp, 'NO-RECEIPT-1310', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1310', '2026-07-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-08', '2026-07-08'::timestamp, 'NO-RECEIPT-1311', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1311', '2026-07-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-08', '2026-07-08'::timestamp, 'NO-RECEIPT-1312', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1312', '2026-07-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-13', '2026-07-13'::timestamp, 'NO-RECEIPT-1352', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 250, 250, 'OFF WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1352', '2026-07-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-13', '2026-07-13'::timestamp, 'NO-RECEIPT-1368', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'NO-RECEIPT-1368', '2026-07-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-13', '2026-07-13'::timestamp, 'NO-RECEIPT-1369', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 4400, 4400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 4400, 'Migration: ' || 'NO-RECEIPT-1369', '2026-07-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-14', '2026-07-14'::timestamp, 'NO-RECEIPT-1377', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'NO-RECEIPT-1377', '2026-07-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2560) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-14', '2026-07-14'::timestamp, 'NO-RECEIPT-1378', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2560, 320, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2560, 'Migration: ' || 'NO-RECEIPT-1378', '2026-07-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-14', '2026-07-14'::timestamp, 'NO-RECEIPT-1389', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.5, 640, 320, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 640, 'Migration: ' || 'NO-RECEIPT-1389', '2026-07-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-14', '2026-07-14'::timestamp, 'NO-RECEIPT-1390', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.125, 2400, 300, '531 PEARL', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'NO-RECEIPT-1390', '2026-07-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-15', '2026-07-15'::timestamp, 'NO-RECEIPT-1398', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'NO-RECEIPT-1398', '2026-07-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-15', '2026-07-15'::timestamp, 'NO-RECEIPT-1399', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1399', '2026-07-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-15', '2026-07-15'::timestamp, 'NO-RECEIPT-1400', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'NO-RECEIPT-1400', '2026-07-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-15', '2026-07-15'::timestamp, 'NO-RECEIPT-1401', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, 'CODE:070 PEARL', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-1401', '2026-07-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-15', '2026-07-15'::timestamp, 'NO-RECEIPT-1402', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 760, 190, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 760, 'Migration: ' || 'NO-RECEIPT-1402', '2026-07-15'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1404', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1404', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1405', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'NO-RECEIPT-1405', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 1760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1406', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1760, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1760, 'Migration: ' || 'NO-RECEIPT-1406', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1407', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'NO-RECEIPT-1407', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1408', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1408', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1409', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1409', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-16', '2026-07-16'::timestamp, 'NO-RECEIPT-1410', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1410', '2026-07-16'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1414', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'NO-RECEIPT-1414', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 860) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1415', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 860, 430, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 860, 'Migration: ' || 'NO-RECEIPT-1415', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1416', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1416', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1417', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 760, 380, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 760, 'Migration: ' || 'NO-RECEIPT-1417', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1418', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1418', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1419', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1419', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1420', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'NO-RECEIPT-1420', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1421', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1421', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1422', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-1422', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-17', '2026-07-17'::timestamp, 'NO-RECEIPT-1423', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1423', '2026-07-17'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1441', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.5, 840, 420, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 840, 'Migration: ' || 'NO-RECEIPT-1441', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1442', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1.75, 680, 1190, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.75, 680, 'Migration: ' || 'NO-RECEIPT-1442', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1443', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1443', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1444', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1444', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1445', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1445', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-18', '2026-07-18'::timestamp, 'NO-RECEIPT-1446', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'NO-RECEIPT-1446', '2026-07-18'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1447', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'NO-RECEIPT-1447', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1448', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1448', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1449', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'NO-RECEIPT-1449', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1450', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1450', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1451', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'NO-RECEIPT-1451', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1452', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'NO-RECEIPT-1452', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1457', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-1457', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1458', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'NO-RECEIPT-1458', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1459', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 75, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 75, 'Migration: ' || 'NO-RECEIPT-1459', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-5L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'DCF701-5L', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1460', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 930, 930, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 930, 'Migration: ' || 'NO-RECEIPT-1460', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-20', '2026-07-20'::timestamp, 'NO-RECEIPT-1461', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'NO-RECEIPT-1461', '2026-07-20'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1470', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1470', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1471', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1471', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1472', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1472', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1473', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1473', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1474', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 0.0625, 960, 60, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'NO-RECEIPT-1474', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1475', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'NO-RECEIPT-1475', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-21', '2026-07-21'::timestamp, 'NO-RECEIPT-1476', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1476', '2026-07-21'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1477', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'NO-RECEIPT-1477', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1478', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2000, 500, 'CODE:040 WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'NO-RECEIPT-1478', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1479', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1479', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1480', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.2, 2500, 500, 'CODE:U33', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2500, 'Migration: ' || 'NO-RECEIPT-1480', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1481', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-1481', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1482', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'NO-RECEIPT-1482', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1483', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'NO-RECEIPT-1483', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1484', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1484', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1485', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 580, 2320, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 580, 'Migration: ' || 'NO-RECEIPT-1485', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1486', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1486', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1487', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 630, 630, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 630, 'Migration: ' || 'NO-RECEIPT-1487', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1488', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1488', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1489', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1489', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1490', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1490', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-22', '2026-07-22'::timestamp, 'NO-RECEIPT-1491', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'NO-RECEIPT-1491', '2026-07-22'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1500', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 95, 190, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 95, 'Migration: ' || 'NO-RECEIPT-1500', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTB-47' OR product_name = 'PYLOX MATT BLACK#47') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX MATT BLACK#47', 'PLYZMTB-47', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1501', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 145, 145, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 145, 'Migration: ' || 'NO-RECEIPT-1501', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1502', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1502', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1503', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1503', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1504', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1504', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1505', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1505', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1506', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 3840, 480, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3840, 'Migration: ' || 'NO-RECEIPT-1506', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1507', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 90, 90, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 90, 'Migration: ' || 'NO-RECEIPT-1507', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1508', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1508', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-23', '2026-07-23'::timestamp, 'NO-RECEIPT-1509', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.75, 4800, 3600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 4800, 'Migration: ' || 'NO-RECEIPT-1509', '2026-07-23'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-24', '2026-07-24'::timestamp, 'NO-RECEIPT-1510', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'NO-RECEIPT-1510', '2026-07-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-24', '2026-07-24'::timestamp, 'NO-RECEIPT-1513', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'NO-RECEIPT-1513', '2026-07-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-24', '2026-07-24'::timestamp, 'NO-RECEIPT-1514', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, 'CODE:4R8', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'NO-RECEIPT-1514', '2026-07-24'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-25', '2026-07-25'::timestamp, 'NO-RECEIPT-1533', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, 'CODE:Z7Q', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'NO-RECEIPT-1533', '2026-07-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-25', '2026-07-25'::timestamp, 'NO-RECEIPT-1535', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1535', '2026-07-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-223' OR product_name = 'RAIN OR SHINE NICOLE PINK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE NICOLE PINK 4L', 'ROS-223', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-25', '2026-07-25'::timestamp, 'NO-RECEIPT-1537', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'NO-RECEIPT-1537', '2026-07-25'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1711' OR product_name = 'BOYSEN ACRYTEX CAST 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN ACRYTEX CAST 4L', 'B-1711', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1582', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 640, 640, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 640, 'Migration: ' || 'NO-RECEIPT-1582', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1583', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1583', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 825) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1584', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 825, 825, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 825, 'Migration: ' || 'NO-RECEIPT-1584', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1585', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'NO-RECEIPT-1585', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1586', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'NO-RECEIPT-1586', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1587', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 8, 25, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 8, 25, 'Migration: ' || 'NO-RECEIPT-1587', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1588', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1588', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 83.33333333) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1589', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 83.33333333, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 83.33333333, 'Migration: ' || 'NO-RECEIPT-1589', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1590', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-1590', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1591', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1591', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1592', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1592', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1593', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1593', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1594', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1594', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1595', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'NO-RECEIPT-1595', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-40-1L' OR product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'AC-40-1L', v_branch_id, 0, 180) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-30', '2026-07-30'::timestamp, 'NO-RECEIPT-1596', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 180, 180, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 180, 'Migration: ' || 'NO-RECEIPT-1596', '2026-07-30'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1600', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, 'WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1600', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1601', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1601', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 670) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1602', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 670, 670, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 670, 'Migration: ' || 'NO-RECEIPT-1602', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1603', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'NO-RECEIPT-1603', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'GLAZERB-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1604', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'NO-RECEIPT-1604', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PZPG-1L' OR product_name = 'POLYGLOSS-ZINCROMATE PRIMER GREEN-1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'PZPG-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1605', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 550, 550, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 550, 'Migration: ' || 'NO-RECEIPT-1605', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1606', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-1606', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1607', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 40, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 40, 'Migration: ' || 'NO-RECEIPT-1607', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1608', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-1608', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1609', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-1609', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1610', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'NO-RECEIPT-1610', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1611', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'NO-RECEIPT-1611', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1612', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 700, 2800, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 700, 'Migration: ' || 'NO-RECEIPT-1612', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 670) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1613', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 670, 2680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 670, 'Migration: ' || 'NO-RECEIPT-1613', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1614', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1614', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1615', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'NO-RECEIPT-1615', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 690) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1616', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 690, 1380, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 690, 'Migration: ' || 'NO-RECEIPT-1616', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-31', '2026-07-31'::timestamp, 'NO-RECEIPT-1617', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'NO-RECEIPT-1617', '2026-07-31'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-28', '2026-07-28'::timestamp, 'NO-RECEIPT-1618', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1618', '2026-07-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HDOIT' OR product_name = 'DO IT HARDENER 2K TOP COAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT HARDENER 2K TOP COAT', 'HDOIT', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-28', '2026-07-28'::timestamp, 'NO-RECEIPT-1619', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'NO-RECEIPT-1619', '2026-07-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-28', '2026-07-28'::timestamp, 'NO-RECEIPT-1620', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1620', '2026-07-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-28', '2026-07-28'::timestamp, 'NO-RECEIPT-1621', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'CODE:1G3', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1621', '2026-07-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-07-28', '2026-07-28'::timestamp, 'NO-RECEIPT-1622', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1622', '2026-07-28'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1630', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 550, 550, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 550, 'Migration: ' || 'NO-RECEIPT-1630', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTOPC-1L' OR product_name = 'POLYGLOSS TOP COAT W/H') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS TOP COAT W/H', 'PGTOPC-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1631', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1631', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HDOIT' OR product_name = 'DO IT HARDENER 2K TOP COAT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT HARDENER 2K TOP COAT', 'HDOIT', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1632', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'NO-RECEIPT-1632', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1633', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1633', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-LTR' OR product_name = 'NIPPON CLEAR GLOSS VARNISH LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'NCGVARNISH-LTR', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1634', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1634', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1636', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1636', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1641', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, 'CODE:P17', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'NO-RECEIPT-1641', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1642', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'NO-RECEIPT-1642', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901R-1L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'MEG3901R-1L', v_branch_id, 0, 320) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1643', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 320, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 320, 'Migration: ' || 'NO-RECEIPT-1643', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-01', '2026-08-01'::timestamp, 'NO-RECEIPT-1650', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 675, 2700, 'COLOR :GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 675, 'Migration: ' || 'NO-RECEIPT-1650', '2026-08-01'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1671', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1671', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1672', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 750, 1125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 750, 'Migration: ' || 'NO-RECEIPT-1672', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1673', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1673', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1674', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1674', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1675', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1675', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-04', '2026-08-04'::timestamp, 'NO-RECEIPT-1676', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1676', '2026-08-04'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1677', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 1900, 2850, '202 - BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 1900, 'Migration: ' || 'NO-RECEIPT-1677', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1678', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 750, 4500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 750, 'Migration: ' || 'NO-RECEIPT-1678', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1679', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 20, 35, 700, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 20, 35, 'Migration: ' || 'NO-RECEIPT-1679', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1680', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'NO-RECEIPT-1680', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1681', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-1681', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-05', '2026-08-05'::timestamp, 'NO-RECEIPT-1682', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-1682', '2026-08-05'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 666.6666667) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-06', '2026-08-06'::timestamp, 'NO-RECEIPT-1702', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 666.6666667, 1000, 'BEIGE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 666.6666667, 'Migration: ' || 'NO-RECEIPT-1702', '2026-08-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-06', '2026-08-06'::timestamp, 'NO-RECEIPT-1703', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, 'OFF WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1703', '2026-08-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-06', '2026-08-06'::timestamp, 'NO-RECEIPT-1704', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 800, 800, 'MAROON', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'NO-RECEIPT-1704', '2026-08-06'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1721', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1721', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1722', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'NO-RECEIPT-1722', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1723', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, 'BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'NO-RECEIPT-1723', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1724', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 650, 1950, 'BEIGE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 650, 'Migration: ' || 'NO-RECEIPT-1724', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1725', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'NO-RECEIPT-1725', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1726', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'NO-RECEIPT-1726', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1728', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'NO-RECEIPT-1728', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1041.666667) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1729', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.12, 1041.666667, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.12, 1041.666667, 'Migration: ' || 'NO-RECEIPT-1729', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1730', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1730', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1731', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 1300, 1300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 1300, 'Migration: ' || 'NO-RECEIPT-1731', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1732', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 840, 420, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 840, 'Migration: ' || 'NO-RECEIPT-1732', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1733', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2000, 500, 'GREY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'NO-RECEIPT-1733', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1734', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1734', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1735', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1735', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1736', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'NO-RECEIPT-1736', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-07', '2026-08-07'::timestamp, 'NO-RECEIPT-1737', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'NO-RECEIPT-1737', '2026-08-07'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1742', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'NO-RECEIPT-1742', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1743', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1743', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1744', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1744', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1745', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'NO-RECEIPT-1745', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1746', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'NO-RECEIPT-1746', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1747', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1747', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1748', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1748', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1749', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 4400, 1100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 4400, 'Migration: ' || 'NO-RECEIPT-1749', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1750', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, 'MET. GOLD', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1750', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1751', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, 'MET. BLUE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'NO-RECEIPT-1751', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1752', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 260, 260, 'WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'NO-RECEIPT-1752', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1753', 'CASH SALES - NO RECEIPT', 'GCash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1753', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1754', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 3, 650, 1950, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 3, 650, 'Migration: ' || 'NO-RECEIPT-1754', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 790) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1755', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 790, 790, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 790, 'Migration: ' || 'NO-RECEIPT-1755', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1756', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1756', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1757', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-1757', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1758', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'NO-RECEIPT-1758', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1759', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'NO-RECEIPT-1759', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1760', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-1760', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1761', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'NO-RECEIPT-1761', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-08', '2026-08-08'::timestamp, 'NO-RECEIPT-1762', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 1400, 2800, 'MET. GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 1400, 'Migration: ' || 'NO-RECEIPT-1762', '2026-08-08'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1769', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'NO-RECEIPT-1769', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1770', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1770', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1771', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'ZTT BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1771', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1772', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1772', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1773', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1773', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-10', '2026-08-10'::timestamp, 'NO-RECEIPT-1774', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1774', '2026-08-10'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1790', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 260, 260, 'GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'NO-RECEIPT-1790', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1791', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1791', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1792', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'NO-RECEIPT-1792', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1793', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'NO-RECEIPT-1793', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1794', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, '058 WHITE', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'NO-RECEIPT-1794', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1795', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'NO-RECEIPT-1795', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1796', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'NO-RECEIPT-1796', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1804', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 260, 520, 'YELLOW GREEN', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 260, 'Migration: ' || 'NO-RECEIPT-1804', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1805', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'NO-RECEIPT-1805', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1806', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'NO-RECEIPT-1806', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1807', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'NO-RECEIPT-1807', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-LTR' OR product_name = 'NIPPON CLEAR GLOSS VARNISH LITER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'NCGVARNISH-LTR', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1817', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'NO-RECEIPT-1817', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-11', '2026-08-11'::timestamp, 'NO-RECEIPT-1818', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'NO-RECEIPT-1818', '2026-08-11'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-12', '2026-08-12'::timestamp, 'NO-RECEIPT-1830', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'NO-RECEIPT-1830', '2026-08-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZDR-17' OR product_name = 'PYLOX LAZER DEEP RED 17') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER DEEP RED 17', 'PLYZDR-17', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-12', '2026-08-12'::timestamp, 'NO-RECEIPT-1831', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'NO-RECEIPT-1831', '2026-08-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-12', '2026-08-12'::timestamp, 'NO-RECEIPT-1832', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'NO-RECEIPT-1832', '2026-08-12'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1837', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'NO-RECEIPT-1837', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1838', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, '1G3 SILVER', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1838', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1839', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'BLACK', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1839', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1840', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 5, 85, 425, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 5, 85, 'Migration: ' || 'NO-RECEIPT-1840', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1841', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1841', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-13', '2026-08-13'::timestamp, 'NO-RECEIPT-1842', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, 'MAGENTA', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1842', '2026-08-13'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1869', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, 'METEOR GRAY', 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'NO-RECEIPT-1869', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1870', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'NO-RECEIPT-1870', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1871', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1871', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1872', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'NO-RECEIPT-1872', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1873', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'NO-RECEIPT-1873', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1874', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'NO-RECEIPT-1874', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1875', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 2, 590, 1180, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 2, 590, 'Migration: ' || 'NO-RECEIPT-1875', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1876', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1.5, 700, 1050, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 700, 'Migration: ' || 'NO-RECEIPT-1876', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1877', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'NO-RECEIPT-1877', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1878', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'NO-RECEIPT-1878', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1879', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-1879', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1880', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'NO-RECEIPT-1880', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1881', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'NO-RECEIPT-1881', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1882', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.2, 750, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 750, 'Migration: ' || 'NO-RECEIPT-1882', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1883', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.2, 750, 150, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 750, 'Migration: ' || 'NO-RECEIPT-1883', '2026-08-14'::timestamp);

  -- Lookup item
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by)
  VALUES ('2026-08-14', '2026-08-14'::timestamp, 'NO-RECEIPT-1884', 'CASH SALES - NO RECEIPT', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration');
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'NO-RECEIPT-1884', '2026-08-14'::timestamp);
  END;
END $MIGRATION$;
