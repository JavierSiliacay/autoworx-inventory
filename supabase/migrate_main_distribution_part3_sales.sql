-- ============================================================================
-- MAIN DISTRIBUTION MIGRATION - PART 3 of 4: HISTORICAL SALES
-- ============================================================================

DO $$
DECLARE
  v_main_branch_id UUID;
  v_inv_id UUID;
BEGIN
  SELECT id INTO v_main_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-13', '2026-06-13'::timestamp, 'CSI-004306', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 24, 725, 17400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 725, 17400, 'Sale: CSI-004306', '2026-06-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-13', '2026-06-13'::timestamp, 'CSI-004306', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 3, 2300, 6900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 2300, 6900, 'Sale: CSI-004306', '2026-06-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-13', '2026-06-13'::timestamp, 'CSI-004306', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 2, 3000, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3000, 6000, 'Sale: CSI-004306', '2026-06-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-15', '2026-06-15'::timestamp, 'CSI-004307', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 30, 730, 21900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 730, 21900, 'Sale: CSI-004307', '2026-06-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-15', '2026-06-15'::timestamp, 'CSI-004307', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 6, 860, 5160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 860, 5160, 'Sale: CSI-004307', '2026-06-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2850, 2850, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2850, 2850, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2550, 2550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2550, 2550, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 6000, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 6000, 6000, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2500, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2500, 2500, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3500, 3500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3500, 3500, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 4000, 4000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 4000, 4000, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2300, 2300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2300, 2300, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004308', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 4, 2600, 10400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2600, 10400, 'Sale: CSI-004308', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-16', '2026-06-16'::timestamp, 'CSI-004309', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 60, 65, 3900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 65, 3900, 'Sale: CSI-004309', '2026-06-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-18', '2026-06-18'::timestamp, 'CSI-004310', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 48, 240, 11520, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 240, 11520, 'Sale: CSI-004310', '2026-06-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-18', '2026-06-18'::timestamp, 'CSI-004310', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 48, 195, 9360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 195, 9360, 'Sale: CSI-004310', '2026-06-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 450, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 450, 21600, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 570, 4560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 570, 4560, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 635, 5080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 635, 5080, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1800, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1800, 14400, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 560, 13440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 560, 13440, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSMW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 730, 2920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 730, 2920, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 50, 65, 3250, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 50, 65, 3250, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 10, 780, 7800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 780, 7800, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1690, 3380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1690, 3380, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 940, 3760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 940, 3760, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 180, 4320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 180, 4320, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 730, 2920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 730, 2920, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 1240, 14880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1240, 14880, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVQDCG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1385', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 860, 3440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 860, 3440, 'Sale: DR-1385', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1640, 13120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1640, 13120, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1800, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1800, 14400, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 240, 225, 54000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 240, 225, 54000, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2010, 8040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2010, 8040, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 120, 560, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 560, 67200, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 3, 2705, 8115, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 2705, 8115, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 545, 2180, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 545, 2180, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 450, 27000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 450, 27000, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 570, 13680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 570, 13680, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 635, 12700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 635, 12700, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 400, 45, 18000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 400, 45, 18000, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITTH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 600, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 600, 14400, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1164' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 875, 10500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 875, 10500, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1383', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 5, 670, 3350, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 670, 3350, 'Sale: DR-1383', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1384', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1384', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1384', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 10, 1550, 15500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 1550, 15500, 'Sale: DR-1384', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-20', '2026-06-20'::timestamp, 'DR-1384', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 650, 7800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 650, 7800, 'Sale: DR-1384', '2026-06-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 40, 45, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 45, 1800, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPGLXWHT-16L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 2775, 5550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2775, 5550, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 465, 1860, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 465, 1860, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 300, 18.5, 5550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 18.5, 5550, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLLQWX-50ML' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 50, 65, 3250, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 50, 65, 3250, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 650, 3900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 650, 3900, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 95, 2280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 95, 2280, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RST-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 890, 3560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 890, 3560, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 740, 2960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 740, 2960, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 300, 600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 300, 600, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 3, 1550, 4650, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 1550, 4650, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPTRL-7' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1386', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 50, 65, 3250, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 50, 65, 3250, 'Sale: DR-1386', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 2010, 2010, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2010, 2010, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 2, 2280, 4560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2280, 4560, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 2, 2360, 4720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2360, 4720, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 2, 5240, 10480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 5240, 10480, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 12, 680, 8160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 680, 8160, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 6, 1100, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1100, 6600, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 36, 450, 16200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 450, 16200, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 8, 635, 5080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 635, 5080, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 200, 29, 5800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 29, 5800, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HS-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'DR-1387', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 575, 575, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 575, 575, 'Sale: DR-1387', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 5, 1570, 7850, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 1570, 7850, 'Sale: CSI-004311', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 8, 620, 4960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 620, 4960, 'Sale: CSI-004311', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-24', '2026-06-24'::timestamp, 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 27, 480, 12960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 27, 480, 12960, 'Sale: CSI-004311', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPSPGUN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-25', '2026-06-25'::timestamp, 'CSI-004313', 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD', 'Charge', v_main_branch_id, v_inv_id, 1, 13000, 13000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 13000, 13000, 'Sale: CSI-004313', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-25', '2026-06-25'::timestamp, 'CSI-004312', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 8, 720, 5760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 720, 5760, 'Sale: CSI-004312', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-25', '2026-06-25'::timestamp, 'CSI-004312', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 48, 500, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 500, 24000, 'Sale: CSI-004312', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-26', '2026-06-26'::timestamp, 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 24, 1500, 36000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 1500, 36000, 'Sale: CSI-004314', '2026-06-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-26', '2026-06-26'::timestamp, 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 24, 1350, 32400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 1350, 32400, 'Sale: CSI-004314', '2026-06-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-26', '2026-06-26'::timestamp, 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004314', '2026-06-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-27', '2026-06-27'::timestamp, 'CSI-15413', 'JAMES PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 12, 195, 2340, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 195, 2340, 'Sale: CSI-15413', '2026-06-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-27', '2026-06-27'::timestamp, 'CSI-15413', 'JAMES PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 4, 620, 2480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 620, 2480, 'Sale: CSI-15413', '2026-06-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 25, 650, 16250, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 25, 650, 16250, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 29, 14500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 29, 14500, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 120, 560, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 560, 67200, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 840, 30240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 840, 30240, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1640, 19680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1640, 19680, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1640, 19680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1640, 19680, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 30, 800, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 800, 24000, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1050, 6300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1050, 6300, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1280, 5120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1280, 5120, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 5, 1550, 7750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 1550, 7750, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1388', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 180, 4320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 180, 4320, 'Sale: DR-1388', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1389', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1389', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1389', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1389', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1389', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 745, 4470, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 745, 4470, 'Sale: DR-1389', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1389', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3750, 15000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3750, 15000, 'Sale: DR-1389', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'DR-1389', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 560, 20160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 560, 20160, 'Sale: DR-1389', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1532P-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'CSI-15430', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 4, 2521, 10084, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2521, 10084, 'Sale: CSI-15430', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2099A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'CSI-15430', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 2, 3118.5, 6237, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3118.5, 6237, 'Sale: CSI-15430', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2123A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'CSI-15430', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 3, 2821.5, 8464.5, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 2821.5, 8464.5, 'Sale: CSI-15430', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '145(N1)-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-06-29', '2026-06-29'::timestamp, 'CSI-15430', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 1, 2310.33, 2310.33, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2310.33, 2310.33, 'Sale: CSI-15430', '2026-06-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CANCELLED' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-0043817', 'CANCELLED', 'Cash', v_main_branch_id, v_inv_id, 0, 0, 0, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 0, 'Sale: CSI-0043817', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004318', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 2, 821.43, 1642.86, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 821.43, 1642.86, 'Sale: CSI-004318', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZWH-02' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004319', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 10, 89.29, 892.9, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 89.29, 892.9, 'Sale: CSI-004319', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004320', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 1, 866.07, 866.07, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 866.07, 866.07, 'Sale: CSI-004320', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004320', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 1, 669.64, 669.64, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 669.64, 669.64, 'Sale: CSI-004320', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVGLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004321', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 803.57, 48214.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 803.57, 48214.2, 'Sale: CSI-004321', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004321', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 72, 607.14, 43714.08, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 72, 607.14, 43714.08, 'Sale: CSI-004321', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BSTP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004321', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 18, 589.29, 10607.22, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 589.29, 10607.22, 'Sale: CSI-004321', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI--004404', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 8, 138.39, 1107.12, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 138.39, 1107.12, 'Sale: CSI--004404', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 740, 2960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 740, 2960, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 95, 1140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 95, 1140, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOIT-CAT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 240, 2880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 240, 2880, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 29, 2900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 29, 2900, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAS535' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1390', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, -3, 490, -1470, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', -3, 490, -1470, 'Sale: DR-1390', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1391', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 29, 5800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 29, 5800, 'Sale: DR-1391', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1391', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1391', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'DR-1391', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 740, 2960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 740, 2960, 'Sale: DR-1391', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-02', '2026-07-02'::timestamp, 'CSI-004323', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 18, 730, 13140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 730, 13140, 'Sale: CSI-004323', '2026-07-02'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-02', '2026-07-02'::timestamp, 'CSI-004323', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 36, 630, 22680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 630, 22680, 'Sale: CSI-004323', '2026-07-02'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-02', '2026-07-02'::timestamp, 'CSI-004324', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 2, 1850, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1850, 3700, 'Sale: CSI-004324', '2026-07-02'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-02', '2026-07-02'::timestamp, 'CSI-004324', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 6, 730, 4380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 730, 4380, 'Sale: CSI-004324', '2026-07-02'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 450, 10800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 450, 10800, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 180, 2160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 180, 2160, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 800, 4800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 800, 4800, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 670, 4020, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 670, 4020, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 195, 2340, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 195, 2340, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HIPROF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 695, 1390, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 695, 1390, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 40, 45, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 45, 1800, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 16, 635, 10160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 635, 10160, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEPENTHGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1200, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1200, 9600, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 560, 13440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 560, 13440, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'DR-1392', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1640, 3280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1640, 3280, 'Sale: DR-1392', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 11, 1150, 12650, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 11, 1150, 12650, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 4, 620, 2480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 620, 2480, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 1, 6000, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 6000, 6000, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 730, 8760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 730, 8760, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT068' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 1, 7200, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 7200, 7200, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ADD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004315', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 0, 0, 400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 400, 'Sale: CSI-004315', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB745' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004316', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 6, 750, 4500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 750, 4500, 'Sale: CSI-004316', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004316', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 6, 800, 4800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 800, 4800, 'Sale: CSI-004316', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004325', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 48, 195, 9360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 195, 9360, 'Sale: CSI-004325', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004325', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 24, 630, 15120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 630, 15120, 'Sale: CSI-004325', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-03', '2026-07-03'::timestamp, 'CSI-004325', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004325', '2026-07-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 11, 940, 10340, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 11, 940, 10340, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 120, 1440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 120, 1440, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT172' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3320, 13280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3320, 13280, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1425, 8550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1425, 8550, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1135, 6810, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1135, 6810, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT3974' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 590, 7080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 590, 7080, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 635, 12700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 635, 12700, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 190, 6840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 190, 6840, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 570, 13680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 570, 13680, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 10, 1550, 15500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 1550, 15500, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1640, 19680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1640, 19680, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1640, 19680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1640, 19680, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1800, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1800, 21600, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1393', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 560, 33600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 560, 33600, 'Sale: DR-1393', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TRAY' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1394', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 50, 1000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 50, 1000, 'Sale: DR-1394', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGAB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1394', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 295, 3540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 295, 3540, 'Sale: DR-1394', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGTB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1394', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 300, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 300, 3600, 'Sale: DR-1394', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGDB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1394', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 294, 3528, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 294, 3528, 'Sale: DR-1394', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGPB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-06', '2026-07-06'::timestamp, 'DR-1394', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 315, 3780, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 315, 3780, 'Sale: DR-1394', '2026-07-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1K145W-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-08', '2026-07-08'::timestamp, 'CSI-15573', 'KARLA', 'Cash', v_main_branch_id, v_inv_id, 1, 4200, 4200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 4200, 4200, 'Sale: CSI-15573', '2026-07-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1K1602T-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-08', '2026-07-08'::timestamp, 'CSI-15573', 'KARLA', 'Cash', v_main_branch_id, v_inv_id, 3, 3800, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 3800, 11400, 'Sale: CSI-15573', '2026-07-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-08', '2026-07-08'::timestamp, 'CSI-15573', 'KARLA', 'Cash', v_main_branch_id, v_inv_id, 6, 1200, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1200, 7200, 'Sale: CSI-15573', '2026-07-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-08', '2026-07-08'::timestamp, 'CSI-15573', 'KARLA', 'Cash', v_main_branch_id, v_inv_id, 2, 900, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 900, 1800, 'Sale: CSI-15573', '2026-07-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004326', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 10, 860, 8600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 860, 8600, 'Sale: CSI-004326', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 590, 3540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 590, 3540, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 955, 3820, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 955, 3820, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 5, 300, 1400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 300, 1400, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 955, 7640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 955, 7640, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 850, 1700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 850, 1700, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 773, 1546, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 773, 1546, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1640, 6560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1640, 6560, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1640, 6560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1640, 6560, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT147' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 1405, 16860, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1405, 16860, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'DR-1395', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 0, 7640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 0, 7640, 'Sale: DR-1395', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SR-913' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004327', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 866.07, 17321.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 866.07, 17321.4, 'Sale: CSI-004327', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004328', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 892.86, 53571.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 892.86, 53571.6, 'Sale: CSI-004328', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004329', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 642.86, 25714.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 642.86, 25714.4, 'Sale: CSI-004329', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004329', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 607.14, 36428.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 607.14, 36428.4, 'Sale: CSI-004329', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004330', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 8, 892.86, 7142.88, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 892.86, 7142.88, 'Sale: CSI-004330', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004332', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 12, 741.07, 8892.84, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 741.07, 8892.84, 'Sale: CSI-004332', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004333', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 803.57, 48214.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 803.57, 48214.2, 'Sale: CSI-004333', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CANCELLED' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-09', '2026-07-09'::timestamp, 'CSI-004331', 'CANCELLED', 'Cash', v_main_branch_id, v_inv_id, 0, 0, 0, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 0, 'Sale: CSI-004331', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1532P-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'CSI-15611', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 4, 2521.2, 10084.8, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2521.2, 10084.8, 'Sale: CSI-15611', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2099A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'CSI-15611', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 2, 3118.5, 6237, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3118.5, 6237, 'Sale: CSI-15611', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2123A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'CSI-15611', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 3, 2821.5, 8464.5, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 2821.5, 8464.5, 'Sale: CSI-15611', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '145(N1)-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'CSI-15611', 'JOEM TADURA', 'Cash', v_main_branch_id, v_inv_id, 1, 2310.33, 2310.33, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2310.33, 2310.33, 'Sale: CSI-15611', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'DR-1396', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 120, 665, 79800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 665, 79800, 'Sale: DR-1396', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-11', '2026-07-11'::timestamp, 'DR-1396', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 18, 800, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 800, 14400, 'Sale: DR-1396', '2026-07-11'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'CSI-004334', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 8, 620, 4960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 620, 4960, 'Sale: CSI-004334', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 1280, 1280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1280, 1280, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 2360, 2360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2360, 2360, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 1850, 1850, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1850, 1850, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 3750, 3750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3750, 3750, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 1, 3250, 3250, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3250, 3250, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 18, 680, 12240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 680, 12240, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 2, 1550, 3100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1550, 3100, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA320' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 100, 22, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 22, 2200, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 100, 29, 2900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 29, 2900, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-13', '2026-07-13'::timestamp, 'DR-1397', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 12, 800, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 800, 9600, 'Sale: DR-1397', '2026-07-13'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'CSI-004335', 'J-ANN PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 4, 610, 2440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 610, 2440, 'Sale: CSI-004335', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'CSI-004335', 'J-ANN PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 6, 195, 1170, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 195, 1170, 'Sale: CSI-004335', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'CSI-004335', 'J-ANN PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 2, 600, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 600, 1200, 'Sale: CSI-004335', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'DR-1400', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 36, 600, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 600, 21600, 'Sale: DR-1400', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'DR-1400', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 2, 1850, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1850, 3700, 'Sale: DR-1400', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'DR-1400', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 2, 1850, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1850, 3700, 'Sale: DR-1400', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-14', '2026-07-14'::timestamp, 'DR-1400', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 12, 720, 8640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 720, 8640, 'Sale: DR-1400', '2026-07-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'CSI-004339', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 30, 730, 21900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 730, 21900, 'Sale: CSI-004339', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1905, 15240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1905, 15240, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1835, 14680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1835, 14680, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 1100, 26400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 1100, 26400, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 2280, 18240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2280, 18240, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 2705, 21640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2705, 21640, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 120, 560, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 560, 67200, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT3974' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 590, 7080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 590, 7080, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 5240, 10480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 5240, 10480, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 18, 750, 13500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 750, 13500, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 400, 22, 8800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 400, 22, 8800, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1398', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 745, 4470, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 745, 4470, 'Sale: DR-1398', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1399', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 200, 29, 5800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 29, 5800, 'Sale: DR-1399', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1399', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 200, 32, 6400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 32, 6400, 'Sale: DR-1399', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1399', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1800, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1800, 14400, 'Sale: DR-1399', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1399', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1399', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'DR-1399', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 400, 22, 8800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 400, 22, 8800, 'Sale: DR-1399', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'CSI-004340', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 16, 620, 9920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 620, 9920, 'Sale: CSI-004340', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'CSI-004340', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 8, 990, 7920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 990, 7920, 'Sale: CSI-004340', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'CSI-004340', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 8, 990, 7920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 990, 7920, 'Sale: CSI-004340', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPTRL-7' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-15', '2026-07-15'::timestamp, 'CSI-004340', 'ARKO ENTERPRISES', 'Charge', v_main_branch_id, v_inv_id, 50, 75, 3750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 50, 75, 3750, 'Sale: CSI-004340', '2026-07-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004341', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1400, 28000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1400, 28000, 'Sale: CSI-004341', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004341', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 1517.86, 60714.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 1517.86, 60714.4, 'Sale: CSI-004341', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004342', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 607.14, 36428.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 607.14, 36428.4, 'Sale: CSI-004342', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004343', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1517.86, 30357.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1517.86, 30357.2, 'Sale: CSI-004343', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004344', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 24, 892.86, 21428.64, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 892.86, 21428.64, 'Sale: CSI-004344', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1313' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004345', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 10, 1517.86, 15178.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 1517.86, 15178.6, 'Sale: CSI-004345', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRAW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004346', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 803.57, 16071.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 803.57, 16071.4, 'Sale: CSI-004346', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRSG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'CSI-004347', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 875, 35000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 875, 35000, 'Sale: CSI-004347', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'DR-1401', 'JONATHAN ASUNCION', 'Cash', v_main_branch_id, v_inv_id, 2, 2600, 5200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2600, 5200, 'Sale: DR-1401', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'DR-1401', 'JONATHAN ASUNCION', 'Cash', v_main_branch_id, v_inv_id, 1, 2300, 2300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2300, 2300, 'Sale: DR-1401', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-16', '2026-07-16'::timestamp, 'DR-1401', 'JONATHAN ASUNCION', 'Cash', v_main_branch_id, v_inv_id, 1, 650, 650, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 650, 650, 'Sale: DR-1401', '2026-07-16'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 730, 2920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 730, 2920, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBGWN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 730, 2920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 730, 2920, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 545, 6540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 545, 6540, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 1205, 14460, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1205, 14460, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SNDMSTER-36' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 10100, 10100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 10100, 10100, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 6800, 6800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 6800, 6800, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 5900, 5900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 5900, 5900, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 13, 1360, 17680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 13, 1360, 17680, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBREENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 47, 1360, 63920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 47, 1360, 63920, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 800, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 800, 9600, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 450, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 450, 21600, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1260, 5040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1260, 5040, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-17', '2026-07-17'::timestamp, 'DR-1402', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1402', '2026-07-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004336', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 2, 1600, 3200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1600, 3200, 'Sale: CSI-004336', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004336', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 24, 2600, 62400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 2600, 62400, 'Sale: CSI-004336', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004336', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 72, 600, 43200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 72, 600, 43200, 'Sale: CSI-004336', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004336', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 48, 500, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 500, 24000, 'Sale: CSI-004336', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004336', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 2, 2300, 4600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2300, 4600, 'Sale: CSI-004336', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004337', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 18, 725, 13050, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 725, 13050, 'Sale: CSI-004337', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004337', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 4, 2600, 10400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2600, 10400, 'Sale: CSI-004337', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 620, 7440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 620, 7440, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 24, 195, 4680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 195, 4680, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 18, 725, 13050, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 725, 13050, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 6, 135, 810, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 135, 810, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCRS-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 60, 720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 60, 720, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004338', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 50, 600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 50, 600, 'Sale: CSI-004338', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 36, 490, 17640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 490, 17640, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 18, 725, 13050, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 725, 13050, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 1, 1850, 1850, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1850, 1850, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 2, 1850, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1850, 3700, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 1, 2200, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2200, 2200, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'CSI-004348', 'NICE RIDE AUTO DETAILING', 'Charge', v_main_branch_id, v_inv_id, 4, 1350, 5400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1350, 5400, 'Sale: CSI-004348', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOIT-CAT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 240, 5760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 240, 5760, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1550, 6200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1550, 6200, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4197-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 2010, 2010, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2010, 2010, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1640, 13120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1640, 13120, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'XTRMEQDWARMYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1800, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1800, 3600, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4168-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2010, 8040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2010, 8040, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1640, 13120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1640, 13120, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1800, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1800, 3600, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 3, 1550, 4650, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 1550, 4650, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSIL-42' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 95, 1140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 95, 1140, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-18', '2026-07-18'::timestamp, 'DR-1403', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 750, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 750, 6000, 'Sale: DR-1403', '2026-07-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CANCELLED' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-01', '2026-07-01'::timestamp, 'CSI-004322', 'CANCELLED', 'Cash', v_main_branch_id, v_inv_id, 0, 0, 0, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 0, 'Sale: CSI-004322', '2026-07-01'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004405', 'XTRA PAINT CENTER & GEN. MDSE.', 'Charge', v_main_branch_id, v_inv_id, 24, 600, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 600, 14400, 'Sale: CSI-004405', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004405', 'XTRA PAINT CENTER & GEN. MDSE.', 'Charge', v_main_branch_id, v_inv_id, 6, 730, 4380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 730, 4380, 'Sale: CSI-004405', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004405', 'XTRA PAINT CENTER & GEN. MDSE.', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004405', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004405', 'XTRA PAINT CENTER & GEN. MDSE.', 'Charge', v_main_branch_id, v_inv_id, 12, 700, 8400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 700, 8400, 'Sale: CSI-004405', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004406', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 30, 730, 21900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 730, 21900, 'Sale: CSI-004406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CANCELLED' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004403', 'CANCELLED', 'Charge', v_main_branch_id, v_inv_id, 0, 0, 0, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 0, 'Sale: CSI-004403', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1905, 7620, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1905, 7620, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 7, 1835, 12845, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 7, 1835, 12845, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCNT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 740, 2960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 740, 2960, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSNP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 740, 1480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 740, 1480, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 650, 1300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 650, 1300, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 980, 11760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 980, 11760, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 40, 45, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 45, 1800, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-V' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1110, 2220, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1110, 2220, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 3, 690, 2070, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 690, 2070, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1406', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2705, 10820, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2705, 10820, 'Sale: DR-1406', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 16, 635, 10160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 635, 10160, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 25, 45, 1125, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 25, 45, 1125, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 120, 720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 120, 720, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 980, 11760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 980, 11760, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 2350, 14100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 2350, 14100, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1305' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1835, 11010, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1835, 11010, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT556' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 785, 9420, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 785, 9420, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1050, 6300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1050, 6300, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 545, 6540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 545, 6540, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 635, 7620, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 635, 7620, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 190, 6840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 190, 6840, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 16, 570, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 570, 9120, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1407', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 180, 6480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 180, 6480, 'Sale: DR-1407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3235, 12940, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3235, 12940, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1950, 7800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1950, 7800, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT320' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 570, 3420, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 570, 3420, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT149' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1625, 9750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1625, 9750, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1485, 8910, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1485, 8910, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PUTTYKNI #4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 15, 300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 15, 300, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'DR-1408', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 276, 552, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 276, 552, 'Sale: DR-1408', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 60, 600, 36000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 600, 36000, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 60, 500, 30000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 500, 30000, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3700, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3700, 3700, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2300, 2300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2300, 2300, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2850, 2850, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2850, 2850, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004349', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2550, 2550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2550, 2550, 'Sale: CSI-004349', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004350', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 620, 7440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 620, 7440, 'Sale: CSI-004350', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004350', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 100, 36, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 36, 3600, 'Sale: CSI-004350', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004350', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 200, 24.5, 4900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 24.5, 4900, 'Sale: CSI-004350', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004350', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 100, 24.5, 2450, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 24.5, 2450, 'Sale: CSI-004350', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004350', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 6, 860, 5160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 860, 5160, 'Sale: CSI-004350', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004401', 'ARIES PAINT AND GENERAL MDSE. CO', 'Charge', v_main_branch_id, v_inv_id, 120, 480, 57600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 480, 57600, 'Sale: CSI-004401', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004401', 'ARIES PAINT AND GENERAL MDSE. CO', 'Charge', v_main_branch_id, v_inv_id, 60, 480, 28800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 480, 28800, 'Sale: CSI-004401', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004401', 'ARIES PAINT AND GENERAL MDSE. CO', 'Charge', v_main_branch_id, v_inv_id, 100, 60, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 60, 6000, 'Sale: CSI-004401', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004402', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 12, 730, 8760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 730, 8760, 'Sale: CSI-004402', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 84, 990, 83160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 84, 990, 83160, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 552, 725, 400200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 552, 725, 400200, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 150, 725, 108750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 150, 725, 108750, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 60, 720, 43200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 720, 43200, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 6, 2100, 12600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 2100, 12600, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 2600, 31200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 2600, 31200, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 160, 620, 99200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 160, 620, 99200, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 180, 195, 35100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 180, 195, 35100, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 20, 1460, 29200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1460, 29200, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 1310, 15720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1310, 15720, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1983' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 16, 1500, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 1500, 24000, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACFRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 1480, 17760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1480, 17760, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1131' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 2, 2500, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2500, 5000, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1404', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 120, 480, 57600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 480, 57600, 'Sale: DR-1404', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1405', 'KIM BUILDERS', 'Cash', v_main_branch_id, v_inv_id, 12, 100, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 100, 1200, 'Sale: DR-1405', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZLTGR-33' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1405', 'KIM BUILDERS', 'Cash', v_main_branch_id, v_inv_id, 12, 100, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 100, 1200, 'Sale: DR-1405', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1405', 'KIM BUILDERS', 'Cash', v_main_branch_id, v_inv_id, 12, 100, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 100, 1200, 'Sale: DR-1405', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 190, 4560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 190, 4560, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 650, 2600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 650, 2600, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1950, 7800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1950, 7800, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCALORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 965, 3860, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 965, 3860, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSXG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 755, 3020, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 755, 3020, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 180, 2160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 180, 2160, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSKBL-22' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 95, 190, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 95, 190, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 95, 1140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 95, 1140, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 36, 680, 24480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 680, 24480, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'DR-1409', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1409', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004408', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 6000, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 6000, 6000, 'Sale: CSI-004408', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT307' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004408', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3600, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3600, 3600, 'Sale: CSI-004408', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-24', '2026-07-24'::timestamp, 'CSI-004408', 'MEGA PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3700, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3700, 3700, 'Sale: CSI-004408', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 30, 800, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 800, 24000, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXSRUB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 610, 12200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 610, 12200, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1950, 23400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1950, 23400, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUJTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 2060, 24720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 2060, 24720, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTC-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 530, 31800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 530, 31800, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTCPR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 4200, 16800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 4200, 16800, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PG888RED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 2750, 33000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 2750, 33000, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1960, 7840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1960, 7840, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3570, 14280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3570, 14280, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 1, 2120, 2120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2120, 2120, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3160, 12640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3160, 12640, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2350, 9400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2350, 9400, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGAPLRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 2730, 32760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 2730, 32760, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2120, 8480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2120, 8480, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGFLTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1410', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 2180, 26160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 2180, 26160, 'Sale: DR-1410', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGSPRKLIRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1970, 7880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1970, 7880, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 2760, 22080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2760, 22080, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3570, 14280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3570, 14280, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2730, 5460, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2730, 5460, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUSF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 470, 16920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 470, 16920, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 875, 10500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 875, 10500, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 800, 4800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 800, 4800, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 120, 560, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 560, 67200, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 3440, 27520, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 3440, 27520, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 3440, 6880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3440, 6880, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1905, 22860, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1905, 22860, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1411', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1411', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1412', 'APC AGORA_ISUZU', 'Charge', v_main_branch_id, v_inv_id, 12, 570, 6840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 570, 6840, 'Sale: DR-1412', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TGLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 535, 2140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 535, 2140, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 150, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 150, 1800, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSI-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 755, 3020, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 755, 3020, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPSGLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 770, 3080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 770, 3080, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 700, 2800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 700, 2800, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1100, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1100, 4400, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 885, 3540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 885, 3540, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 745, 1490, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 745, 1490, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 2120, 4240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2120, 4240, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 95, 1140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 95, 1140, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 650, 3900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 650, 3900, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TGLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-27', '2026-07-27'::timestamp, 'DR-1413', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 535, 535, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 535, 535, 'Sale: DR-1413', '2026-07-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 4, 2600, 10400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2600, 10400, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT025' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2300, 2300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2300, 2300, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT023' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2500, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2500, 2500, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3000, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3000, 3000, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2600, 2600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2600, 2600, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2200, 2200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2200, 2200, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3700, 3700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3700, 3700, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3100, 3100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3100, 3100, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 1400, 1400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1400, 1400, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-22', '2026-07-22'::timestamp, 'CSI-004407', 'KING V PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 6, 700, 4200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 700, 4200, 'Sale: CSI-004407', '2026-07-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-29', '2026-07-29'::timestamp, 'CSI-004410', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 36, 730, 26280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 730, 26280, 'Sale: CSI-004410', '2026-07-29'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-15916', '7J''S PAINT CENTER', 'Cash', v_main_branch_id, v_inv_id, 3, 600, 1800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 600, 1800, 'Sale: CSI-15916', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004411', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 892.86, 17857.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 892.86, 17857.2, 'Sale: CSI-004411', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004412', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 892.86, 17857.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 892.86, 17857.2, 'Sale: CSI-004412', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004412', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 36, 892.86, 32142.96, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 892.86, 32142.96, 'Sale: CSI-004412', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004413', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 4, 892.86, 3571.44, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 892.86, 3571.44, 'Sale: CSI-004413', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004414', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 2, 892.86, 1785.72, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 892.86, 1785.72, 'Sale: CSI-004414', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004415', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 133.93, 2678.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 133.93, 2678.6, 'Sale: CSI-004415', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004416', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 4, 892.86, 3571.44, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 892.86, 3571.44, 'Sale: CSI-004416', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004417', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 1, 705.36, 705.36, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 705.36, 705.36, 'Sale: CSI-004417', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EXTRAHRDENER-BIG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004418', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 295, 11800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 295, 11800, 'Sale: CSI-004418', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BSAXPRWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004418', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1308.04, 26160.8, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1308.04, 26160.8, 'Sale: CSI-004418', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004419', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 18, 730, 13140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 730, 13140, 'Sale: CSI-004419', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 33, 3300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 33, 3300, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-30', '2026-07-30'::timestamp, 'CSI-004409', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 20, 65, 1300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 65, 1300, 'Sale: CSI-004409', '2026-07-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 670, 5360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 670, 5360, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXQDBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 510, 2040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 510, 2040, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 590, 3540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 590, 3540, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 670, 4020, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 670, 4020, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 755, 6040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 755, 6040, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1120, 4480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1120, 4480, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 29, 2900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 29, 2900, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-07-31', '2026-07-31'::timestamp, 'DR-1414', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1020, 4080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1020, 4080, 'Sale: DR-1414', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-03', '2026-08-03'::timestamp, 'CSI-15970', 'KARLA', 'Cash', v_main_branch_id, v_inv_id, 2, 1200, 2400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1200, 2400, 'Sale: CSI-15970', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-03', '2026-08-03'::timestamp, 'CSI-004420', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 730, 8760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 730, 8760, 'Sale: CSI-004420', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004421', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 860, 10320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 860, 10320, 'Sale: CSI-004421', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004422', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 9, 892.86, 8035.74, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 9, 892.86, 8035.74, 'Sale: CSI-004422', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WEEW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004422', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 7, 1400, 9800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 7, 1400, 9800, 'Sale: CSI-004422', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WEEW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004423', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 1400, 56000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 1400, 56000, 'Sale: CSI-004423', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004424', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1517.86, 30357.2, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1517.86, 30357.2, 'Sale: CSI-004424', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBREEB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004425', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1294.64, 25892.8, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1294.64, 25892.8, 'Sale: CSI-004425', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WEEW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004425', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 1400, 84000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 1400, 84000, 'Sale: CSI-004425', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004426', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 48, 982.11, 47141.28, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 982.11, 47141.28, 'Sale: CSI-004426', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004426', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 669.64, 26785.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 669.64, 26785.6, 'Sale: CSI-004426', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004426', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 669.64, 26785.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 669.64, 26785.6, 'Sale: CSI-004426', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-05', '2026-08-05'::timestamp, 'CSI-004426', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 8, 75.89, 607.12, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 75.89, 607.12, 'Sale: CSI-004426', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004428', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 860, 10320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 860, 10320, 'Sale: CSI-004428', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004428', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 2, 1570, 3140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1570, 3140, 'Sale: CSI-004428', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004428', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 730, 8760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 730, 8760, 'Sale: CSI-004428', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004428', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2600, 2600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2600, 2600, 'Sale: CSI-004428', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 6150, 24600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 6150, 24600, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 2280, 18240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2280, 18240, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 72, 450, 32400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 72, 450, 32400, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 72, 450, 32400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 72, 450, 32400, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 20, 635, 12700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 635, 12700, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 400, 45, 18000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 400, 45, 18000, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1640, 13120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1640, 13120, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2010, 8040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2010, 8040, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSXG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 3, 690, 2070, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 690, 2070, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 750, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 750, 3000, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 850, 10200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 850, 10200, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1835, 14680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1835, 14680, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1416', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 560, 33600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 560, 33600, 'Sale: DR-1416', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBTCKCLTH' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 10, 50, 500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 50, 500, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGA-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 3210, 12840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3210, 12840, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 635, 7620, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 635, 7620, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBTCKCLTH' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 40, 50, 2000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 50, 2000, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2360, 9440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2360, 9440, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT023' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2200, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2200, 4400, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 200, 22, 4400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 22, 4400, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 300, 22, 6600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 300, 22, 6600, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2370, 4740, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2370, 4740, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBRSPGUN-F75' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 5, 750, 3750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 750, 3750, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'DR-1417', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 800, 6400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 800, 6400, 'Sale: DR-1417', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004429', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004429', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004429', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 18, 730, 13140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 730, 13140, 'Sale: CSI-004429', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004429', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 24, 600, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 600, 14400, 'Sale: CSI-004429', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-06', '2026-08-06'::timestamp, 'CSI-004429', 'SKYLINE PAINTS OPC', 'Charge', v_main_branch_id, v_inv_id, 2, 800, 1600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 800, 1600, 'Sale: CSI-004429', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'CSI-004430', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 30, 730, 21900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 730, 21900, 'Sale: CSI-004430', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 800, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 800, 9600, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 180, 2160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 180, 2160, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BBBRLR 4"' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 100, 40, 4000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 40, 4000, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 180, 4320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 180, 4320, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 5, 1900, 9500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 1900, 9500, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPDBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 5, 1880, 9400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 1880, 9400, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 108, 1350, 145800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 108, 1350, 145800, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 40, 1350, 54000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 1350, 54000, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCRB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 770, 3080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 770, 3080, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 750, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 750, 3000, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1418', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1418', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1305' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1419', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1835, 3670, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1835, 3670, 'Sale: DR-1419', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSNP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1419', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 750, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 750, 3000, 'Sale: DR-1419', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-07', '2026-08-07'::timestamp, 'DR-1419', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 60, 1100, 66000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 1100, 66000, 'Sale: DR-1419', '2026-08-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004427', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 100, 33, 3300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 33, 3300, 'Sale: CSI-004427', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004427', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 620, 7440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 620, 7440, 'Sale: CSI-004427', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004431', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 18, 730, 13140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 730, 13140, 'Sale: CSI-004431', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004431', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 24, 600, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 600, 14400, 'Sale: CSI-004431', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004431', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 36, 220, 7920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 220, 7920, 'Sale: CSI-004431', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'CSI-004431', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 20, 730, 14600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 730, 14600, 'Sale: CSI-004431', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'DR-1415', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 4, 3645, 14580, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3645, 14580, 'Sale: DR-1415', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'DR-1415', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 27, 490, 13230, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 27, 490, 13230, 'Sale: DR-1415', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'DR-1415', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 50, 75, 3750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 50, 75, 3750, 'Sale: DR-1415', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'DR-1420', 'YABO / EZV HARDWARE', 'Cash', v_main_branch_id, v_inv_id, 6, 190, 1140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 190, 1140, 'Sale: DR-1420', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-08', '2026-08-08'::timestamp, 'DR-1420', 'YABO / EZV HARDWARE', 'Cash', v_main_branch_id, v_inv_id, 12, 195, 2340, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 195, 2340, 'Sale: DR-1420', '2026-08-08'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'DR-1423', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 24, 720, 17280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 720, 17280, 'Sale: DR-1423', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'DR-1423', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 4, 730, 2920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 730, 2920, 'Sale: DR-1423', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'DR-1423', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 30, 720, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 720, 21600, 'Sale: DR-1423', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'DR-1423', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 6, 900, 5400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 900, 5400, 'Sale: DR-1423', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTC-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004441', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 24, 550, 13200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 550, 13200, 'Sale: CSI-004441', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004441', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 60, 500, 30000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 500, 30000, 'Sale: CSI-004441', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004441', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 200, 24.5, 4900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 24.5, 4900, 'Sale: CSI-004441', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004441', 'MATTEO PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 2, 1570, 3140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1570, 3140, 'Sale: CSI-004441', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004442', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 133.93, 2678.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 133.93, 2678.6, 'Sale: CSI-004442', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004442', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 8, 848.21, 6785.68, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 848.21, 6785.68, 'Sale: CSI-004442', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004443', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 36, 705.36, 25392.96, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 705.36, 25392.96, 'Sale: CSI-004443', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREPA-WHITE' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004444', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 4, 669.64, 2678.56, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 669.64, 2678.56, 'Sale: CSI-004444', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004444', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 4, 848.21, 3392.84, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 848.21, 3392.84, 'Sale: CSI-004444', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004444', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 2, 803.57, 1607.14, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 803.57, 1607.14, 'Sale: CSI-004444', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004445', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 60, 892.86, 53571.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 892.86, 53571.6, 'Sale: CSI-004445', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004445', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 7, 892.86, 6250.02, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 7, 892.86, 6250.02, 'Sale: CSI-004445', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004446', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 7, 1071.43, 7500.01, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 7, 1071.43, 7500.01, 'Sale: CSI-004446', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004447', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 892.86, 35714.4, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 892.86, 35714.4, 'Sale: CSI-004447', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-12', '2026-08-12'::timestamp, 'CSI-004448', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 6, 892.86, 5357.16, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 892.86, 5357.16, 'Sale: CSI-004448', '2026-08-12'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'CSI-004449', 'JJ PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 36, 700, 25200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 700, 25200, 'Sale: CSI-004449', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 8, 2600, 20800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2600, 20800, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 12, 730, 8760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 730, 8760, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 2, 3700, 7400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3700, 7400, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 2, 2700, 5400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2700, 5400, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 3, 1600, 4800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 3, 1600, 4800, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1424', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 8, 620, 4960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 620, 4960, 'Sale: DR-1424', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPSGLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 765, 3060, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 765, 3060, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1050, 2100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1050, 2100, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1905, 7620, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1905, 7620, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PG888RED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2750, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2750, 11000, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 1120, 6720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1120, 6720, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-14', '2026-08-14'::timestamp, 'DR-1425', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 60, 45, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 45, 2700, 'Sale: DR-1425', '2026-08-14'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 600, 3600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 600, 3600, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 450, 21600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 450, 21600, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 450, 5400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 450, 5400, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 200, 32, 6400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 32, 6400, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBRSPGUN-F75' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 730, 14600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 730, 14600, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 560, 26880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 560, 26880, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 450, 10800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 450, 10800, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SEALRMAX5170-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1150, 4600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1150, 4600, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1350, 5400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1350, 5400, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 220, 5280, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 220, 5280, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREPA-WHITE' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 620, 2480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 620, 2480, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 2150, 4300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2150, 4300, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGAPLRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1426', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 2750, 5500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2750, 5500, 'Sale: DR-1426', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 10, 1550, 15500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 1550, 15500, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 5, 396, 1980, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 396, 1980, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 1100, 39600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 1100, 39600, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2620, 10480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2620, 10480, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4168-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2010, 8040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2010, 8040, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 800, 19200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 800, 19200, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 980, 11760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 980, 11760, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 745, 8940, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 745, 8940, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 2705, 21640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2705, 21640, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 18, 840, 15120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 840, 15120, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 3250, 6500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3250, 6500, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 3750, 7500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3750, 7500, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2100, 4200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2100, 4200, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1427', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 3250, 6500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3250, 6500, 'Sale: DR-1427', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2360, 4720, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2360, 4720, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 120, 560, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 120, 560, 67200, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1800, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1800, 14400, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 850, 10200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 850, 10200, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1640, 6560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1640, 6560, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1640, 6560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1640, 6560, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT196' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1660, 6640, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1660, 6640, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-15', '2026-08-15'::timestamp, 'DR-1428', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 2280, 9120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2280, 9120, 'Sale: DR-1428', '2026-08-15'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 200, 1490, 298000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 1490, 298000, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 40, 1500, 60000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 1500, 60000, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 20, 1380, 27600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1380, 27600, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENINTRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 1380, 16560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1380, 16560, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 4, 3800, 15200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3800, 15200, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA4021' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 20, 1450, 29000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1450, 29000, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACLMNYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 20, 1400, 28000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1400, 28000, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 9, 1460, 13140, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 9, 1460, 13140, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACGLDTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 8, 1690, 13520, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1690, 13520, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 680, 8160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 680, 8160, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTHGR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 8, 1545, 12360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1545, 12360, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 60, 480, 28800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 480, 28800, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 1350, 16200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1350, 16200, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1421', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 4, 2900, 11600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2900, 11600, 'Sale: DR-1421', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1422', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 20, 2100, 42000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 2100, 42000, 'Sale: DR-1422', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1422', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 12, 3250, 39000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 3250, 39000, 'Sale: DR-1422', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'DR-1422', 'JAYFORD PAINTING SERVICES', 'Charge', v_main_branch_id, v_inv_id, 14, 2600, 36400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 14, 2600, 36400, 'Sale: DR-1422', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUYEL-600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 'Charge', v_main_branch_id, v_inv_id, 12, 160, 1920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 160, 1920, 'Sale: CSI-004432', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURANGE-601' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 'Charge', v_main_branch_id, v_inv_id, 28, 160, 4480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 28, 160, 4480, 'Sale: CSI-004432', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUPNK-603' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 'Charge', v_main_branch_id, v_inv_id, 36, 160, 5760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 160, 5760, 'Sale: CSI-004432', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURED-602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 'Charge', v_main_branch_id, v_inv_id, 36, 160, 5760, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 160, 5760, 'Sale: CSI-004432', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUVIO-604' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004432', 'JHOY JHING CONSTRUCTION SUPPLY', 'Charge', v_main_branch_id, v_inv_id, 10, 160, 1600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 10, 160, 1600, 'Sale: CSI-004432', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 18, 720, 12960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 720, 12960, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 840, 10080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 840, 10080, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 24, 600, 14400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 600, 14400, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 500, 6000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 500, 6000, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 1500, 18000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1500, 18000, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 12, 1350, 16200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1350, 16200, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ADD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004433', 'HENRY AUTO CARE', 'Charge', v_main_branch_id, v_inv_id, 0, 0, 1160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 0, 0, 1160, 'Sale: CSI-004433', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 24, 500, 12000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 500, 12000, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 1450, 1450, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1450, 1450, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2700, 2700, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2700, 2700, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGCAT-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 295, 3540, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 295, 3540, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 100, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 100, 1200, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZMTBLK-47' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 100, 1200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 100, 1200, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 1570, 1570, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1570, 1570, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2300, 2300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2300, 2300, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PG888RED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 2, 3250, 6500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 3250, 6500, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGAPLRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004434', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 3190, 3190, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 3190, 3190, 'Sale: CSI-004434', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004435', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 1, 2490, 2490, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2490, 2490, 'Sale: CSI-004435', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004435', 'REINCE PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 12, 620, 7440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 620, 7440, 'Sale: CSI-004435', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004436', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 60, 480, 28800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 480, 28800, 'Sale: CSI-004436', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004437', 'ZAMBOANGA COLOR COATING', 'Charge', v_main_branch_id, v_inv_id, 600, 550, 330000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 600, 550, 330000, 'Sale: CSI-004437', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004437', 'ZAMBOANGA COLOR COATING', 'Charge', v_main_branch_id, v_inv_id, 60, 650, 39000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 650, 39000, 'Sale: CSI-004437', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004438', 'CYB PAINT CENTER', 'Charge', v_main_branch_id, v_inv_id, 180, 600, 108000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 180, 600, 108000, 'Sale: CSI-004438', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 42, 730, 30660, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 42, 730, 30660, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 84, 610, 51240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 84, 610, 51240, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 8, 6000, 48000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 6000, 48000, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 8, 2300, 18400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 2300, 18400, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 7, 1450, 10150, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 7, 1450, 10150, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 2, 7000, 14000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 7000, 14000, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 30, 900, 27000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 900, 27000, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 60, 1350, 81000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 1350, 81000, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004439', 'TOMS PROFESSIONAL DETAILERS', 'Charge', v_main_branch_id, v_inv_id, 6, 1600, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1600, 9600, 'Sale: CSI-004439', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004440', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 60, 710, 42600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 710, 42600, 'Sale: CSI-004440', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004440', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 60, 600, 36000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 600, 36000, 'Sale: CSI-004440', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-17', '2026-08-17'::timestamp, 'CSI-004440', 'JAMS PAINT HAUZ', 'Charge', v_main_branch_id, v_inv_id, 24, 500, 12000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 500, 12000, 'Sale: CSI-004440', '2026-08-17'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-18', '2026-08-18'::timestamp, 'DR-1429', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 6, 1850, 11100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1850, 11100, 'Sale: DR-1429', '2026-08-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-18', '2026-08-18'::timestamp, 'DR-1429', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 6, 730, 4380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 730, 4380, 'Sale: DR-1429', '2026-08-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-18', '2026-08-18'::timestamp, 'DR-1429', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 12, 600, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 600, 7200, 'Sale: DR-1429', '2026-08-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-18', '2026-08-18'::timestamp, 'DR-1429', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 6, 500, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 500, 3000, 'Sale: DR-1429', '2026-08-18'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004450', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 75, 669.64, 50223, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 75, 669.64, 50223, 'Sale: CSI-004450', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004450', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 17, 669.64, 11383.88, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 17, 669.64, 11383.88, 'Sale: CSI-004450', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004551', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 12, 1400, 16800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1400, 16800, 'Sale: CSI-004551', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004552', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 40, 1294.64, 51785.6, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 40, 1294.64, 51785.6, 'Sale: CSI-004552', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004552', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 48, 1400, 67200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 1400, 67200, 'Sale: CSI-004552', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004552', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 12, 1400, 16800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1400, 16800, 'Sale: CSI-004552', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-19', '2026-08-19'::timestamp, 'CSI-004553', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 30, 730, 21900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 730, 21900, 'Sale: CSI-004553', '2026-08-19'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQWHTE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'CSI-004554', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 6, 1071.43, 6428.58, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1071.43, 6428.58, 'Sale: CSI-004554', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRSG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'CSI-004555', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 75, 875, 65625, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 75, 875, 65625, 'Sale: CSI-004555', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'CSI-004556', 'JDE PAINTACULAR TRADING CORP', 'Charge', v_main_branch_id, v_inv_id, 4, 3100, 12400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 3100, 12400, 'Sale: CSI-004556', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT595' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'CSI-004556', 'JDE PAINTACULAR TRADING CORP', 'Charge', v_main_branch_id, v_inv_id, 6, 700, 4200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 700, 4200, 'Sale: CSI-004556', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT158-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'CSI-004556', 'JDE PAINTACULAR TRADING CORP', 'Charge', v_main_branch_id, v_inv_id, 1, 1920, 1920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1920, 1920, 'Sale: CSI-004556', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 180, 4320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 180, 4320, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXQDBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 510, 2040, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 510, 2040, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXSRUB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 610, 2440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 610, 2440, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 1550, 1550, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1550, 1550, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1200, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1200, 9600, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 1050, 25200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 1050, 25200, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 8, 1120, 8960, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1120, 8960, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 800, 9600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 800, 9600, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXSRUB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 610, 2440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 610, 2440, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 750, 3000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 750, 3000, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1430', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 680, 4080, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 680, 4080, 'Sale: DR-1430', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 5240, 5240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 5240, 5240, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 180, 360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 180, 360, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUJTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2080, 8320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2080, 8320, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHBLU-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 2150, 8600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 2150, 8600, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 1800, 7200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1800, 7200, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 570, 11400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 570, 11400, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 745, 2980, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 745, 2980, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 20, 1120, 22400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1120, 22400, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 5, 396, 1980, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 396, 1980, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 180, 360, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 180, 360, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-20', '2026-08-20'::timestamp, 'DR-1431', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 1550, 3100, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 1550, 3100, 'Sale: DR-1431', '2026-08-20'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'CSI-004557', 'NHARDWARE', 'Charge', v_main_branch_id, v_inv_id, 20, 620, 12400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 620, 12400, 'Sale: CSI-004557', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 1135, 6810, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 1135, 6810, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 1205, 43380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 1205, 43380, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 18, 635, 11430, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 18, 635, 11430, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1905, 15240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1905, 15240, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 8, 1835, 14680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 8, 1835, 14680, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT3974' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 11, 590, 6490, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 11, 590, 6490, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 190, 6840, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 190, 6840, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 24, 570, 13680, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 570, 13680, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 36, 180, 6480, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 36, 180, 6480, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 16, 635, 10160, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 635, 10160, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 240, 225, 54000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 240, 225, 54000, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 450, 27000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 450, 27000, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 72, 560, 40320, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 72, 560, 40320, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1432', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 60, 680, 40800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 60, 680, 40800, 'Sale: DR-1432', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 5, 1550, 7750, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 5, 1550, 7750, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT728' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1355, 16260, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1355, 16260, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT147' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 12, 1405, 16860, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 1405, 16860, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 4, 1640, 6560, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 1640, 6560, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 2, 2370, 4740, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2370, 4740, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 100, 32, 3200, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 32, 3200, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 200, 28, 5600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 28, 5600, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 500, 22, 11000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 500, 22, 11000, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBRSPGUN-F75' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1433', 'APC KAUSWAGAN', 'Charge', v_main_branch_id, v_inv_id, 6, 730, 4380, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 730, 4380, 'Sale: DR-1433', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-C' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 535, 6420, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 535, 6420, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-B' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 390, 2340, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 390, 2340, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 2880, 2880, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 2880, 2880, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPABFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 1, 1785, 1785, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 1, 1785, 1785, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 30, 680, 20400, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 30, 680, 20400, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEENIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 980, 3920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 980, 3920, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 6, 650, 3900, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 6, 650, 3900, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPSGLXWHT-16L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 2, 2960, 5920, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2960, 5920, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TSGLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 485, 1940, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 485, 1940, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 24, 450, 10800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 450, 10800, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXQDBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 12, 510, 6120, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 12, 510, 6120, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 16, 890, 14240, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 16, 890, 14240, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEFB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 4, 860, 3440, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 4, 860, 3440, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPDBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 33, 1855, 61215, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 33, 1855, 61215, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-25', '2026-08-25'::timestamp, 'DR-1434', 'APC AGORA', 'Charge', v_main_branch_id, v_inv_id, 48, 225, 10800, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 48, 225, 10800, 'Sale: DR-1434', '2026-08-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-28', '2026-08-28'::timestamp, 'DR-1435', 'JOMAR LUMASAG', 'Charge', v_main_branch_id, v_inv_id, 2, 2300, 4600, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 2, 2300, 4600, 'Sale: DR-1435', '2026-08-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1313' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004558', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 24, 1517.86, 36428.64, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 24, 1517.86, 36428.64, 'Sale: CSI-004558', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SEALRMAX5170-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004559', 'AXELUM RESOURCES CORP.', 'Charge', v_main_branch_id, v_inv_id, 20, 1200, 24000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 20, 1200, 24000, 'Sale: CSI-004559', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 33, 3300, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 33, 3300, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 100, 25, 2500, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 100, 25, 2500, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 200, 25, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 25, 5000, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 200, 25, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 25, 5000, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 200, 25, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 25, 5000, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 200, 25, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 25, 5000, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.sales (date, created_at, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, total_amount, performed_by)
    VALUES ('2026-08-27', '2026-08-27'::timestamp, 'CSI-004560', 'CAR CRAZY', 'Charge', v_main_branch_id, v_inv_id, 200, 25, 5000, 'System Migration');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'OUT', 200, 25, 5000, 'Sale: CSI-004560', '2026-08-27'::timestamp);
  END IF;

  RAISE NOTICE 'Part 3 (Sales) completed successfully!';
END $$;
