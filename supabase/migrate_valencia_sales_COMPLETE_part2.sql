
-- COMPLETE MIGRATION FOR VALENCIA SALES - PART 2
DO $$
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

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1000', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'MIG-NO-REC-1000', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDEY-4L' OR product_name = 'PLATONE QDE YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE YELLOW 4L', 'PLQDEY-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1001', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1001', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1002', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-1002', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1003', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2650, 2650, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2650, 'Migration: ' || 'MIG-NO-REC-1003', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 420) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1004', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 12, 420, 5040, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 12, 420, 'Migration: ' || 'MIG-NO-REC-1004', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1005', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1005', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1006', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1006', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-01'::date, 'MIG-NO-REC-1007', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 960, 60, NULL, 'System Migration', '2026-06-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'MIG-NO-REC-1007', '2026-06-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBPNTSTRNR' OR product_name = 'ROBFILTER PAINT STRAINER 125M') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBFILTER PAINT STRAINER 125M', 'ROBPNTSTRNR', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-22'::date, 'MIG-NO-REC-1008', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1008', '2026-06-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1009', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1009', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1010', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2720, 680, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'MIG-NO-REC-1010', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 783) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1011', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.125, 783, 880.875, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.125, 783, 'Migration: ' || 'MIG-NO-REC-1011', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1012', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1012', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1013', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1013', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1014', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1014', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1015', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1015', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1016', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1016', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1017', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2700, 540, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2700, 'Migration: ' || 'MIG-NO-REC-1017', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1018', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 100, 150, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 100, 'Migration: ' || 'MIG-NO-REC-1018', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1019', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1019', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-1020', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'MIG-NO-REC-1020', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-1021', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-1021', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-1022', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'MIG-NO-REC-1022', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROSCB-1L' OR product_name = 'RAIN OR SHINE CHOCOLATE BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE CHOCOLATE BROWN 1L', 'ROSCB-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-04'::date, 'MIG-NO-REC-1023', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-06-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1023', '2026-06-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-TEMP-4L' OR product_name = 'RAIN OR SHINE-TEMPTATION 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'ROS-TEMP-4L', v_branch_id, 0, 950) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1024', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 950, 950, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 950, 'Migration: ' || 'MIG-NO-REC-1024', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1025', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1025', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1026', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1026', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1027', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1027', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1028', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 16, 35, 560, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 16, 35, 'Migration: ' || 'MIG-NO-REC-1028', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-05'::date, 'MIG-NO-REC-1029', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 140, 140, NULL, 'System Migration', '2026-06-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 140, 'Migration: ' || 'MIG-NO-REC-1029', '2026-06-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-1030', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2560, 320, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2560, 'Migration: ' || 'MIG-NO-REC-1030', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-06'::date, 'MIG-NO-REC-1031', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration', '2026-06-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'MIG-NO-REC-1031', '2026-06-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1032', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'MIG-NO-REC-1032', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1033', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-1033', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1034', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1034', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1035', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-1035', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2320) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1036', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2320, 580, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2320, 'Migration: ' || 'MIG-NO-REC-1036', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1037', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1037', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1038', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1038', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1039', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-1039', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1040', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 280, 70, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 280, 'Migration: ' || 'MIG-NO-REC-1040', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1041', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 3400, 1700, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 3400, 'Migration: ' || 'MIG-NO-REC-1041', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 2933.33) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1042', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.375, 2933.33, 1099.99875, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.375, 2933.33, 'Migration: ' || 'MIG-NO-REC-1042', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'WCPOD' OR product_name = 'WASTE COTTON POD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('WASTE COTTON POD', 'WCPOD', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1043', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1043', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1044', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 1350, 4050, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 1350, 'Migration: ' || 'MIG-NO-REC-1044', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1045', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1045', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1046', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1046', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1047', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-1047', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGMC-4L' OR product_name = 'POLYGLOSS PU METALLIC COARSE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'PGMC-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1048', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'MIG-NO-REC-1048', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1049', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 3200, 100, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 3200, 'Migration: ' || 'MIG-NO-REC-1049', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1050', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1050', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1051', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1051', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1052', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1052', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1053', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1053', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1054', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1054', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1055', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1055', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1056', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1056', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-1057', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1057', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-1058', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-1058', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-1059', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1059', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-1060', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1060', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-12'::date, 'MIG-NO-REC-1061', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-06-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1061', '2026-06-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1062', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1062', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1063', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1063', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1064', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1064', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1065', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1065', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1066', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1066', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1067', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1067', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1068', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1068', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEEKBOS-1L' OR product_name = 'MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'MEEKBOS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1069', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-1069', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #4' OR product_name = 'JAPAN PUTTY KNIFE #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #4', 'PUTTYKNI #4', v_branch_id, 0, 60) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-13'::date, 'MIG-NO-REC-1070', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 60, 60, NULL, 'System Migration', '2026-06-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 60, 'Migration: ' || 'MIG-NO-REC-1070', '2026-06-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-1071', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1071', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-1072', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1072', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-1073', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1073', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-1074', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1074', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-15'::date, 'MIG-NO-REC-1075', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-06-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1075', '2026-06-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-710' OR product_name = 'BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'B-710', v_branch_id, 0, 870) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-1076', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 870, 870, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 870, 'Migration: ' || 'MIG-NO-REC-1076', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-1077', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-1077', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT740' OR product_name = 'NAX NAT-740 TTC ULTRA FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'NAT740', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-16'::date, 'MIG-NO-REC-1078', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration', '2026-06-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'MIG-NO-REC-1078', '2026-06-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1079', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 1100, 3300, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 1100, 'Migration: ' || 'MIG-NO-REC-1079', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1080', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, -1, 2800, -2800, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', -1, 2800, 'Migration: ' || 'MIG-NO-REC-1080', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-1081', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 615, 615, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 615, 'Migration: ' || 'MIG-NO-REC-1081', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-1082', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 100, 300, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 100, 'Migration: ' || 'MIG-NO-REC-1082', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1710' OR product_name = 'BOYSEN ACRYTEX GLOSS WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'B-1710', v_branch_id, 0, 1245) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-19'::date, 'MIG-NO-REC-1083', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1245, 1245, NULL, 'System Migration', '2026-06-19'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1245, 'Migration: ' || 'MIG-NO-REC-1083', '2026-06-19'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1084', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-1084', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1085', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1085', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1086', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 220, 110, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 220, 'Migration: ' || 'MIG-NO-REC-1086', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1087', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1087', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1088', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-1088', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1089', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1089', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-02'::date, 'MIG-NO-REC-1090', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1090', '2026-06-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1091', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1091', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-03'::date, 'MIG-NO-REC-1092', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1092', '2026-06-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1093', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1093', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1094', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 400, 100, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 400, 'Migration: ' || 'MIG-NO-REC-1094', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1095', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-1095', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1096', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1096', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-08'::date, 'MIG-NO-REC-1097', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1097', '2026-06-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1098', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1098', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1099', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1099', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1100', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 400, 200, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 400, 'Migration: ' || 'MIG-NO-REC-1100', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1101', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1101', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1102', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1102', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1460) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1103', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1460, 730, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1460, 'Migration: ' || 'MIG-NO-REC-1103', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1104', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 710, 355, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 710, 'Migration: ' || 'MIG-NO-REC-1104', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1105', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1105', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1106', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1106', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1107', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1107', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1108', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1108', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-09'::date, 'MIG-NO-REC-1109', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 400, 100, NULL, 'System Migration', '2026-06-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 400, 'Migration: ' || 'MIG-NO-REC-1109', '2026-06-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1110', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2720, 680, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2720, 'Migration: ' || 'MIG-NO-REC-1110', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1111', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2000, 500, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'MIG-NO-REC-1111', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1112', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-1112', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1113', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1113', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-60' OR product_name = 'CUMI SUPREME FLOOR SANDING 60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 60', 'CUMIFS-60', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-10'::date, 'MIG-NO-REC-1114', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 95, 190, NULL, 'System Migration', '2026-06-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 95, 'Migration: ' || 'MIG-NO-REC-1114', '2026-06-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1115', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-1115', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1116', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1116', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1117', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-1117', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1118', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1118', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1119', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1119', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1120', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1120', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1121', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1121', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1122', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1122', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-11'::date, 'MIG-NO-REC-1123', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-06-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1123', '2026-06-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOPT-BOT' OR product_name = 'UNO PAINT THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO PAINT THINNER BOT', 'UNOPT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1124', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 80, 160, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 80, 'Migration: ' || 'MIG-NO-REC-1124', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1125', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1760, 440, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1760, 'Migration: ' || 'MIG-NO-REC-1125', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-23'::date, 'MIG-NO-REC-1126', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-06-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1126', '2026-06-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1127', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1127', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1128', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-1128', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1129', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1129', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1130', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1130', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1131', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1131', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1132', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1132', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1133', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1133', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1134', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1134', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1135', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1135', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1136', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 15, 35, 525, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 15, 35, 'Migration: ' || 'MIG-NO-REC-1136', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1137', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1137', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1138', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 1350, 2700, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1350, 'Migration: ' || 'MIG-NO-REC-1138', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-1L' OR product_name = 'NAX NAT-990 TTC BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 1L', 'NAT990-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1139', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1139', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 920) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1140', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 920, 230, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 920, 'Migration: ' || 'MIG-NO-REC-1140', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1141', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1141', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGFB-4L' OR product_name = 'POLYGLOSS PU FLAT BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'PGFB-4L', v_branch_id, 0, 2933.333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1142', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.1875, 2933.333333, 550, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 2933.333333, 'Migration: ' || 'MIG-NO-REC-1142', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1143', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-1143', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1144', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1144', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1145', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1145', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 860) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1146', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 860, 430, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 860, 'Migration: ' || 'MIG-NO-REC-1146', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1147', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-1147', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-24'::date, 'MIG-NO-REC-1148', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration', '2026-06-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'MIG-NO-REC-1148', '2026-06-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 3680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1149', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3680, 230, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3680, 'Migration: ' || 'MIG-NO-REC-1149', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1150', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1150', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1151', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1151', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1152', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-1152', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1153', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-1153', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1154', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 800, 1600, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 800, 'Migration: ' || 'MIG-NO-REC-1154', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1155', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2400, 1200, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2400, 'Migration: ' || 'MIG-NO-REC-1155', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 2720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1156', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2720, 1360, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2720, 'Migration: ' || 'MIG-NO-REC-1156', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1157', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1157', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1158', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1158', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1159', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1159', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1160', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.125, 2000, 250, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2000, 'Migration: ' || 'MIG-NO-REC-1160', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1161', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1161', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1162', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 90, 450, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 90, 'Migration: ' || 'MIG-NO-REC-1162', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1163', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1500, 750, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1500, 'Migration: ' || 'MIG-NO-REC-1163', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1164', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.125, 2000, 250, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2000, 'Migration: ' || 'MIG-NO-REC-1164', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1' OR product_name = 'CROCO MASKING TAPE #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE #1', 'CRO-MT1', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-25'::date, 'MIG-NO-REC-1165', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-06-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-1165', '2026-06-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1166', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-1166', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1167', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.75, 800, 600, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 800, 'Migration: ' || 'MIG-NO-REC-1167', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1168', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1168', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1169', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1169', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1170', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1170', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1171', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1171', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1172', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-1172', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 5200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-26'::date, 'MIG-NO-REC-1173', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.75, 5200, 3900, NULL, 'System Migration', '2026-06-26'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 5200, 'Migration: ' || 'MIG-NO-REC-1173', '2026-06-26'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1174', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1120, 280, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1120, 'Migration: ' || 'MIG-NO-REC-1174', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-701' OR product_name = 'RAIN OR SHINE BAGUIO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'ROS-701', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1175', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 930, 3720, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 930, 'Migration: ' || 'MIG-NO-REC-1175', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1176', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1176', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1177', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.4, 2600, 1040, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.4, 2600, 'Migration: ' || 'MIG-NO-REC-1177', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1178', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2400, 1200, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2400, 'Migration: ' || 'MIG-NO-REC-1178', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1179', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2000, 400, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2000, 'Migration: ' || 'MIG-NO-REC-1179', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1180', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2600, 520, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2600, 'Migration: ' || 'MIG-NO-REC-1180', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1181', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1181', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1150) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-29'::date, 'MIG-NO-REC-1182', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 1150, 6900, NULL, 'System Migration', '2026-06-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 1150, 'Migration: ' || 'MIG-NO-REC-1182', '2026-06-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NLT-4L' OR product_name = 'NIPPON LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON LACQUER THINNER 4L', 'NLT-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-29'::date, 'MIG-NO-REC-1183', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 650, 1300, NULL, 'System Migration', '2026-06-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 650, 'Migration: ' || 'MIG-NO-REC-1183', '2026-06-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1184', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 2900, 2900, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2900, 'Migration: ' || 'MIG-NO-REC-1184', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1185', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1185', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1186', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 680, 2040, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 680, 'Migration: ' || 'MIG-NO-REC-1186', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1187', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1187', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-1L' OR product_name = 'PLATONE QDE BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 1L', 'PLQDB-1L', v_branch_id, 0, 1066.666667) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1188', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.1875, 1066.666667, 200, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.1875, 1066.666667, 'Migration: ' || 'MIG-NO-REC-1188', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1189', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1189', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1190', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1190', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1191', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1191', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1192', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1192', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-27'::date, 'MIG-NO-REC-1193', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-06-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1193', '2026-06-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-28'::date, 'MIG-NO-REC-1194', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 230, 690, NULL, 'System Migration', '2026-06-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 230, 'Migration: ' || 'MIG-NO-REC-1194', '2026-06-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-28'::date, 'MIG-NO-REC-1195', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration', '2026-06-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'MIG-NO-REC-1195', '2026-06-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-28'::date, 'MIG-NO-REC-1196', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 960, 240, NULL, 'System Migration', '2026-06-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 960, 'Migration: ' || 'MIG-NO-REC-1196', '2026-06-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSQDEW-GAL' OR product_name = 'BOYSEN QDE WHITE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN QDE WHITE GAL', 'BSQDEW-GAL', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-28'::date, 'MIG-NO-REC-1197', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1120, 140, NULL, 'System Migration', '2026-06-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1120, 'Migration: ' || 'MIG-NO-REC-1197', '2026-06-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-28'::date, 'MIG-NO-REC-1198', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-06-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1198', '2026-06-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1199', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 850, 850, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 850, 'Migration: ' || 'MIG-NO-REC-1199', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1200', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1200', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1201', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1201', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1202', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1202', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1203', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'MIG-NO-REC-1203', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1204', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1204', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1205', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1205', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1206', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1206', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1207', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1207', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1208', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-1208', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1209', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1209', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1210', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 600, 1200, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 600, 'Migration: ' || 'MIG-NO-REC-1210', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 570) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1211', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 570, 855, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 570, 'Migration: ' || 'MIG-NO-REC-1211', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1212', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1212', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1983' OR product_name = 'NIPPELAC ACE JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPELAC ACE JET BLACK 4L', 'NPA1983', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1213', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1800, 450, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1800, 'Migration: ' || 'MIG-NO-REC-1213', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1214', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1214', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-06-30'::date, 'MIG-NO-REC-1215', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-06-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1215', '2026-06-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1216', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1216', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1217', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1217', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1218', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1900, 950, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1900, 'Migration: ' || 'MIG-NO-REC-1218', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1219', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-1219', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1220', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1220', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 1150) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1221', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1150, 1150, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1150, 'Migration: ' || 'MIG-NO-REC-1221', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1222', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 280, 1120, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 280, 'Migration: ' || 'MIG-NO-REC-1222', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1223', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'MIG-NO-REC-1223', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1224', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.75, 2400, 1800, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2400, 'Migration: ' || 'MIG-NO-REC-1224', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1225', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.2, 2900, 580, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2900, 'Migration: ' || 'MIG-NO-REC-1225', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1226', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1226', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1227', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-1227', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1228', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1228', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1229', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1229', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1230', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.125, 4800, 600, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 4800, 'Migration: ' || 'MIG-NO-REC-1230', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1231', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1231', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1232', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1232', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1233', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1233', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1234', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1234', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1235', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1235', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-01'::date, 'MIG-NO-REC-1236', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1236', '2026-07-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901R-1L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'MEG3901R-1L', v_branch_id, 0, 300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1237', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 300, 300, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 300, 'Migration: ' || 'MIG-NO-REC-1237', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1238', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 40, 40, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 40, 'Migration: ' || 'MIG-NO-REC-1238', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1239', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1239', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1240', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1240', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1241', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 90, 90, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 90, 'Migration: ' || 'MIG-NO-REC-1241', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1242', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1242', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1243', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1243', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1244', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 3200, 200, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 3200, 'Migration: ' || 'MIG-NO-REC-1244', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1245', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1245', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1246', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.03125, 4800, 150, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.03125, 4800, 'Migration: ' || 'MIG-NO-REC-1246', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1161' OR product_name = 'NAX NAT-1161 TTC LAVENDER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'NAT1161', v_branch_id, 0, 1560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-02'::date, 'MIG-NO-REC-1247', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1560, 390, NULL, 'System Migration', '2026-07-02'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1560, 'Migration: ' || 'MIG-NO-REC-1247', '2026-07-02'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1248', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2900, 580, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2900, 'Migration: ' || 'MIG-NO-REC-1248', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1249', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1249', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1250', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1250', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1251', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1251', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1252', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1252', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1253', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1253', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1254', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1254', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1255', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'MIG-NO-REC-1255', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1256', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'MIG-NO-REC-1256', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1257', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-1257', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1258', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1258', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1259', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1259', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1260', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1260', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1261', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1261', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1262', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1262', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1263', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1263', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1264', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1264', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1265', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1265', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1266', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1266', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 610) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1267', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 610, 610, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 610, 'Migration: ' || 'MIG-NO-REC-1267', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-03'::date, 'MIG-NO-REC-1268', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-07-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1268', '2026-07-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1269', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 680, 2720, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 680, 'Migration: ' || 'MIG-NO-REC-1269', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1270', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.2, 2600, 520, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2600, 'Migration: ' || 'MIG-NO-REC-1270', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1271', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-1271', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1272', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1272', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP8100' OR product_name = 'NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'NP8100', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1273', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1900, 1900, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1900, 'Migration: ' || 'MIG-NO-REC-1273', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1274', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-1274', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-04'::date, 'MIG-NO-REC-1275', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1275', '2026-07-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1276', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1200, 2400, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1200, 'Migration: ' || 'MIG-NO-REC-1276', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NLT-4L' OR product_name = 'NIPPON LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON LACQUER THINNER 4L', 'NLT-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1277', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 650, 1300, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 650, 'Migration: ' || 'MIG-NO-REC-1277', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1278', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1278', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1279', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-1279', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1280', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-1280', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1281', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 780, 3120, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 780, 'Migration: ' || 'MIG-NO-REC-1281', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1282', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'MIG-NO-REC-1282', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 740) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1283', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 740, 740, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 740, 'Migration: ' || 'MIG-NO-REC-1283', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1284', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1284', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1285', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1285', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITWHITE-4L' OR product_name = 'DO IT URETHANE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE WHITE 4L', 'DOITWHITE-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1286', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2400, 300, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'MIG-NO-REC-1286', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1287', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1287', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-06'::date, 'MIG-NO-REC-1288', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-07-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-1288', '2026-07-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1289', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1289', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1290', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'MIG-NO-REC-1290', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1291', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1291', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1292', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'MIG-NO-REC-1292', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1293', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1293', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1294', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1294', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1295', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1295', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1296', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'MIG-NO-REC-1296', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITSHLDALL-BOT' OR product_name = 'DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'DOITSHLDALL-BOT', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1297', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 185, 185, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 185, 'Migration: ' || 'MIG-NO-REC-1297', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1298', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 560, 1120, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 560, 'Migration: ' || 'MIG-NO-REC-1298', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1299', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1299', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1300', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 640, 1280, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 640, 'Migration: ' || 'MIG-NO-REC-1300', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1301', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1301', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1302', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-1302', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1303', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'MIG-NO-REC-1303', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1304', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1304', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1305', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1305', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1306', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'MIG-NO-REC-1306', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1307', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1307', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-07'::date, 'MIG-NO-REC-1308', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 700, 175, NULL, 'System Migration', '2026-07-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 700, 'Migration: ' || 'MIG-NO-REC-1308', '2026-07-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 3040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1309', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3040, 380, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3040, 'Migration: ' || 'MIG-NO-REC-1309', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1310', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1310', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1311', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1311', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1312', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1312', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1313', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1313', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-701-4L' OR product_name = 'FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L', 'B-701-4L', v_branch_id, 0, 770) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1314', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 770, 770, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 770, 'Migration: ' || 'MIG-NO-REC-1314', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 630) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-08'::date, 'MIG-NO-REC-1315', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 630, 1260, NULL, 'System Migration', '2026-07-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 630, 'Migration: ' || 'MIG-NO-REC-1315', '2026-07-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1316', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 600, 2400, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 600, 'Migration: ' || 'MIG-NO-REC-1316', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1317', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1317', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1318', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1318', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1319', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1319', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1320', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 6, 35, 210, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 35, 'Migration: ' || 'MIG-NO-REC-1320', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1321', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 800, 2400, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 800, 'Migration: ' || 'MIG-NO-REC-1321', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1322', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1322', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1323', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-1323', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1324', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1324', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1325', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-1325', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1326', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 100, 400, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 100, 'Migration: ' || 'MIG-NO-REC-1326', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FRANELLA' OR product_name = 'FRANELLA CLOTH 1YARD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('FRANELLA CLOTH 1YARD', 'FRANELLA', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1327', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1327', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1328', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-1328', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1329', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1329', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1330', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 6, 710, 4260, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 710, 'Migration: ' || 'MIG-NO-REC-1330', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1331', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 280, 1120, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 280, 'Migration: ' || 'MIG-NO-REC-1331', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1332', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 1200, 2400, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1200, 'Migration: ' || 'MIG-NO-REC-1332', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-09'::date, 'MIG-NO-REC-1333', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 2400, 4800, NULL, 'System Migration', '2026-07-09'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 2400, 'Migration: ' || 'MIG-NO-REC-1333', '2026-07-09'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1334', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1334', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1335', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1335', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1336', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1336', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1337', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1337', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1338', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1338', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1339', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 95, 285, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 95, 'Migration: ' || 'MIG-NO-REC-1339', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1705' OR product_name = 'ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'B-1705', v_branch_id, 0, 1160) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1340', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1160, 2320, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1160, 'Migration: ' || 'MIG-NO-REC-1340', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-15L' OR product_name = 'LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'LATEXMIX-15L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-10'::date, 'MIG-NO-REC-1341', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 3200, 3200, NULL, 'System Migration', '2026-07-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 3200, 'Migration: ' || 'MIG-NO-REC-1341', '2026-07-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1342', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1.5, 1000, 1500, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 1000, 'Migration: ' || 'MIG-NO-REC-1342', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1343', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1343', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1344', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1344', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1345', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 930, 930, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 930, 'Migration: ' || 'MIG-NO-REC-1345', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1346', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1346', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1347', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1347', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1348', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1348', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1349', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1349', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 58.33333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1350', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 58.33333333, 175, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 58.33333333, 'Migration: ' || 'MIG-NO-REC-1350', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1351', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1351', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-11'::date, 'MIG-NO-REC-1352', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-07-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1352', '2026-07-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1353', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1353', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1354', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1354', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1355', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1355', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1356', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1356', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1357', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1357', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1358', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1358', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1359', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 90, 180, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 90, 'Migration: ' || 'MIG-NO-REC-1359', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1360', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1360', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1361', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1361', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1362', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1362', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1363', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-1363', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1364', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1364', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1365', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1365', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1366', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1366', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1367', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1367', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1368', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1368', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1369', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-1369', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1370', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 4400, 4400, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 4400, 'Migration: ' || 'MIG-NO-REC-1370', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1371', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2960, 740, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2960, 'Migration: ' || 'MIG-NO-REC-1371', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1372', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-1372', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-13'::date, 'MIG-NO-REC-1373', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1373', '2026-07-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'Code Not Found' OR product_name = 'ACRYLIC NP, POLYGLOSS 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ACRYLIC NP, POLYGLOSS 4L', 'Code Not Found', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1374', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'MIG-NO-REC-1374', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1375', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-1375', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1376', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1376', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1377', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1377', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1378', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'MIG-NO-REC-1378', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2560) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1379', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2560, 320, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2560, 'Migration: ' || 'MIG-NO-REC-1379', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1380', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1380', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1381', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1381', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1382', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 1600, 800, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1600, 'Migration: ' || 'MIG-NO-REC-1382', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1383', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-1383', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1384', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 650, 1950, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 650, 'Migration: ' || 'MIG-NO-REC-1384', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1385', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-1385', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1386', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1386', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1387', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1387', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1388', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1388', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1389', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1389', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1390', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 640, 320, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 640, 'Migration: ' || 'MIG-NO-REC-1390', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1391', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.125, 2400, 300, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2400, 'Migration: ' || 'MIG-NO-REC-1391', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1392', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-1392', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1393', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1393', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1394', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1394', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1395', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1395', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-14'::date, 'MIG-NO-REC-1396', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1396', '2026-07-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ACRYPRIMER-4L' OR product_name = 'ALPHA CHROMA ACRYTILE PRIMER WHITE') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'ACRYPRIMER-4L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1397', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1397', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-15L' OR product_name = 'LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'LATEXMIX-15L', v_branch_id, 0, 3200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1398', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 3200, 3200, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 3200, 'Migration: ' || 'MIG-NO-REC-1398', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1399', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1399', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1400', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1400', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1401', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1400, 350, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1400, 'Migration: ' || 'MIG-NO-REC-1401', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1402', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1402', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-15'::date, 'MIG-NO-REC-1403', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 760, 190, NULL, 'System Migration', '2026-07-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 760, 'Migration: ' || 'MIG-NO-REC-1403', '2026-07-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1404', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1404', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1405', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1405', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1406', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1040, 260, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1040, 'Migration: ' || 'MIG-NO-REC-1406', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 1760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1407', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1760, 220, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1760, 'Migration: ' || 'MIG-NO-REC-1407', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1408', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'MIG-NO-REC-1408', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1409', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1409', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1410', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1410', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1411', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1411', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-16'::date, 'MIG-NO-REC-1412', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-16'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1412', '2026-07-16'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1413', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'MIG-NO-REC-1413', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1414', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1414', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1415', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 1600, 200, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 1600, 'Migration: ' || 'MIG-NO-REC-1415', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 860) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1416', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 860, 430, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 860, 'Migration: ' || 'MIG-NO-REC-1416', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1417', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1417', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1418', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 760, 380, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 760, 'Migration: ' || 'MIG-NO-REC-1418', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1419', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1419', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1420', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1420', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1421', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'MIG-NO-REC-1421', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1422', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1422', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1423', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1423', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1424', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1424', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-17'::date, 'MIG-NO-REC-1425', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 1800, 450, NULL, 'System Migration', '2026-07-17'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1800, 'Migration: ' || 'MIG-NO-REC-1425', '2026-07-17'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1426', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1426', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1427', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1427', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1428', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1428', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1429', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1429', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1430', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1430', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA60' OR product_name = 'EAGLE SANDPAPER #60') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #60', 'EA60', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1431', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-1431', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1432', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1432', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1433', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1433', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1434', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1434', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1435', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1435', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 790) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1436', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 790, 790, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 790, 'Migration: ' || 'MIG-NO-REC-1436', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1437', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1437', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDRB-4L' OR product_name = 'PLATONE QDE ROYAL BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLQDRB-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1438', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 900, 1800, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 900, 'Migration: ' || 'MIG-NO-REC-1438', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NMPREDOX-GAL' OR product_name = 'NIPPON METAL PRIMER RED OXIDE GAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'NMPREDOX-GAL', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1439', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1439', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DV400-WHITE-4L' OR product_name = 'DAVIES QDE WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DAVIES QDE WHITE 4L', 'DV400-WHITE-4L', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1440', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1120, 1120, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1120, 'Migration: ' || 'MIG-NO-REC-1440', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1441', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 230, 460, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 230, 'Migration: ' || 'MIG-NO-REC-1441', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1442', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 840, 420, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 840, 'Migration: ' || 'MIG-NO-REC-1442', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1443', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1.75, 680, 1190, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.75, 680, 'Migration: ' || 'MIG-NO-REC-1443', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1444', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1444', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1445', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1445', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1446', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1446', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-18'::date, 'MIG-NO-REC-1447', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-07-18'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-1447', '2026-07-18'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1448', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'MIG-NO-REC-1448', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1449', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1449', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1450', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1450', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1451', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1451', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1452', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 75, 75, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 75, 'Migration: ' || 'MIG-NO-REC-1452', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1453', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-1453', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1454', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-1454', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1455', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1455', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1456', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1456', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1457', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 840, 420, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 840, 'Migration: ' || 'MIG-NO-REC-1457', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1458', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1458', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOITUH' OR product_name = 'DO IT URETHANE HARDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT URETHANE HARDENER', 'DOITUH', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1459', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'MIG-NO-REC-1459', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 75) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1460', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 75, 150, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 75, 'Migration: ' || 'MIG-NO-REC-1460', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-5L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 5L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'DCF701-5L', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1461', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 930, 930, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 930, 'Migration: ' || 'MIG-NO-REC-1461', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-20'::date, 'MIG-NO-REC-1462', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 880, 880, NULL, 'System Migration', '2026-07-20'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 880, 'Migration: ' || 'MIG-NO-REC-1462', '2026-07-20'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1463', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2700, 675, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2700, 'Migration: ' || 'MIG-NO-REC-1463', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1464', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.75, 2500, 1875, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 2500, 'Migration: ' || 'MIG-NO-REC-1464', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001R-1L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER WHITE W/H REPACK', 'MEG3001R-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1465', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-1465', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1466', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1466', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1467', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1467', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-4L' OR product_name = 'EXTREME QDU MIXING 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 4L', 'EXTREMEMIX-4L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1468', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.625, 2800, 1750, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.625, 2800, 'Migration: ' || 'MIG-NO-REC-1468', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1469', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1469', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1470', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1470', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1471', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1471', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1472', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1472', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1473', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1473', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1474', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1474', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 960) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1475', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.0625, 960, 60, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 960, 'Migration: ' || 'MIG-NO-REC-1475', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1476', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1000, 2000, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1000, 'Migration: ' || 'MIG-NO-REC-1476', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-21'::date, 'MIG-NO-REC-1477', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-21'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1477', '2026-07-21'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1478', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'MIG-NO-REC-1478', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1479', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2000, 500, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'MIG-NO-REC-1479', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1480', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1480', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1481', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 2500, 500, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 2500, 'Migration: ' || 'MIG-NO-REC-1481', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1482', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1482', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1483', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-1483', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1484', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1484', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1485', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1485', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1486', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 580, 2320, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 580, 'Migration: ' || 'MIG-NO-REC-1486', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1487', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1487', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 630) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1488', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 630, 630, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 630, 'Migration: ' || 'MIG-NO-REC-1488', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1489', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1489', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1490', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1490', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1491', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1491', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-22'::date, 'MIG-NO-REC-1492', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration', '2026-07-22'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'MIG-NO-REC-1492', '2026-07-22'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1493', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1493', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1494', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1494', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1495', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1495', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1496', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1496', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1497', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1497', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1498', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1120, 280, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1120, 'Migration: ' || 'MIG-NO-REC-1498', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1499', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1499', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1500', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 90, 45, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 90, 'Migration: ' || 'MIG-NO-REC-1500', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-100' OR product_name = 'CUMI SUPREME FLOOR SANDING 100') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 100', 'CUMIFS-100', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1501', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 95, 190, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 95, 'Migration: ' || 'MIG-NO-REC-1501', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTB-47' OR product_name = 'PYLOX MATT BLACK#47') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX MATT BLACK#47', 'PLYZMTB-47', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1502', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 145, 145, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 145, 'Migration: ' || 'MIG-NO-REC-1502', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1503', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1503', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1504', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1504', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1505', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1505', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1506', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1506', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 3840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1507', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 3840, 480, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 3840, 'Migration: ' || 'MIG-NO-REC-1507', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#3' OR product_name = '2B PAINT BRUSH #3') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH #3', '2B-PB#3', v_branch_id, 0, 90) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1508', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 90, 90, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 90, 'Migration: ' || 'MIG-NO-REC-1508', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1509', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1509', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PG888-4L' OR product_name = 'POLYGLOSS PU 888 RED 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS PU 888 RED 4L', 'PG888-4L', v_branch_id, 0, 4800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-23'::date, 'MIG-NO-REC-1510', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.75, 4800, 3600, NULL, 'System Migration', '2026-07-23'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.75, 4800, 'Migration: ' || 'MIG-NO-REC-1510', '2026-07-23'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1511', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1800, 1800, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1800, 'Migration: ' || 'MIG-NO-REC-1511', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1512', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1512', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1513', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1513', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1514', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1514', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1515', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.125, 2800, 350, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.125, 2800, 'Migration: ' || 'MIG-NO-REC-1515', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1516', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1516', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1517', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1517', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1518', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-1518', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1519', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-1519', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1520', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1520', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1521', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1521', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1522', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1522', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1523', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1523', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1524', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2500, 1250, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2500, 'Migration: ' || 'MIG-NO-REC-1524', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1525', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1525', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1526', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 710, 710, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 710, 'Migration: ' || 'MIG-NO-REC-1526', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1527', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1527', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1528', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1528', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1529', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1529', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1530', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1530', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1531', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1531', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1532', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1532', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-24'::date, 'MIG-NO-REC-1533', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-24'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1533', '2026-07-24'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1534', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2400, 600, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2400, 'Migration: ' || 'MIG-NO-REC-1534', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 220) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1535', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 220, 220, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 220, 'Migration: ' || 'MIG-NO-REC-1535', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1536', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1536', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1537', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1537', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-223' OR product_name = 'RAIN OR SHINE NICOLE PINK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE NICOLE PINK 4L', 'ROS-223', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1538', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'MIG-NO-REC-1538', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1539', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1539', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1540', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-1540', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1541', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-1541', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1542', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1542', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1543', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1543', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-25'::date, 'MIG-NO-REC-1544', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 1500, 750, NULL, 'System Migration', '2026-07-25'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1500, 'Migration: ' || 'MIG-NO-REC-1544', '2026-07-25'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1545', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 680, 2720, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 680, 'Migration: ' || 'MIG-NO-REC-1545', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1546', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1546', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1547', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 700, 2800, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 700, 'Migration: ' || 'MIG-NO-REC-1547', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1548', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1548', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1549', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1549', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOUT-4L' OR product_name = 'TIMEOUT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT URETHANE THINNER 4L', 'TOUT-4L', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1550', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1550', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-4L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'LATEXMIX-4L', v_branch_id, 0, 1150) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1551', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1150, 1150, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1150, 'Migration: ' || 'MIG-NO-REC-1551', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-27'::date, 'MIG-NO-REC-1552', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-07-27'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-1552', '2026-07-27'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1553', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1553', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1554', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1554', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1555', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 580, 870, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 580, 'Migration: ' || 'MIG-NO-REC-1555', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1556', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1556', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1557', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1557', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1558', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1558', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1559', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-1559', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1560', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 2600, 5200, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 2600, 'Migration: ' || 'MIG-NO-REC-1560', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 5200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1561', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 5200, 1300, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 5200, 'Migration: ' || 'MIG-NO-REC-1561', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'FRANELLA' OR product_name = 'FRANELLA CLOTH 1YARD') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('FRANELLA CLOTH 1YARD', 'FRANELLA', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1562', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1562', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1563', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-1563', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-1L' OR product_name = 'NAX NAT-1OO TTC WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1OO TTC WHITE 1L', 'NAT100-1L', v_branch_id, 0, 1100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1564', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 1100, 1100, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1100, 'Migration: ' || 'MIG-NO-REC-1564', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1565', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1565', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1566', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 710, 1420, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 710, 'Migration: ' || 'MIG-NO-REC-1566', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1567', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 1600, 400, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1600, 'Migration: ' || 'MIG-NO-REC-1567', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1568', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 230, 460, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 230, 'Migration: ' || 'MIG-NO-REC-1568', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1569', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1569', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1570', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1570', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '#REF!' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', '#REF!', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1571', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1571', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1572', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1572', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1573', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1573', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-29'::date, 'MIG-NO-REC-1574', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-07-29'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1574', '2026-07-29'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT3974' OR product_name = 'NAX NAT-3974 QDU FLAT BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'NAT3974', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1575', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1575', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1576', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1576', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1040) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1577', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.0625, 1040, 65, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.0625, 1040, 'Migration: ' || 'MIG-NO-REC-1577', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1578', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 100, 50, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 100, 'Migration: ' || 'MIG-NO-REC-1578', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1579', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1579', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1580', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 880, 220, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 880, 'Migration: ' || 'MIG-NO-REC-1580', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1581', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1581', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1582', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1582', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'B-1711' OR product_name = 'BOYSEN ACRYTEX CAST 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('BOYSEN ACRYTEX CAST 4L', 'B-1711', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1583', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 640, 640, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 640, 'Migration: ' || 'MIG-NO-REC-1583', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DPB-1 1/2' OR product_name = 'DRAGONFLY PAINT BRUSH #1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'DPB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1584', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1584', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 825) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1585', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 825, 825, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 825, 'Migration: ' || 'MIG-NO-REC-1585', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1586', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1586', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1587', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-1587', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1588', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 8, 25, 200, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 8, 25, 'Migration: ' || 'MIG-NO-REC-1588', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1589', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1589', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 83.33333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1590', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 83.33333333, 125, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 83.33333333, 'Migration: ' || 'MIG-NO-REC-1590', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1591', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1591', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1592', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1592', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1593', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1593', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1594', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1594', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1595', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1595', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 70) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1596', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 70, 70, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 70, 'Migration: ' || 'MIG-NO-REC-1596', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AC-40-1L' OR product_name = 'HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'AC-40-1L', v_branch_id, 0, 180) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-30'::date, 'MIG-NO-REC-1597', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 180, 180, NULL, 'System Migration', '2026-07-30'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 180, 'Migration: ' || 'MIG-NO-REC-1597', '2026-07-30'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-1L' OR product_name = 'GLAZER AUTO ENAMEL MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 1L', 'AEMIX-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1598', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 250, 1000, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 250, 'Migration: ' || 'MIG-NO-REC-1598', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1180) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1599', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1180, 590, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1180, 'Migration: ' || 'MIG-NO-REC-1599', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1600', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1600', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1601', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1601', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1602', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1602', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 670) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1603', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 670, 670, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 670, 'Migration: ' || 'MIG-NO-REC-1603', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1604', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1604', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GLAZERB-4L' OR product_name = 'GLAZER AUTOMOTIVE ENAMEL BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'GLAZERB-4L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1605', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1605', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PZPG-1L' OR product_name = 'POLYGLOSS-ZINCROMATE PRIMER GREEN-1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'PZPG-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1606', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 550, 550, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 550, 'Migration: ' || 'MIG-NO-REC-1606', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1607', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1607', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1608', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 40, 400, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 40, 'Migration: ' || 'MIG-NO-REC-1608', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1609', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1609', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1610', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1610', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1611', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-1611', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1612', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1612', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1613', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 700, 2800, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 700, 'Migration: ' || 'MIG-NO-REC-1613', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 670) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1614', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 670, 2680, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 670, 'Migration: ' || 'MIG-NO-REC-1614', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1615', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1615', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1616', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1616', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 690) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1617', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 690, 1380, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 690, 'Migration: ' || 'MIG-NO-REC-1617', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-31'::date, 'MIG-NO-REC-1618', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration', '2026-07-31'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'MIG-NO-REC-1618', '2026-07-31'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1619', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1619', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HDOIT' OR product_name = 'DO IT HARDENER 2K TOP COAT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT HARDENER 2K TOP COAT', 'HDOIT', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1620', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'MIG-NO-REC-1620', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1621', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1621', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1622', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1622', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-07-28'::date, 'MIG-NO-REC-1623', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-07-28'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1623', '2026-07-28'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1624', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 590, 1180, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 590, 'Migration: ' || 'MIG-NO-REC-1624', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1625', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 750, 2250, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 750, 'Migration: ' || 'MIG-NO-REC-1625', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1626', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1626', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 670) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1627', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 670, 4020, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 670, 'Migration: ' || 'MIG-NO-REC-1627', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1628', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1628', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-1L' OR product_name = 'NAX NAT-990 TTC BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-990 TTC BLACK 1L', 'NAT990-1L', v_branch_id, 0, 980) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1629', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 980, 980, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 980, 'Migration: ' || 'MIG-NO-REC-1629', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1630', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'MIG-NO-REC-1630', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGANTI-C-1L' OR product_name = 'POLYGLOSS ANTI-CORROSSION') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS ANTI-CORROSSION', 'PGANTI-C-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1631', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 550, 550, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 550, 'Migration: ' || 'MIG-NO-REC-1631', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PGTOPC-1L' OR product_name = 'POLYGLOSS TOP COAT W/H') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('POLYGLOSS TOP COAT W/H', 'PGTOPC-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1632', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1632', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HDOIT' OR product_name = 'DO IT HARDENER 2K TOP COAT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DO IT HARDENER 2K TOP COAT', 'HDOIT', v_branch_id, 0, 290) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1633', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 290, 290, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 290, 'Migration: ' || 'MIG-NO-REC-1633', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1634', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1634', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-LTR' OR product_name = 'NIPPON CLEAR GLOSS VARNISH LITER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'NCGVARNISH-LTR', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1635', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1635', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1636', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 1000, 3000, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 1000, 'Migration: ' || 'MIG-NO-REC-1636', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1637', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1637', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1638', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1638', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1639', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1639', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1350) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1640', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1350, 1350, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1350, 'Migration: ' || 'MIG-NO-REC-1640', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1641', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1641', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1642', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2800, 700, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'MIG-NO-REC-1642', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1643', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 680, 340, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 680, 'Migration: ' || 'MIG-NO-REC-1643', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901R-1L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK W/H REPACK') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'MEG3901R-1L', v_branch_id, 0, 320) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1644', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 320, 80, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 320, 'Migration: ' || 'MIG-NO-REC-1644', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1645', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1645', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1646', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1646', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1647', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-1647', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 60) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1648', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 60, 300, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 60, 'Migration: ' || 'MIG-NO-REC-1648', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 41.66666667) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1649', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 41.66666667, 125, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 41.66666667, 'Migration: ' || 'MIG-NO-REC-1649', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1650', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1650', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-01'::date, 'MIG-NO-REC-1651', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 675, 2700, NULL, 'System Migration', '2026-08-01'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 675, 'Migration: ' || 'MIG-NO-REC-1651', '2026-08-01'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGLD-705' OR product_name = 'PYLOX LAZER GOLD 705') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER GOLD 705', 'PLYZGLD-705', v_branch_id, 0, 185) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1652', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 185, 740, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 185, 'Migration: ' || 'MIG-NO-REC-1652', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1653', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 145, 290, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 145, 'Migration: ' || 'MIG-NO-REC-1653', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-1L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'LATEXMIX-1L', v_branch_id, 0, 245) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1654', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 245, 980, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 245, 'Migration: ' || 'MIG-NO-REC-1654', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1655', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1655', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1656', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1656', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2692.307692) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1657', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.13, 2692.307692, 350, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.13, 2692.307692, 'Migration: ' || 'MIG-NO-REC-1657', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1658', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1658', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1659', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1659', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-03'::date, 'MIG-NO-REC-1660', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1300, 650, NULL, 'System Migration', '2026-08-03'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1300, 'Migration: ' || 'MIG-NO-REC-1660', '2026-08-03'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1661', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 15, 85, 1275, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 15, 85, 'Migration: ' || 'MIG-NO-REC-1661', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1662', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1662', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1663', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1663', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1664', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1664', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1665', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1665', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1666', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2700, 1350, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2700, 'Migration: ' || 'MIG-NO-REC-1666', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1667', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1667', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1668', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1668', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1669', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1669', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1670', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1670', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1671', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1671', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1672', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1672', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1673', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 750, 1125, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 750, 'Migration: ' || 'MIG-NO-REC-1673', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1674', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1674', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1675', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1675', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1676', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1676', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-04'::date, 'MIG-NO-REC-1677', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-08-04'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1677', '2026-08-04'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 1900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1678', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 1900, 2850, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 1900, 'Migration: ' || 'MIG-NO-REC-1678', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1679', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 750, 4500, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 750, 'Migration: ' || 'MIG-NO-REC-1679', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1680', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 20, 35, 700, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 35, 'Migration: ' || 'MIG-NO-REC-1680', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1681', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1681', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1682', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1682', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1683', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1683', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1684', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'MIG-NO-REC-1684', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1685', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1685', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1686', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1686', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1687', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1687', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1688', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1688', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1689', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-1689', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1690', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1690', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1691', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-1691', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1692', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1692', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1693', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 35, 140, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 35, 'Migration: ' || 'MIG-NO-REC-1693', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1694', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1694', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1695', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1695', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1696', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1696', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1697', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1697', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1698', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'MIG-NO-REC-1698', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1699', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1550, 1550, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1550, 'Migration: ' || 'MIG-NO-REC-1699', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-05'::date, 'MIG-NO-REC-1700', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-05'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1700', '2026-08-05'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1701', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2.5, 750, 1875, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2.5, 750, 'Migration: ' || 'MIG-NO-REC-1701', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1702', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-1702', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 666.6666667) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1703', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 666.6666667, 1000, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 666.6666667, 'Migration: ' || 'MIG-NO-REC-1703', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1704', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1704', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1705', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 800, 800, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 800, 'Migration: ' || 'MIG-NO-REC-1705', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 1) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1706', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 700, 1, 700, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 700, 1, 'Migration: ' || 'MIG-NO-REC-1706', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1707', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2600, 2600, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2600, 'Migration: ' || 'MIG-NO-REC-1707', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1708', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 3000, 750, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 3000, 'Migration: ' || 'MIG-NO-REC-1708', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1709', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-1709', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1710', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1200, 1200, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1200, 'Migration: ' || 'MIG-NO-REC-1710', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1711', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1711', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1712', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1712', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1713', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1713', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1714', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-1714', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-06'::date, 'MIG-NO-REC-1715', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 85, 85, NULL, 'System Migration', '2026-08-06'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 85, 'Migration: ' || 'MIG-NO-REC-1715', '2026-08-06'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1716', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 700, 1400, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 700, 'Migration: ' || 'MIG-NO-REC-1716', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1717', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1717', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2880) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1718', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 2880, 720, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2880, 'Migration: ' || 'MIG-NO-REC-1718', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1719', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2900, 1450, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2900, 'Migration: ' || 'MIG-NO-REC-1719', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDRB-4L' OR product_name = 'PLATONE QDE ROYAL BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLQDRB-4L', v_branch_id, 0, 930) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1720', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 930, 930, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 930, 'Migration: ' || 'MIG-NO-REC-1720', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'VSEAL' OR product_name = 'VULCASEAL') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('VULCASEAL', 'VSEAL', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1721', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1721', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1722', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1722', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1723', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-1723', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1724', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 600, 300, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 600, 'Migration: ' || 'MIG-NO-REC-1724', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1725', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 650, 1950, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 650, 'Migration: ' || 'MIG-NO-REC-1725', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1726', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 240, 480, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 240, 'Migration: ' || 'MIG-NO-REC-1726', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1727', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 720, 180, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 720, 'Migration: ' || 'MIG-NO-REC-1727', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1728', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-1728', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1729', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 800, 400, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 800, 'Migration: ' || 'MIG-NO-REC-1729', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1041.666667) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1730', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.12, 1041.666667, 125, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.12, 1041.666667, 'Migration: ' || 'MIG-NO-REC-1730', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1731', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1731', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1732', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1300, 1300, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1300, 'Migration: ' || 'MIG-NO-REC-1732', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1733', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 840, 420, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 840, 'Migration: ' || 'MIG-NO-REC-1733', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1734', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2000, 500, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2000, 'Migration: ' || 'MIG-NO-REC-1734', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1735', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1735', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1736', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1736', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1737', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1737', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-BLUE -OC-4L' OR product_name = 'RAIN OR SHINE-BLUE OCEAN-4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'ROS-BLUE -OC-4L', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-07'::date, 'MIG-NO-REC-1738', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 900, 900, NULL, 'System Migration', '2026-08-07'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 900, 'Migration: ' || 'MIG-NO-REC-1738', '2026-08-07'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1739', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1739', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1740', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1740', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1741', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1741', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1742', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1742', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1743', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 40, 80, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 40, 'Migration: ' || 'MIG-NO-REC-1743', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1744', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1744', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1745', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1745', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1746', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 780, 1560, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 780, 'Migration: ' || 'MIG-NO-REC-1746', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 580) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1747', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 580, 580, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 580, 'Migration: ' || 'MIG-NO-REC-1747', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1748', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1748', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1749', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1749', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-4L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'UTMIX-4L', v_branch_id, 0, 4400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1750', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 4400, 1100, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 4400, 'Migration: ' || 'MIG-NO-REC-1750', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1751', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1751', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1752', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 1400, 700, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1400, 'Migration: ' || 'MIG-NO-REC-1752', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1753', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 260, 260, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'MIG-NO-REC-1753', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1754', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1754', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1755', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 650, 1950, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 650, 'Migration: ' || 'MIG-NO-REC-1755', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-4L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'TOBF-4L', v_branch_id, 0, 790) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1756', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 790, 790, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 790, 'Migration: ' || 'MIG-NO-REC-1756', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1757', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1757', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1758', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-1758', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA80' OR product_name = 'SAND PAPER #80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('SAND PAPER #80', 'EA80', v_branch_id, 0, 40) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1759', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 40, 200, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 40, 'Migration: ' || 'MIG-NO-REC-1759', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1760', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 10, 25, 250, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 25, 'Migration: ' || 'MIG-NO-REC-1760', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1761', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1761', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1762', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1762', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1763', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 1400, 2800, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1400, 'Migration: ' || 'MIG-NO-REC-1763', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 145) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-08'::date, 'MIG-NO-REC-1764', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 145, 145, NULL, 'System Migration', '2026-08-08'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 145, 'Migration: ' || 'MIG-NO-REC-1764', '2026-08-08'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1765', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1765', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-1L' OR product_name = 'NAX NAT-1OO TTC WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-1OO TTC WHITE 1L', 'NAT100-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1766', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 1000, 1000, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1000, 'Migration: ' || 'MIG-NO-REC-1766', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1767', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1767', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1768', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1768', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1769', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 640, 640, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 640, 'Migration: ' || 'MIG-NO-REC-1769', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1770', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1200, 300, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1200, 'Migration: ' || 'MIG-NO-REC-1770', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1771', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1771', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1772', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1772', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1773', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1773', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1774', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1774', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUTTYKNI #6' OR product_name = 'JAPAN PUTTY KNIFE #6') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('JAPAN PUTTY KNIFE #6', 'PUTTYKNI #6', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1775', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1775', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-10'::date, 'MIG-NO-REC-1776', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-10'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1776', '2026-08-10'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1777', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1000, 500, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1000, 'Migration: ' || 'MIG-NO-REC-1777', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 230) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1778', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 230, 230, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 230, 'Migration: ' || 'MIG-NO-REC-1778', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1779', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1779', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1780', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1780', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1781', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1781', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT1/2' OR product_name = 'CROCO MASKING TAPE 1/2 12MM (1X96)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'CRO-MT1/2', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1782', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1782', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1783', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 720, 360, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 720, 'Migration: ' || 'MIG-NO-REC-1783', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1784', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1784', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2833.333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1785', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.12, 2833.333333, 340, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.12, 2833.333333, 'Migration: ' || 'MIG-NO-REC-1785', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1786', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 130, 390, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 130, 'Migration: ' || 'MIG-NO-REC-1786', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZPRGR-145' OR product_name = 'PYLOX LAZER PRIMER GRAY 145') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER PRIMER GRAY 145', 'PLYZPRGR-145', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1787', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 130, 390, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 130, 'Migration: ' || 'MIG-NO-REC-1787', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTW-03' OR product_name = 'PYLOX LAZER MATT WHITE 03') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER MATT WHITE 03', 'PLYZMTW-03', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1788', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 130, 520, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 130, 'Migration: ' || 'MIG-NO-REC-1788', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB#1' OR product_name = 'PAINT BRUSH 2B #1') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT BRUSH 2B #1', '2B-PB#1', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1789', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1789', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1790', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1790', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1791', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 260, 260, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 260, 'Migration: ' || 'MIG-NO-REC-1791', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1792', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1792', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1793', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 590, 590, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 590, 'Migration: ' || 'MIG-NO-REC-1793', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1794', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 750, 750, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 750, 'Migration: ' || 'MIG-NO-REC-1794', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1795', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 2000, 1000, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2000, 'Migration: ' || 'MIG-NO-REC-1795', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1796', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 250, 500, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 250, 'Migration: ' || 'MIG-NO-REC-1796', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UTMIX-1L' OR product_name = 'URETHANE MIXING POLYGLOSS, DO IT 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'UTMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1797', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.5, 700, 350, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 700, 'Migration: ' || 'MIG-NO-REC-1797', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 690) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1798', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 690, 690, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 690, 'Migration: ' || 'MIG-NO-REC-1798', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1799', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 8, 25, 200, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 8, 25, 'Migration: ' || 'MIG-NO-REC-1799', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1800', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 2400, 2400, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 2400, 'Migration: ' || 'MIG-NO-REC-1800', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX10100' OR product_name = 'NAX NAT-10100 NH-585 PEARL WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'NAX10100', v_branch_id, 0, 1400) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1801', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 1400, 2800, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1400, 'Migration: ' || 'MIG-NO-REC-1801', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1802', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'MIG-NO-REC-1802', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1803', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 20, 25, 500, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 20, 25, 'Migration: ' || 'MIG-NO-REC-1803', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1804', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 4, 260, 1040, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 260, 'Migration: ' || 'MIG-NO-REC-1804', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1805', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 260, 520, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 260, 'Migration: ' || 'MIG-NO-REC-1805', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1806', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1806', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1807', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1807', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#4' OR product_name = '2B PAINT ROLLER #4') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #4', '2B-#4', v_branch_id, 0, 65) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1808', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 65, 65, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 65, 'Migration: ' || 'MIG-NO-REC-1808', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1809', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1809', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1810', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1810', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1811', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1811', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1812', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 35, 175, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 35, 'Migration: ' || 'MIG-NO-REC-1812', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1813', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 5, 25, 125, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 25, 'Migration: ' || 'MIG-NO-REC-1813', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1814', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.25, 2800, 700, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2800, 'Migration: ' || 'MIG-NO-REC-1814', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1815', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1815', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1816', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1816', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTW-03' OR product_name = 'PYLOX LAZER MATT WHITE 03') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER MATT WHITE 03', 'PLYZMTW-03', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1817', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 130, 650, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 130, 'Migration: ' || 'MIG-NO-REC-1817', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGVARNISH-LTR' OR product_name = 'NIPPON CLEAR GLOSS VARNISH LITER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'NCGVARNISH-LTR', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1818', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 650, 650, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 650, 'Migration: ' || 'MIG-NO-REC-1818', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-11'::date, 'MIG-NO-REC-1819', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-11'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1819', '2026-08-11'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 850) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1820', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 850, 1700, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 850, 'Migration: ' || 'MIG-NO-REC-1820', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-4L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'DOMBF-4L', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1821', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1821', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1822', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 80, 160, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 80, 'Migration: ' || 'MIG-NO-REC-1822', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1823', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.1, 1000, 100, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.1, 1000, 'Migration: ' || 'MIG-NO-REC-1823', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1824', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 760, 190, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 760, 'Migration: ' || 'MIG-NO-REC-1824', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 833.3333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1825', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.12, 833.3333333, 100, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.12, 833.3333333, 'Migration: ' || 'MIG-NO-REC-1825', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1826', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1826', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1827', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1000, 250, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1000, 'Migration: ' || 'MIG-NO-REC-1827', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 1333.333333) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1828', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.06, 1333.333333, 80, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.06, 1333.333333, 'Migration: ' || 'MIG-NO-REC-1828', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TLWAX' OR product_name = 'TIMELESS PREMIUM LIQUID WAX 5OML') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'TLWAX', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1829', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1829', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1520) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1830', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 1520, 380, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 1520, 'Migration: ' || 'MIG-NO-REC-1830', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1831', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'MIG-NO-REC-1831', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZDR-17' OR product_name = 'PYLOX LAZER DEEP RED 17') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER DEEP RED 17', 'PLYZDR-17', v_branch_id, 0, 140) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1832', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 140, 280, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 140, 'Migration: ' || 'MIG-NO-REC-1832', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1833', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1833', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1834', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1834', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1835', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1835', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1500' OR product_name = 'EAGLE SANDPAPER #1500') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1500', 'EA1500', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1836', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1836', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1000' OR product_name = 'EAGLE SANDPAPER #1000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1000', 'EA1000', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-12'::date, 'MIG-NO-REC-1837', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-12'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1837', '2026-08-12'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1838', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1838', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1839', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1839', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1840', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1840', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CUMIFS-80' OR product_name = 'CUMI SUPREME FLOOR SANDING 80') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CUMI SUPREME FLOOR SANDING 80', 'CUMIFS-80', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1841', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 5, 85, 425, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 85, 'Migration: ' || 'MIG-NO-REC-1841', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1842', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1842', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1843', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1843', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1844', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 780, 780, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 780, 'Migration: ' || 'MIG-NO-REC-1844', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZMTW-03' OR product_name = 'PYLOX LAZER MATT WHITE 03') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER MATT WHITE 03', 'PLYZMTW-03', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1845', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 130, 520, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 130, 'Migration: ' || 'MIG-NO-REC-1845', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZCLR-01' OR product_name = 'PYLOX LAZER CLEAR 01') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PYLOX LAZER CLEAR 01', 'PLYZCLR-01', v_branch_id, 0, 130) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1846', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 130, 260, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 130, 'Migration: ' || 'MIG-NO-REC-1846', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA320' OR product_name = 'EAGLE SAND PAPER #320') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SAND PAPER #320', 'EA320', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1847', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1847', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1848', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 1000, 3000, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 1000, 'Migration: ' || 'MIG-NO-REC-1848', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1450) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1849', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 1450, 2900, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 1450, 'Migration: ' || 'MIG-NO-REC-1849', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1850', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 600, 600, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 600, 'Migration: ' || 'MIG-NO-REC-1850', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1851', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 5, 700, 3500, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 5, 700, 'Migration: ' || 'MIG-NO-REC-1851', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1852', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 800, 1600, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 800, 'Migration: ' || 'MIG-NO-REC-1852', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOBF-1L' OR product_name = 'TIMEOUT BODY FILLER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'TOBF-1L', v_branch_id, 0, 240) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1853', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 240, 240, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 240, 'Migration: ' || 'MIG-NO-REC-1853', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1200) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1854', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1200, 600, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1200, 'Migration: ' || 'MIG-NO-REC-1854', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1855', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 1300, 650, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 1300, 'Migration: ' || 'MIG-NO-REC-1855', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1856', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 10, 35, 350, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 10, 35, 'Migration: ' || 'MIG-NO-REC-1856', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1857', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 100, 200, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 100, 'Migration: ' || 'MIG-NO-REC-1857', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1858', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 25, 50, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 25, 'Migration: ' || 'MIG-NO-REC-1858', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA800' OR product_name = 'EAGLE SANDPAPER #800') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #800', 'EA800', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1859', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 25, 75, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 25, 'Migration: ' || 'MIG-NO-REC-1859', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA1200' OR product_name = 'EAGLE SANDPAPER #1200') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #1200', 'EA1200', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1860', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 25, 25, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 25, 'Migration: ' || 'MIG-NO-REC-1860', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA2000' OR product_name = 'EAGLE SANDPAPER #2000') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #2000', 'EA2000', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1861', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 3, 35, 105, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 3, 35, 'Migration: ' || 'MIG-NO-REC-1861', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1862', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1862', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'LATEXMIX-4L' OR product_name = 'LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'LATEXMIX-4L', v_branch_id, 0, 980) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1863', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 980, 1960, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 980, 'Migration: ' || 'MIG-NO-REC-1863', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-#7' OR product_name = '2B PAINT ROLLER #7') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT ROLLER #7', '2B-#7', v_branch_id, 0, 85) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1864', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 85, 170, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 85, 'Migration: ' || 'MIG-NO-REC-1864', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TRAY' OR product_name = 'PAINT ROLLER TRAY') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PAINT ROLLER TRAY', 'TRAY', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1865', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 2, 80, 160, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 80, 'Migration: ' || 'MIG-NO-REC-1865', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1866', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 2800, 1400, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2800, 'Migration: ' || 'MIG-NO-REC-1866', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1867', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 2, 680, 1360, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 680, 'Migration: ' || 'MIG-NO-REC-1867', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAXQDUMIX-1L' OR product_name = 'NAX QDU MIX 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX QDU MIX 1L', 'NAXQDUMIX-1L', v_branch_id, 0, 1600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-13'::date, 'MIG-NO-REC-1868', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 1600, 1600, NULL, 'System Migration', '2026-08-13'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1600, 'Migration: ' || 'MIG-NO-REC-1868', '2026-08-13'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1869', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 0.5, 2600, 1300, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 2600, 'Migration: ' || 'MIG-NO-REC-1869', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PREMILAMIX-1L' OR product_name = 'PREMILA MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('PREMILA MIXING 1L', 'PREMILAMIX-1L', v_branch_id, 0, 2600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1870', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 2600, 650, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 2600, 'Migration: ' || 'MIG-NO-REC-1870', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'CRO-MT3/4' OR product_name = 'CROCO MASKING TAPE 3/4 18MM (1X64)') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'CRO-MT3/4', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1871', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 35, 70, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 35, 'Migration: ' || 'MIG-NO-REC-1871', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MSC' OR product_name = 'OLD NEWS') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('OLD NEWS', 'MSC', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1872', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1872', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 800) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1873', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 800, 200, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 800, 'Migration: ' || 'MIG-NO-REC-1873', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'GIPREMOVER-BOT' OR product_name = 'GI PAINT REMOVER BOTTLE') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GI PAINT REMOVER BOTTLE', 'GIPREMOVER-BOT', v_branch_id, 0, 100) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1874', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 100, 100, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 100, 'Migration: ' || 'MIG-NO-REC-1874', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1875', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 750, 1500, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 750, 'Migration: ' || 'MIG-NO-REC-1875', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 590) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1876', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 2, 590, 1180, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 2, 590, 'Migration: ' || 'MIG-NO-REC-1876', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EXTREMEMIX-1L' OR product_name = 'EXTREME QDU MIXING 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EXTREME QDU MIXING 1L', 'EXTREMEMIX-1L', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1877', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1.5, 700, 1050, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1.5, 700, 'Migration: ' || 'MIG-NO-REC-1877', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 680) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1878', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 680, 680, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 680, 'Migration: ' || 'MIG-NO-REC-1878', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 250) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1879', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 1, 250, 250, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 250, 'Migration: ' || 'MIG-NO-REC-1879', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA120' OR product_name = 'EAGLE SANDPAPER #120') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #120', 'EA120', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1880', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1880', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA400' OR product_name = 'EAGLE SANDPAPER #400') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #400', 'EA400', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1881', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1881', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 600) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1882', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 600, 150, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 600, 'Migration: ' || 'MIG-NO-REC-1882', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1883', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 750, 150, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 750, 'Migration: ' || 'MIG-NO-REC-1883', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB757' OR product_name = 'NAX SOB757 HIGH GRADE URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'SOB757', v_branch_id, 0, 750) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1884', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.2, 750, 150, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.2, 750, 'Migration: ' || 'MIG-NO-REC-1884', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1885', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 0.25, 640, 160, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.25, 640, 'Migration: ' || 'MIG-NO-REC-1885', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA600' OR product_name = 'EAGLE SANDPAPER #600') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #600', 'EA600', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1886', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 6, 25, 150, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 6, 25, 'Migration: ' || 'MIG-NO-REC-1886', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EA240' OR product_name = 'EAGLE SANDPAPER #240') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('EAGLE SANDPAPER #240', 'EA240', v_branch_id, 0, 25) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-14'::date, 'MIG-NO-REC-1887', 'CASH CUSTOMER', 'Cash', v_branch_id, v_item_id, 4, 25, 100, NULL, 'System Migration', '2026-08-14'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 4, 25, 'Migration: ' || 'MIG-NO-REC-1887', '2026-08-14'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'AEMIX-4L' OR product_name = 'GLAZER AUTO ENAMEL MIX 4L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'AEMIX-4L', v_branch_id, 0, 1300) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1888', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 1300, 1300, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 1300, 'Migration: ' || 'MIG-NO-REC-1888', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1889', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 280, 280, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 280, 'Migration: ' || 'MIG-NO-REC-1889', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1890', 'CASH CUSTOMER', 'Charge', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1890', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 260) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1891', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 260, 130, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 260, 'Migration: ' || 'MIG-NO-REC-1891', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QDEMIX-1L' OR product_name = 'QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'QDEMIX-1L', v_branch_id, 0, 280) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1892', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 0.5, 280, 140, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 0.5, 280, 'Migration: ' || 'MIG-NO-REC-1892', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-1 1/2' OR product_name = '2B PAINT BRUSH 1 1/2') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('2B PAINT BRUSH 1 1/2', '2B-PB-1 1/2', v_branch_id, 0, 35) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1893', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 35, 35, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 35, 'Migration: ' || 'MIG-NO-REC-1893', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 80) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1894', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 80, 80, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 80, 'Migration: ' || 'MIG-NO-REC-1894', '2026-08-15'::timestamp);

    SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
    IF v_item_id IS NULL THEN
      INSERT INTO public.inventory (product_name, sku, branch_id, quantity, price) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 700) RETURNING id INTO v_item_id;
    END IF;

    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, color_code, performed_by, created_at)
    VALUES ('2026-08-15'::date, 'MIG-NO-REC-1895', 'CASH CUSTOMER', 'GCash', v_branch_id, v_item_id, 1, 700, 700, NULL, 'System Migration', '2026-08-15'::timestamp);

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
    VALUES (v_item_id, v_branch_id, 'OUT', 1, 700, 'Migration: ' || 'MIG-NO-REC-1895', '2026-08-15'::timestamp);
  END;
END $$;
