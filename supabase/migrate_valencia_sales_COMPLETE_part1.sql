
-- COMPLETE MIGRATION FOR VALENCIA SALES - PART 1
DO $$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  -- 1. DELETE ALL EXISTING MIGRATED SALES TO AVOID DUPLICATES
  DELETE FROM public.sales WHERE branch_id = v_branch_id AND performed_by = 'System Migration';
  DELETE FROM public.stock_transactions WHERE branch_id = v_branch_id AND reason LIKE 'Migration:%' AND type = 'OUT';

  DECLARE
    v_item_id UUID;
  BEGIN

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-1', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'MIG-NO-REC-1', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-2', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3200, 400, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3200, 'Migration: ' || 'MIG-NO-REC-2', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-3', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 700, 2100, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 700, 'Migration: ' || 'MIG-NO-REC-3', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-4', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 720, 1080, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 720, 'Migration: ' || 'MIG-NO-REC-4', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-5', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-5', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-6', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-6', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-7', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-7', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 740) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-8', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 740, 370, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 740, 'Migration: ' || 'MIG-NO-REC-8', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-9', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 4800, 2400, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 4800, 'Migration: ' || 'MIG-NO-REC-9', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B1490-1L' OR product_name = 'BOYSEN LTC LAMP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN LTC LAMP BLACK 1L', 'B1490-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-10', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 240, 960, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 240, 'Migration: ' || 'MIG-NO-REC-10', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'RSW-4L' OR product_name = 'RAIN OR SHINE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE WHITE 4L', 'RSW-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-11', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-11', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-12', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'MIG-NO-REC-12', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-13', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 90, 90, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 90, 'Migration: ' || 'MIG-NO-REC-13', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-14', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-14', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-15', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'MIG-NO-REC-15', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-16', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-16', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-17', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-17', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-18', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-18', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-GAL' OR product_name = 'NIPPON CLEAR GLOSS VARNISH GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON CLEAR GLOSS VARNISH GAL', 'NCGVARNISH-GAL', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-19', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'MIG-NO-REC-19', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-20', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-20', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-21', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-21', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-22', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 580, 2320, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 580, 'Migration: ' || 'MIG-NO-REC-22', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-23', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 800, 1600, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 800, 'Migration: ' || 'MIG-NO-REC-23', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-24', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-24', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-25', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-25', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA100' OR product_name = 'SAND PAPER #100') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #100', 'EA100', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-26', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 40, 120, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 40, 'Migration: ' || 'MIG-NO-REC-26', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-27', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-27', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ea1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'ea1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-28', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-28', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-29', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-29', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-30', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-30', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-31', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 710, 1420, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 710, 'Migration: ' || 'MIG-NO-REC-31', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-32', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-32', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-33', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2400, 480, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2400, 'Migration: ' || 'MIG-NO-REC-33', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-34', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 12, 680, 8160, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 12, 680, 'Migration: ' || 'MIG-NO-REC-34', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-35', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 12, 580, 6960, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 12, 580, 'Migration: ' || 'MIG-NO-REC-35', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-36', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-36', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-37', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-37', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-38', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 615, 1845, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 615, 'Migration: ' || 'MIG-NO-REC-38', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-39', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 800, 4800, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 800, 'Migration: ' || 'MIG-NO-REC-39', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-4' OR product_name = 'DRAGONFLY PAINT BRUSH #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #4', 'DPB-4', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-40', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 120, 360, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 120, 'Migration: ' || 'MIG-NO-REC-40', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-41', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 760, 380, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 760, 'Migration: ' || 'MIG-NO-REC-41', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-42', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-42', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-43', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'MIG-NO-REC-43', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-44', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2600, 520, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2600, 'Migration: ' || 'MIG-NO-REC-44', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-45', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.3, 2600, 780, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.3, 2600, 'Migration: ' || 'MIG-NO-REC-45', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-46', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.3, 1900, 570, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.3, 1900, 'Migration: ' || 'MIG-NO-REC-46', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-47', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 2880, 180, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 2880, 'Migration: ' || 'MIG-NO-REC-47', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-48', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-48', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-49', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 95, 95, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 95, 'Migration: ' || 'MIG-NO-REC-49', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-50', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2880, 360, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2880, 'Migration: ' || 'MIG-NO-REC-50', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-51', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-51', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-52', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 920, 230, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'MIG-NO-REC-52', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-53', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'MIG-NO-REC-53', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-54', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-54', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-55', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'MIG-NO-REC-55', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-56', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 4000, 500, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4000, 'Migration: ' || 'MIG-NO-REC-56', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-57', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-57', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 340) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-58', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 340, 85, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 340, 'Migration: ' || 'MIG-NO-REC-58', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 340) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-59', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 340, 85, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 340, 'Migration: ' || 'MIG-NO-REC-59', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-60', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-60', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-61', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-61', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-62', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-62', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-63', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1500, 3000, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1500, 'Migration: ' || 'MIG-NO-REC-63', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-64', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-64', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-65', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1550, 3100, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1550, 'Migration: ' || 'MIG-NO-REC-65', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-66', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-66', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA100' OR product_name = 'SAND PAPER #100') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #100', 'EA100', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-67', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'MIG-NO-REC-67', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-68', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-68', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-69', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-69', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-70', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-70', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-71', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 145, 145, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 145, 'Migration: ' || 'MIG-NO-REC-71', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-72', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'MIG-NO-REC-72', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-73', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-73', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-74', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-74', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-75', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-75', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-76', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-76', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-77', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-77', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-78', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.4, 2900, 1160, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.4, 2900, 'Migration: ' || 'MIG-NO-REC-78', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-79', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1920, 240, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1920, 'Migration: ' || 'MIG-NO-REC-79', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-80', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1680, 210, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1680, 'Migration: ' || 'MIG-NO-REC-80', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-81', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 48, 25, 1200, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 48, 25, 'Migration: ' || 'MIG-NO-REC-81', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-82', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-82', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-83', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'MIG-NO-REC-83', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-84', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-84', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-85', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-85', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-86', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2700, 2700, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2700, 'Migration: ' || 'MIG-NO-REC-86', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-87', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-87', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-88', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-88', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-89', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 100, 300, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 100, 'Migration: ' || 'MIG-NO-REC-89', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-90', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 8, 35, 280, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 8, 35, 'Migration: ' || 'MIG-NO-REC-90', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-91', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-91', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FRANELLA' OR product_name = 'FRANELLA CLOTH 1YARD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('FRANELLA CLOTH 1YARD', 'FRANELLA', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-92', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 100, 500, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 100, 'Migration: ' || 'MIG-NO-REC-92', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-93', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-93', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-94', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 15, 25, 375, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 15, 25, 'Migration: ' || 'MIG-NO-REC-94', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-95', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-95', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-96', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-96', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-97', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-97', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-98', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-98', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-99', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-99', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 3520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-100', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 3520, 1760, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 3520, 'Migration: ' || 'MIG-NO-REC-100', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-101', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-101', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-102', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-102', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYLICMIX-1L' OR product_name = 'ACRYLIC NP, TIMEOUT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ACRYLIC NP, TIMEOUT 1L', 'ACRYLICMIX-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-103', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 550, 825, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 550, 'Migration: ' || 'MIG-NO-REC-103', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-104', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1280, 160, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1280, 'Migration: ' || 'MIG-NO-REC-104', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-105', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-105', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-106', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 100, 300, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 100, 'Migration: ' || 'MIG-NO-REC-106', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-107', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-107', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-108', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-108', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-109', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-109', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-110', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-110', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-111', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-111', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-112', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 35, 210, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 35, 'Migration: ' || 'MIG-NO-REC-112', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 690) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-113', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 690, 690, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 690, 'Migration: ' || 'MIG-NO-REC-113', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-114', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'MIG-NO-REC-114', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-115', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-115', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-116', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-116', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-117', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-117', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-118', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-118', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-4L' OR product_name = 'QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L', 'QDEMIX-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-119', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-119', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-120', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 550, 550, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 550, 'Migration: ' || 'MIG-NO-REC-120', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-121', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1700, 850, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1700, 'Migration: ' || 'MIG-NO-REC-121', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-122', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 40, 120, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 40, 'Migration: ' || 'MIG-NO-REC-122', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-123', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-123', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-124', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-124', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-125', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-125', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-126', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-126', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-127', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-127', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-128', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-128', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-129', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2300, 2300, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2300, 'Migration: ' || 'MIG-NO-REC-129', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-130', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-130', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-131', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-131', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-132', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 220, 440, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 220, 'Migration: ' || 'MIG-NO-REC-132', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-133', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-133', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-134', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-134', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-135', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-135', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-136', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-136', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-137', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 650, 3250, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 650, 'Migration: ' || 'MIG-NO-REC-137', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-138', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'MIG-NO-REC-138', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-139', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 620, 620, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 620, 'Migration: ' || 'MIG-NO-REC-139', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-140', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-140', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-141', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-141', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-739' OR product_name = 'COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L', 'ROS-739', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-142', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'MIG-NO-REC-142', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-7000' OR product_name = 'RAIN OR SHINE PREPA WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'ROS-7000', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-143', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'MIG-NO-REC-143', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-144', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-144', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-145', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-145', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-02'::date, 'MIG-NO-REC-146', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 145, 290, NULL, 'System Migration', '2026-04-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 145, 'Migration: ' || 'MIG-NO-REC-146', '2026-04-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-147', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-147', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-148', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-148', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 5120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-149', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 5120, 160, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 5120, 'Migration: ' || 'MIG-NO-REC-149', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-150', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-150', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-151', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-151', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-152', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-152', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1027) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-153', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1027, 1027, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1027, 'Migration: ' || 'MIG-NO-REC-153', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-154', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-154', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-155', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'MIG-NO-REC-155', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-156', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-156', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-157', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-157', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-158', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'MIG-NO-REC-158', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-159', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-159', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-160', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-160', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-07'::date, 'MIG-NO-REC-161', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-04-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-161', '2026-04-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-162', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-162', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-163', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-163', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-164', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-164', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-165', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-165', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-166', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-166', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-167', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-167', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-168', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 920, 230, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'MIG-NO-REC-168', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-169', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-169', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-170', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-170', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-171', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-171', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-172', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'MIG-NO-REC-172', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-173', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1840, 230, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1840, 'Migration: ' || 'MIG-NO-REC-173', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-174', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-174', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-175', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 700, 2100, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 700, 'Migration: ' || 'MIG-NO-REC-175', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-176', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'MIG-NO-REC-176', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-177', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-177', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-178', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-178', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-179', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 760, 95, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 760, 'Migration: ' || 'MIG-NO-REC-179', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-180', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-180', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-181', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-181', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-182', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-182', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-183', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-183', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-184', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-184', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-185', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-185', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-186', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-186', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-187', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-187', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-188', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-188', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-189', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-189', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-190', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'MIG-NO-REC-190', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-191', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-191', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-192', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 280, 35, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 280, 'Migration: ' || 'MIG-NO-REC-192', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-193', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 280, 35, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 280, 'Migration: ' || 'MIG-NO-REC-193', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-194', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'MIG-NO-REC-194', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-195', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-195', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-196', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-196', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-197', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3040, 190, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3040, 'Migration: ' || 'MIG-NO-REC-197', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-198', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 2880, 90, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 2880, 'Migration: ' || 'MIG-NO-REC-198', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-199', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 2880, 90, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 2880, 'Migration: ' || 'MIG-NO-REC-199', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-200', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 900, 225, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 900, 'Migration: ' || 'MIG-NO-REC-200', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1440) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-201', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1440, 180, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1440, 'Migration: ' || 'MIG-NO-REC-201', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-202', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-202', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-203', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-203', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-204', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-204', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-205', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'MIG-NO-REC-205', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-206', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-206', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-207', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-207', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-208', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-208', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-10'::date, 'MIG-NO-REC-209', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-04-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-209', '2026-04-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-210', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'MIG-NO-REC-210', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-211', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.375, 3200, 1200, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 3200, 'Migration: ' || 'MIG-NO-REC-211', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-212', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-212', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-213', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-213', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-214', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-214', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-215', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.75, 2600, 1950, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2600, 'Migration: ' || 'MIG-NO-REC-215', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-216', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 800, 1600, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 800, 'Migration: ' || 'MIG-NO-REC-216', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-217', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-217', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-218', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-218', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-219', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.1, 2400, 240, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.1, 2400, 'Migration: ' || 'MIG-NO-REC-219', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-220', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-220', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-221', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-221', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-222', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-222', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-223', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-223', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-224', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-224', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-225', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-225', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-226', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 640, 80, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 640, 'Migration: ' || 'MIG-NO-REC-226', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-14'::date, 'MIG-NO-REC-227', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration', '2026-04-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'MIG-NO-REC-227', '2026-04-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-228', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-228', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-229', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-229', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 190) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-230', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 190, 190, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 190, 'Migration: ' || 'MIG-NO-REC-230', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-231', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2880, 720, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2880, 'Migration: ' || 'MIG-NO-REC-231', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1360) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-232', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1360, 340, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1360, 'Migration: ' || 'MIG-NO-REC-232', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-233', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-233', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-234', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-234', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-235', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-235', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-236', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-236', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-237', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-237', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-238', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'MIG-NO-REC-238', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-239', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.1875, 2880, 540, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 2880, 'Migration: ' || 'MIG-NO-REC-239', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-240', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-240', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-241', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-241', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-242', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-242', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-243', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-243', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-244', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1100, 550, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1100, 'Migration: ' || 'MIG-NO-REC-244', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-245', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-245', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-246', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'MIG-NO-REC-246', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-247', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-247', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-248', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-248', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-249', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-249', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-250', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-250', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-251', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2400, 1200, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2400, 'Migration: ' || 'MIG-NO-REC-251', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-252', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 650, 1300, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 650, 'Migration: ' || 'MIG-NO-REC-252', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-253', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-253', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGW-4L' OR product_name = 'POLYGLOSS PU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU WHITE 4L', 'PGW-4L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-254', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 2880, 180, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 2880, 'Migration: ' || 'MIG-NO-REC-254', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-255', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-255', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-256', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-256', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-257', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-257', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-258', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 760, 380, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 760, 'Migration: ' || 'MIG-NO-REC-258', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-259', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-259', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-260', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 780, 390, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 780, 'Migration: ' || 'MIG-NO-REC-260', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-261', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-261', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-262', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-262', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-263', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-263', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-264', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-264', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-265', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'MIG-NO-REC-265', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-266', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-266', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-267', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 50, 150, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 50, 'Migration: ' || 'MIG-NO-REC-267', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-268', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 65, 195, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 65, 'Migration: ' || 'MIG-NO-REC-268', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-22'::date, 'MIG-NO-REC-269', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-04-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-269', '2026-04-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-270', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 4800, 300, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 4800, 'Migration: ' || 'MIG-NO-REC-270', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-271', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-271', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-272', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-272', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-273', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-273', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-274', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-274', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-275', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-275', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-276', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-276', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-277', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1200, 2400, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1200, 'Migration: ' || 'MIG-NO-REC-277', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-278', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-278', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-279', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 600, 900, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 600, 'Migration: ' || 'MIG-NO-REC-279', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-280', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-280', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-281', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-281', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-282', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-282', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-24'::date, 'MIG-NO-REC-283', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 880, 440, NULL, 'System Migration', '2026-04-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 880, 'Migration: ' || 'MIG-NO-REC-283', '2026-04-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-284', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-284', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-285', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'MIG-NO-REC-285', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-286', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-286', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-25'::date, 'MIG-NO-REC-287', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 4000, 500, NULL, 'System Migration', '2026-04-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4000, 'Migration: ' || 'MIG-NO-REC-287', '2026-04-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-288', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-288', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-289', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-289', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-290', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 35, 210, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 35, 'Migration: ' || 'MIG-NO-REC-290', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-291', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 95, 95, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 95, 'Migration: ' || 'MIG-NO-REC-291', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-292', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'MIG-NO-REC-292', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-293', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-293', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-294', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1560, 390, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1560, 'Migration: ' || 'MIG-NO-REC-294', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-295', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-295', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-296', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-296', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-297', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-297', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-298', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 960, 60, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'MIG-NO-REC-298', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1080) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-299', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1080, 270, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1080, 'Migration: ' || 'MIG-NO-REC-299', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-300', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-300', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-301', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-301', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-302', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-302', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-303', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-303', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-304', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-304', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-305', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-305', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-306', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 920, 230, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'MIG-NO-REC-306', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-307', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 1500, 4500, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 1500, 'Migration: ' || 'MIG-NO-REC-307', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-308', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 250, 750, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 250, 'Migration: ' || 'MIG-NO-REC-308', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-309', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 95, 95, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 95, 'Migration: ' || 'MIG-NO-REC-309', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-310', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'MIG-NO-REC-310', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-311', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-311', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-312', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-312', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-313', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 850, 1700, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 850, 'Migration: ' || 'MIG-NO-REC-313', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-314', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1100, 2200, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1100, 'Migration: ' || 'MIG-NO-REC-314', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-315', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 560, 560, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 560, 'Migration: ' || 'MIG-NO-REC-315', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-316', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-316', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-317', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-317', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-318', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-318', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-319', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 210, 420, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 210, 'Migration: ' || 'MIG-NO-REC-319', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-LTR' OR product_name = 'NIPPON METAL PRIMER RED OXIDE LITER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'NMPREDOX-LTR', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-320', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-320', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-321', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 4000, 1000, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 4000, 'Migration: ' || 'MIG-NO-REC-321', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-322', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-322', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-01'::date, 'MIG-NO-REC-323', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration', '2026-04-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'MIG-NO-REC-323', '2026-04-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 730) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-324', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 730, 365, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 730, 'Migration: ' || 'MIG-NO-REC-324', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-325', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 760, 190, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 760, 'Migration: ' || 'MIG-NO-REC-325', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-326', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-326', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-327', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-327', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-328', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-328', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-06'::date, 'MIG-NO-REC-329', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-329', '2026-04-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-09'::date, 'MIG-NO-REC-330', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2500, 2500, NULL, 'System Migration', '2026-04-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2500, 'Migration: ' || 'MIG-NO-REC-330', '2026-04-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-331', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2400, 1200, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2400, 'Migration: ' || 'MIG-NO-REC-331', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-332', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-332', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-11'::date, 'MIG-NO-REC-333', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-04-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-333', '2026-04-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-334', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-334', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-335', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 760, 190, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 760, 'Migration: ' || 'MIG-NO-REC-335', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-336', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-336', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-337', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-337', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-338', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-338', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-339', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 210, 420, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 210, 'Migration: ' || 'MIG-NO-REC-339', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-340', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-340', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-341', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-341', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-342', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 6, 35, 210, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 35, 'Migration: ' || 'MIG-NO-REC-342', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-343', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-343', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-344', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-344', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-345', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-345', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-346', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-346', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-20'::date, 'MIG-NO-REC-347', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 1750, 350, NULL, 'System Migration', '2026-04-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 1750, 'Migration: ' || 'MIG-NO-REC-347', '2026-04-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-348', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-348', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-21'::date, 'MIG-NO-REC-349', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.75, 2000, 1500, NULL, 'System Migration', '2026-04-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2000, 'Migration: ' || 'MIG-NO-REC-349', '2026-04-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-350', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-350', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-23'::date, 'MIG-NO-REC-351', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2900, 2900, NULL, 'System Migration', '2026-04-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2900, 'Migration: ' || 'MIG-NO-REC-351', '2026-04-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-352', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2500, 500, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2500, 'Migration: ' || 'MIG-NO-REC-352', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-353', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-353', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-354', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 850, 850, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 850, 'Migration: ' || 'MIG-NO-REC-354', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-355', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-355', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-356', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-356', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-357', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-357', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-358', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2500, 500, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2500, 'Migration: ' || 'MIG-NO-REC-358', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-359', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-359', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-360', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-360', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-361', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-361', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-27'::date, 'MIG-NO-REC-362', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-362', '2026-04-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WEBER' OR product_name = 'SPRAY GUN F-75G WEBER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SPRAY GUN F-75G WEBER', 'WEBER', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-30'::date, 'MIG-NO-REC-363', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-04-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-363', '2026-04-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-364', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'MIG-NO-REC-364', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-365', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-365', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-366', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-366', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-367', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-367', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-368', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1900, 950, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1900, 'Migration: ' || 'MIG-NO-REC-368', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-369', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-369', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-08'::date, 'MIG-NO-REC-370', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-370', '2026-04-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-371', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-371', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-372', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-372', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-373', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-373', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-374', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-374', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-375', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-375', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-376', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-376', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-377', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-377', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-378', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-378', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-379', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 120, 600, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 120, 'Migration: ' || 'MIG-NO-REC-379', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-13'::date, 'MIG-NO-REC-380', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-04-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-380', '2026-04-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITH-4L' OR product_name = 'DO IT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE THINNER 4L', 'DOITH-4L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-381', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 720, 720, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 720, 'Migration: ' || 'MIG-NO-REC-381', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-382', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-382', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-15'::date, 'MIG-NO-REC-383', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-04-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-383', '2026-04-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1360) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-384', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1360, 680, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1360, 'Migration: ' || 'MIG-NO-REC-384', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-16'::date, 'MIG-NO-REC-385', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 40, 400, NULL, 'System Migration', '2026-04-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 40, 'Migration: ' || 'MIG-NO-REC-385', '2026-04-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-386', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-386', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ea120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'ea120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-387', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-387', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-388', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-388', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-17'::date, 'MIG-NO-REC-389', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-04-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-389', '2026-04-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-390', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-390', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-391', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-391', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-392', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-392', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-18'::date, 'MIG-NO-REC-393', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-04-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-393', '2026-04-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-28'::date, 'MIG-NO-REC-394', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 2500, 5000, NULL, 'System Migration', '2026-04-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 2500, 'Migration: ' || 'MIG-NO-REC-394', '2026-04-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-04-29'::date, 'MIG-NO-REC-395', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-04-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-395', '2026-04-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-396', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-396', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-397', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-397', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 4000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-398', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 4000, 500, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4000, 'Migration: ' || 'MIG-NO-REC-398', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-399', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-399', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-400', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 100, 400, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 100, 'Migration: ' || 'MIG-NO-REC-400', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-401', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 100, 400, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 100, 'Migration: ' || 'MIG-NO-REC-401', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-402', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-402', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-403', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-403', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-404', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-404', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-405', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 210, 210, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 210, 'Migration: ' || 'MIG-NO-REC-405', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-406', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'MIG-NO-REC-406', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-407', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-407', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-408', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-408', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-409', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-409', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-410', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-410', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-411', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-411', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-412', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.3, 2600, 780, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.3, 2600, 'Migration: ' || 'MIG-NO-REC-412', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-413', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-413', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-414', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-414', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLY- BT-ALUM-4L' OR product_name = 'POLYGLOSS-BRIGHT ALUMINUM 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'POLY- BT-ALUM-4L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-415', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3040, 380, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3040, 'Migration: ' || 'MIG-NO-REC-415', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-416', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-416', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-417', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 580, 290, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 580, 'Migration: ' || 'MIG-NO-REC-417', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-418', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-418', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-419', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-419', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-420', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-420', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-421', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-421', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-422', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-422', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-423', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-423', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-424', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-424', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-425', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-425', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-426', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-426', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-427', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'MIG-NO-REC-427', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 690) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-428', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 690, 690, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 690, 'Migration: ' || 'MIG-NO-REC-428', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-09'::date, 'MIG-NO-REC-429', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-05-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-429', '2026-05-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERW-1L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L', 'GLAZERW-1L', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-430', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'MIG-NO-REC-430', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-431', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-431', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-432', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-432', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-433', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-433', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 3700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-434', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 3700, 3700, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 3700, 'Migration: ' || 'MIG-NO-REC-434', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-435', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 590, 1180, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 590, 'Migration: ' || 'MIG-NO-REC-435', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-436', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1300, 1300, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1300, 'Migration: ' || 'MIG-NO-REC-436', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-437', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2100, 2100, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2100, 'Migration: ' || 'MIG-NO-REC-437', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-438', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-438', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-439', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-439', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-440', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-440', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-441', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-441', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-442', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-442', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-443', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 30, 25, 750, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 30, 25, 'Migration: ' || 'MIG-NO-REC-443', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-444', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-444', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-445', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-445', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-446', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'MIG-NO-REC-446', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-447', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-447', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-448', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-448', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 30) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-449', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 30, 90, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 30, 'Migration: ' || 'MIG-NO-REC-449', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-450', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-450', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 360) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-451', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 360, 180, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 360, 'Migration: ' || 'MIG-NO-REC-451', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRY- REDUCER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE REDUCER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ALPHA CHROMA ACRYTILE REDUCER', 'ACRY- REDUCER-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-452', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-452', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ALPHAGLOSS-4L' OR product_name = 'ALPHA CHROMA ACRYTILE GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'ALPHAGLOSS-4L', v_branch_id, 0, 1245) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-453', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1245, 1245, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1245, 'Migration: ' || 'MIG-NO-REC-453', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1705' OR product_name = 'ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'B-1705', v_branch_id, 0, 1170) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-454', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1170, 2340, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1170, 'Migration: ' || 'MIG-NO-REC-454', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-455', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-455', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-456', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-456', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-457', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-457', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-458', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'MIG-NO-REC-458', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-459', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 280, 560, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 280, 'Migration: ' || 'MIG-NO-REC-459', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-460', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-460', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-461', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 920, 4600, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 920, 'Migration: ' || 'MIG-NO-REC-461', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- UH SO RED -4L' OR product_name = 'RAIN OR SHINE- UH SO RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE- UH SO RED 4L', 'ROS- UH SO RED -4L', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-462', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1050, 2100, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1050, 'Migration: ' || 'MIG-NO-REC-462', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- HAPPY DAYS-4L' OR product_name = 'RAIN OR SHINE- HAPPY DAYS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'ROS- HAPPY DAYS-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-463', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 920, 4600, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 920, 'Migration: ' || 'MIG-NO-REC-463', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-464', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'MIG-NO-REC-464', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-465', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-465', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-466', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-466', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-467', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-467', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-468', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-468', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-469', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-469', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-470', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-470', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-471', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 680, 2720, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 680, 'Migration: ' || 'MIG-NO-REC-471', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-472', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 1100, 4400, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 1100, 'Migration: ' || 'MIG-NO-REC-472', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-473', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-473', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 210) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-474', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 210, 210, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 210, 'Migration: ' || 'MIG-NO-REC-474', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-475', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 75, 150, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 75, 'Migration: ' || 'MIG-NO-REC-475', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-476', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-476', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-477', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-477', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDW-4L' OR product_name = 'PLATONE QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE WHITE 4L', 'PLQDW-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-478', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-478', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-479', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-479', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-480', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-480', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-481', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-481', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-482', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-482', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-483', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-483', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2160) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-484', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2160, 540, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2160, 'Migration: ' || 'MIG-NO-REC-484', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-485', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-485', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4113-4L' OR product_name = 'NIPPON EXTREME QDU RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU RED 4L', 'NXU4113-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-486', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-486', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-487', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-487', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4113-4L' OR product_name = 'NIPPON EXTREME QDU RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU RED 4L', 'NXU4113-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-488', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-488', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-489', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-489', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-490', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 40, 120, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 40, 'Migration: ' || 'MIG-NO-REC-490', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-491', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-491', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 730) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-492', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 730, 730, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 730, 'Migration: ' || 'MIG-NO-REC-492', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 5760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-493', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 5760, 180, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 5760, 'Migration: ' || 'MIG-NO-REC-493', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-494', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 880, 1760, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 880, 'Migration: ' || 'MIG-NO-REC-494', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-495', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 75, 150, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 75, 'Migration: ' || 'MIG-NO-REC-495', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-496', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 840, 210, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 840, 'Migration: ' || 'MIG-NO-REC-496', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGLD-705' OR product_name = 'PYLOX LAZER GOLD 705') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GOLD 705', 'PLYZGLD-705', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-497', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 185, 1110, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 185, 'Migration: ' || 'MIG-NO-REC-497', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-498', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'MIG-NO-REC-498', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-499', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-499', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-500', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-500', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-501', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-501', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-502', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-502', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-503', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-503', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-504', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'MIG-NO-REC-504', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-505', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-505', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-506', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1500, 1500, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1500, 'Migration: ' || 'MIG-NO-REC-506', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-507', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'MIG-NO-REC-507', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-508', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-508', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-509', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-509', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-510', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1500, 1500, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1500, 'Migration: ' || 'MIG-NO-REC-510', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-511', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-511', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-512', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-512', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-513', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-513', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-514', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-514', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-515', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 850, 850, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 850, 'Migration: ' || 'MIG-NO-REC-515', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-516', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-516', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-517', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-517', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-518', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-518', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-519', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-519', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-520', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-520', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-521', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-521', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-522', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-522', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-523', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-523', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-30'::date, 'MIG-NO-REC-524', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 100, 300, NULL, 'System Migration', '2026-05-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 100, 'Migration: ' || 'MIG-NO-REC-524', '2026-05-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-633' OR product_name = 'RAIN OR SHINE CHOCOLATE BROWN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE CHOCOLATE BROWN 4L', 'ROS-633', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-30'::date, 'MIG-NO-REC-525', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-05-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-525', '2026-05-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-701' OR product_name = 'RAIN OR SHINE BAGUIO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'ROS-701', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-30'::date, 'MIG-NO-REC-526', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 920, 1840, NULL, 'System Migration', '2026-05-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 920, 'Migration: ' || 'MIG-NO-REC-526', '2026-05-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 275) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-527', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 275, 1100, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 275, 'Migration: ' || 'MIG-NO-REC-527', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-528', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'MIG-NO-REC-528', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-529', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 80, 160, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 80, 'Migration: ' || 'MIG-NO-REC-529', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-530', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-530', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-531', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-531', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-532', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-532', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-533', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1800, 450, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1800, 'Migration: ' || 'MIG-NO-REC-533', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-534', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-534', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 3800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-535', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3800, 475, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3800, 'Migration: ' || 'MIG-NO-REC-535', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-536', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-536', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-537', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-537', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS- HAPPY DAYS-4L' OR product_name = 'RAIN OR SHINE- HAPPY DAYS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'ROS- HAPPY DAYS-4L', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-538', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 930, 1860, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 930, 'Migration: ' || 'MIG-NO-REC-538', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-862' OR product_name = 'RAIN OR SHINE IVORY 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE IVORY 4L', 'ROS-862', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-539', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 930, 930, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 930, 'Migration: ' || 'MIG-NO-REC-539', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-540', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 85, 255, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 85, 'Migration: ' || 'MIG-NO-REC-540', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 740) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-541', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 740, 740, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 740, 'Migration: ' || 'MIG-NO-REC-541', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-542', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-542', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-543', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-543', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-544', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 650, 1300, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 650, 'Migration: ' || 'MIG-NO-REC-544', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MTX' OR product_name = 'SUPRA GLOSS (TURTLE WAX)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SUPRA GLOSS (TURTLE WAX)', 'MTX', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-545', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'MIG-NO-REC-545', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-546', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1120, 280, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1120, 'Migration: ' || 'MIG-NO-REC-546', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SEALERMAX5170-4L' OR product_name = 'NIPPON SEALERMAX 5170 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON SEALERMAX 5170 4L', 'SEALERMAX5170-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-547', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1200, 150, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1200, 'Migration: ' || 'MIG-NO-REC-547', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 60) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-548', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 60, 60, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 60, 'Migration: ' || 'MIG-NO-REC-548', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-549', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-549', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-550', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-550', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-551', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 65, 130, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 65, 'Migration: ' || 'MIG-NO-REC-551', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-552', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-552', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-553', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-553', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-554', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-554', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-555', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-555', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-01'::date, 'MIG-NO-REC-556', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration', '2026-05-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'MIG-NO-REC-556', '2026-05-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-557', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-557', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-558', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-558', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-559', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-559', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-560', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-560', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-561', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-561', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-562', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-562', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-563', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-563', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-564', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-564', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-565', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-565', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-566', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-566', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-03'::date, 'MIG-NO-REC-567', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-567', '2026-05-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-03'::date, 'MIG-NO-REC-568', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-568', '2026-05-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-03'::date, 'MIG-NO-REC-569', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2000, 250, NULL, 'System Migration', '2026-05-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2000, 'Migration: ' || 'MIG-NO-REC-569', '2026-05-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-03'::date, 'MIG-NO-REC-570', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-05-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-570', '2026-05-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-571', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-571', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-572', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'MIG-NO-REC-572', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-573', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-573', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-574', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-574', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-575', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-575', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-576', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-576', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-577', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-577', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-578', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-578', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-579', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-579', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-580', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'MIG-NO-REC-580', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-581', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-581', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-582', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 185, 185, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 185, 'Migration: ' || 'MIG-NO-REC-582', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-583', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-583', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-584', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-584', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-585', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-585', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-586', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-586', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-587', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'MIG-NO-REC-587', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-588', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-588', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-589', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'MIG-NO-REC-589', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-590', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'MIG-NO-REC-590', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-591', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-591', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-592', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'MIG-NO-REC-592', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-593', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-593', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-594', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-594', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-595', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-595', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-596', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-596', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-597', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-597', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-598', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-598', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-599', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-599', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-600', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-600', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-601', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-601', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-602', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-602', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-603', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-603', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-604', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-604', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-605', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1280, 160, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1280, 'Migration: ' || 'MIG-NO-REC-605', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-606', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-606', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-607', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-607', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-608', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-608', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-609', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-609', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-610', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'MIG-NO-REC-610', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-611', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-611', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-612', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-612', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-613', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 2700, 4050, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 2700, 'Migration: ' || 'MIG-NO-REC-613', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-614', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-614', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-615', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-615', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 275) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-616', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 275, 275, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 275, 'Migration: ' || 'MIG-NO-REC-616', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-617', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-617', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-618', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-618', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-619', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 100, 300, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 100, 'Migration: ' || 'MIG-NO-REC-619', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-620', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-620', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3413.33) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-621', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.375, 3413.33, 1279.99875, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 3413.33, 'Migration: ' || 'MIG-NO-REC-621', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTB-4L' OR product_name = 'POLYGLOSS PU PHTHALO BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU PHTHALO BLUE 4L', 'PGTB-4L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-622', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2720, 680, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'MIG-NO-REC-622', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SAFARE-4L' OR product_name = 'ROS-SAFARI BROWN_4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROS-SAFARI BROWN_4L', 'ROS-SAFARE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-623', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-623', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BBR-MINI' OR product_name = 'DRAGONFLY MINI BABY ROLLER #4 W/H') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'BBR-MINI', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-624', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-624', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-625', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-625', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-36' OR product_name = 'CUMI SUPREME FLOOR SANDING 36') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 36', 'CUMIFS-36', v_branch_id, 0, 120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-626', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 120, 120, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 120, 'Migration: ' || 'MIG-NO-REC-626', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-627', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-627', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-628', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2400, 300, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'MIG-NO-REC-628', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-629', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-629', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1' OR product_name = 'UNKNOWN 2B-PB-1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNKNOWN 2B-PB-1', '2B-PB-1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-630', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-630', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('0206-09-05'::date, 'MIG-NO-REC-631', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 300, 150, NULL, 'System Migration', '0206-09-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 300, 'Migration: ' || 'MIG-NO-REC-631', '0206-09-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-632', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-632', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-633', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-633', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-634', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-634', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-367' OR product_name = 'CANDY TUFF ROS-367 RAIN OR SHINE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'ROS-367', v_branch_id, 0, 870) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-635', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 870, 2610, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 870, 'Migration: ' || 'MIG-NO-REC-635', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-636', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-636', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPR7' OR product_name = 'NIPPON ROLLER PAINT #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ROLLER PAINT #7', 'NPR7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-637', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'MIG-NO-REC-637', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-638', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-638', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-639', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-639', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-640', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 615, 2460, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 615, 'Migration: ' || 'MIG-NO-REC-640', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-641', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-641', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-642', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-642', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-643', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 16, 35, 560, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 16, 35, 'Migration: ' || 'MIG-NO-REC-643', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-644', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-644', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BPAD' OR product_name = 'BUFFING PAD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BUFFING PAD', 'BPAD', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-645', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1050, 1050, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1050, 'Migration: ' || 'MIG-NO-REC-645', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-646', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-646', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-647', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-647', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-648', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-648', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-649', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-649', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-650', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-650', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-651', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-651', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-652', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-652', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-653', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-653', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-13'::date, 'MIG-NO-REC-654', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-05-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-654', '2026-05-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-655', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-655', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-656', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-656', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-657', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 2800, 5600, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 2800, 'Migration: ' || 'MIG-NO-REC-657', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-658', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-658', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-659', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-659', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 6080) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-660', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 6080, 190, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 6080, 'Migration: ' || 'MIG-NO-REC-660', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-661', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1200, 150, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1200, 'Migration: ' || 'MIG-NO-REC-661', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1710' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'B-1710', v_branch_id, 0, 1245) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-662', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1245, 1245, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1245, 'Migration: ' || 'MIG-NO-REC-662', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-663', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-663', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-664', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-664', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-665', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3040, 380, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3040, 'Migration: ' || 'MIG-NO-REC-665', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-666', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-666', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-667', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-667', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-668', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 95, 285, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 95, 'Migration: ' || 'MIG-NO-REC-668', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-669', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 95, 285, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 95, 'Migration: ' || 'MIG-NO-REC-669', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-670', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-670', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-671', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 300, 1200, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 300, 'Migration: ' || 'MIG-NO-REC-671', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-672', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-672', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PTRL-7' OR product_name = 'DRAGONFLY PAINT ROLLER #7 W/H') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'PTRL-7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-673', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-673', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-674', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-674', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-16'::date, 'MIG-NO-REC-675', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-05-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-675', '2026-05-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BRIDE-4L' OR product_name = 'ROS-BRIDAL GOWN-4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROS-BRIDAL GOWN-4L', 'ROS-BRIDE-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-676', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'MIG-NO-REC-676', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-677', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-677', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-678', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 50, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 50, 'Migration: ' || 'MIG-NO-REC-678', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-679', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-679', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-680', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-680', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-681', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-681', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-682', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-682', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-683', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 260, 260, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'MIG-NO-REC-683', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-684', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-684', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-685', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-685', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-686', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-686', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-687', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-687', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-688', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 100, 500, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 100, 'Migration: ' || 'MIG-NO-REC-688', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-18'::date, 'MIG-NO-REC-689', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-689', '2026-05-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-690', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'MIG-NO-REC-690', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-691', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'MIG-NO-REC-691', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-692', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-692', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-693', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-693', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-694', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-694', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-695', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-695', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-696', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-696', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-697', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-697', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-19'::date, 'MIG-NO-REC-698', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 960, 120, NULL, 'System Migration', '2026-05-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 960, 'Migration: ' || 'MIG-NO-REC-698', '2026-05-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 5600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-699', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 5600, 2800, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 5600, 'Migration: ' || 'MIG-NO-REC-699', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-700', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'MIG-NO-REC-700', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-701', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-701', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMF-4L' OR product_name = 'POLYGLOSS PU MICA RED FINE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'PGMF-4L', v_branch_id, 0, 2200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-702', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2200, 1100, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2200, 'Migration: ' || 'MIG-NO-REC-702', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-703', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'MIG-NO-REC-703', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-704', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 95, 950, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 95, 'Migration: ' || 'MIG-NO-REC-704', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-705', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'MIG-NO-REC-705', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-706', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-706', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-707', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-707', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-708', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 1000, 4000, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 1000, 'Migration: ' || 'MIG-NO-REC-708', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-709', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-709', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-710', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-710', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-21'::date, 'MIG-NO-REC-711', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-711', '2026-05-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-712', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-712', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-713', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-713', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-714', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-714', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-715', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-715', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-716', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-716', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-717', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 400, 50, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 400, 'Migration: ' || 'MIG-NO-REC-717', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BBR-MINI' OR product_name = 'DRAGONFLY MINI BABY ROLLER #4 W/H') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'BBR-MINI', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-718', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-718', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-719', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'MIG-NO-REC-719', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-720', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'MIG-NO-REC-720', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-721', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-721', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-722', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-722', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-723', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-723', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-724', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-724', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-725', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-725', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-726', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'MIG-NO-REC-726', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 730) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-727', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 730, 730, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 730, 'Migration: ' || 'MIG-NO-REC-727', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-728', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 570, 1710, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 570, 'Migration: ' || 'MIG-NO-REC-728', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-729', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-729', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-730', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-730', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 6080) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-731', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 6080, 380, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 6080, 'Migration: ' || 'MIG-NO-REC-731', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-23'::date, 'MIG-NO-REC-732', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 4400, 2200, NULL, 'System Migration', '2026-05-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 4400, 'Migration: ' || 'MIG-NO-REC-732', '2026-05-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-733', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 260, 130, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 260, 'Migration: ' || 'MIG-NO-REC-733', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-734', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-734', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-735', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-735', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-4L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'LATEXMIX-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-736', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 900, 1800, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 900, 'Migration: ' || 'MIG-NO-REC-736', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-737', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-737', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-26'::date, 'MIG-NO-REC-738', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration', '2026-05-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'MIG-NO-REC-738', '2026-05-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-739', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-739', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-4L' OR product_name = 'NAX QDU MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 4L', 'NAXQDUMIX-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-740', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'MIG-NO-REC-740', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-741', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 250, 1250, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 250, 'Migration: ' || 'MIG-NO-REC-741', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-742', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 640, 40, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 640, 'Migration: ' || 'MIG-NO-REC-742', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZSIL-42' OR product_name = 'PYLOX LAZER SILVER 42') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER SILVER 42', 'PLYZSIL-42', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-743', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 135, 270, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 135, 'Migration: ' || 'MIG-NO-REC-743', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZPRGR-145' OR product_name = 'PYLOX LAZER PRIMER GRAY 145') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER PRIMER GRAY 145', 'PLYZPRGR-145', v_branch_id, 0, 135) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-744', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 135, 270, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 135, 'Migration: ' || 'MIG-NO-REC-744', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-745', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-745', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-746', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'MIG-NO-REC-746', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-747', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-747', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-748', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 800, 50, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 800, 'Migration: ' || 'MIG-NO-REC-748', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-749', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'MIG-NO-REC-749', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-750', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-750', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDG-4L' OR product_name = 'PLATONE QDE GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE GREEN 4L', 'PLQDG-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-751', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 900, 1800, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 900, 'Migration: ' || 'MIG-NO-REC-751', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 265) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-752', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 265, 265, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 265, 'Migration: ' || 'MIG-NO-REC-752', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-753', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-753', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-30'::date, 'MIG-NO-REC-754', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-754', '2026-05-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-30'::date, 'MIG-NO-REC-755', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-05-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-755', '2026-05-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-756', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-756', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-757', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2000, 400, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2000, 'Migration: ' || 'MIG-NO-REC-757', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-758', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-758', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-759', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-759', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-760', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-760', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-761', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-761', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-762', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-762', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-763', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-763', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-764', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2600, 520, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2600, 'Migration: ' || 'MIG-NO-REC-764', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-765', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-765', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-766', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-766', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-767', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-767', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-768', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.15, 2800, 420, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.15, 2800, 'Migration: ' || 'MIG-NO-REC-768', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-769', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-769', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-770', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-770', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-771', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-771', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-772', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2500, 500, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2500, 'Migration: ' || 'MIG-NO-REC-772', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-773', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-773', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-774', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-774', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-06'::date, 'MIG-NO-REC-775', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-775', '2026-05-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-776', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-776', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-777', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-777', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-778', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-778', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-779', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-779', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-08'::date, 'MIG-NO-REC-780', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 800, 100, NULL, 'System Migration', '2026-05-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 800, 'Migration: ' || 'MIG-NO-REC-780', '2026-05-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-781', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-781', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-782', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-782', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-783', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 3200, 1600, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 3200, 'Migration: ' || 'MIG-NO-REC-783', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-784', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2900, 580, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2900, 'Migration: ' || 'MIG-NO-REC-784', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-785', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-785', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-786', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 960, 120, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 960, 'Migration: ' || 'MIG-NO-REC-786', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-14'::date, 'MIG-NO-REC-787', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-787', '2026-05-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-788', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-788', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-789', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-789', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-790', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 800, 100, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 800, 'Migration: ' || 'MIG-NO-REC-790', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-791', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-791', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-792', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-792', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-793', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-793', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-794', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-794', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-795', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-795', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-796', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 20, 35, 700, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 35, 'Migration: ' || 'MIG-NO-REC-796', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-797', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 20, 35, 700, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 35, 'Migration: ' || 'MIG-NO-REC-797', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-798', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-798', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-799', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-799', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-800', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 4800, 600, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4800, 'Migration: ' || 'MIG-NO-REC-800', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-801', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-801', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-802', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2800, 560, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2800, 'Migration: ' || 'MIG-NO-REC-802', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-803', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-803', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-804', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 800, 100, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 800, 'Migration: ' || 'MIG-NO-REC-804', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-805', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-805', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-806', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-806', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-807', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2700, 540, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2700, 'Migration: ' || 'MIG-NO-REC-807', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-808', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-808', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-809', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-809', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-810', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-810', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-811', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-811', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-812', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-812', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-25'::date, 'MIG-NO-REC-813', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-05-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-813', '2026-05-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-27'::date, 'MIG-NO-REC-814', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-814', '2026-05-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-815', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-815', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-816', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-816', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-817', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1.5, 700, 1050, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 700, 'Migration: ' || 'MIG-NO-REC-817', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-818', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-818', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-819', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-819', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-820', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-820', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 4480) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-821', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.0625, 4480, 280, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 4480, 'Migration: ' || 'MIG-NO-REC-821', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-822', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-822', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-823', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-823', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-824', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-824', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-825', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-825', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-826', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-826', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-29'::date, 'MIG-NO-REC-827', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-05-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-827', '2026-05-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-828', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-828', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-829', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-829', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-830', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-830', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-831', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-831', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-832', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-832', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-833', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-833', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-834', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-834', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-835', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-835', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-836', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-836', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-837', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-837', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-838', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-838', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-839', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-839', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-840', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-840', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PZPG-1L' OR product_name = 'POLYGLOSS-ZINCROMATE PRIMER GREEN-1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'PZPG-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-841', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-841', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-842', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-842', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-843', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-843', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 730) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-844', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 730, 7300, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 730, 'Migration: ' || 'MIG-NO-REC-844', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-845', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 600, 2400, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 600, 'Migration: ' || 'MIG-NO-REC-845', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-846', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 2800, 8400, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 2800, 'Migration: ' || 'MIG-NO-REC-846', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-847', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-847', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-848', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-848', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-849', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-849', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SEALERMAX5170-4L' OR product_name = 'NIPPON SEALERMAX 5170 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON SEALERMAX 5170 4L', 'SEALERMAX5170-4L', v_branch_id, 0, 1334) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-850', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.375, 1334, 500.25, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 1334, 'Migration: ' || 'MIG-NO-REC-850', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-851', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'MIG-NO-REC-851', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-852', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'MIG-NO-REC-852', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE4090' OR product_name = 'NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'NXE4090', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-853', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-853', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-854', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-854', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-855', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-855', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-18'::date, 'MIG-NO-REC-856', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-856', '2026-06-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-20'::date, 'MIG-NO-REC-857', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-06-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-857', '2026-06-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-20'::date, 'MIG-NO-REC-858', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration', '2026-06-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'MIG-NO-REC-858', '2026-06-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-20'::date, 'MIG-NO-REC-859', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-06-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-859', '2026-06-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-860', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-860', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-861', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-861', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-862', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-862', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-863', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-863', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-864', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-864', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-865', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-865', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-01-05'::date, 'MIG-NO-REC-866', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-01-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-866', '2026-01-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-02'::date, 'MIG-NO-REC-867', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-05-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-867', '2026-05-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-04'::date, 'MIG-NO-REC-868', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-05-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-868', '2026-05-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-869', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-869', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-870', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-870', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-871', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-871', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-872', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-872', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-873', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-873', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-874', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-874', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-875', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-875', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-876', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-876', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-05'::date, 'MIG-NO-REC-877', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-877', '2026-05-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-878', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-878', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-879', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 2720, 680, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'MIG-NO-REC-879', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-880', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 2900, 2900, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2900, 'Migration: ' || 'MIG-NO-REC-880', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-881', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-881', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-07'::date, 'MIG-NO-REC-882', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-882', '2026-05-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-883', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-883', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-884', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-884', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-885', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-885', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-886', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-886', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-887', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-887', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-888', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-888', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-889', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-889', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-11'::date, 'MIG-NO-REC-890', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-05-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-890', '2026-05-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-891', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'MIG-NO-REC-891', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-892', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-892', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-893', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-893', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-12'::date, 'MIG-NO-REC-894', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-894', '2026-05-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-895', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-895', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-896', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-896', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-897', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-897', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-898', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-898', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-899', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-899', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-900', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-900', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-901', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-901', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-902', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-902', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-903', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-903', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-15'::date, 'MIG-NO-REC-904', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2000, 500, NULL, 'System Migration', '2026-05-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'MIG-NO-REC-904', '2026-05-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1380) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-905', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1380, 1380, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1380, 'Migration: ' || 'MIG-NO-REC-905', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-906', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-906', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-907', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-907', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-908', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-908', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-909', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-909', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-910', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-910', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-911', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-911', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-912', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-912', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-913', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-913', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-914', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-914', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-20'::date, 'MIG-NO-REC-915', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-05-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-915', '2026-05-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-916', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-916', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-22'::date, 'MIG-NO-REC-917', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-05-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-917', '2026-05-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-918', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-918', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-919', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-919', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-05-28'::date, 'MIG-NO-REC-920', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-05-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-920', '2026-05-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-921', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-921', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-922', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-922', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-923', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-923', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-924', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-924', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-925', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-925', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-926', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-926', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-927', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-927', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-928', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-928', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-929', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-929', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-930', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-930', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-931', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-931', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-932', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-932', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-933', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-933', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-934', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-934', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-935', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-935', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-936', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-936', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-937', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-937', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-938', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-938', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-939', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-939', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-940', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-940', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-941', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-941', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-942', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-942', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-943', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-943', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-944', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-944', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-945', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-945', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-946', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-946', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-947', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 710, 2130, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 710, 'Migration: ' || 'MIG-NO-REC-947', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-948', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-948', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-949', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2500, 1250, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2500, 'Migration: ' || 'MIG-NO-REC-949', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-950', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2.5, 2500, 6250, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2.5, 2500, 'Migration: ' || 'MIG-NO-REC-950', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-951', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-951', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-952', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-952', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-953', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-953', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-954', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-954', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-955', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-955', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-956', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-956', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2934) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-957', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.75, 2934, 2200.5, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2934, 'Migration: ' || 'MIG-NO-REC-957', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-958', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-958', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-959', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-959', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-960', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-960', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-961', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-961', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-962', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-962', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-963', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-963', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 215) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-964', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 215, 215, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 215, 'Migration: ' || 'MIG-NO-REC-964', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-965', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-965', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-966', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-966', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-967', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'MIG-NO-REC-967', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-968', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-968', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-969', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-969', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-970', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-970', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-971', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-971', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-972', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-972', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-973', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-973', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-974', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-974', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-975', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-975', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-976', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-976', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-977', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-977', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-978', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-978', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 740) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-979', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 740, 740, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 740, 'Migration: ' || 'MIG-NO-REC-979', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-980', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-980', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-981', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-981', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-982', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-982', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-983', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-983', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-17'::date, 'MIG-NO-REC-984', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-984', '2026-06-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-985', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1900, 3800, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1900, 'Migration: ' || 'MIG-NO-REC-985', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-986', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-986', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-987', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1700, 1700, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1700, 'Migration: ' || 'MIG-NO-REC-987', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-988', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-988', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-989', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-989', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-990', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-990', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-991', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-991', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-992', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'MIG-NO-REC-992', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-993', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 800, 100, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 800, 'Migration: ' || 'MIG-NO-REC-993', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGJB-4L' OR product_name = 'POLYGLOSS PU JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU JET BLACK 4L', 'PGJB-4L', v_branch_id, 0, 5760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-994', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 5760, 180, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 5760, 'Migration: ' || 'MIG-NO-REC-994', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-995', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-995', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-996', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-996', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-997', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-997', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-998', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-998', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-999', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-999', '2026-06-01'::timestamp);
  END;
END $$;
