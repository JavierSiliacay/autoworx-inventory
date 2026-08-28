-- ============================================================================
-- MAIN DISTRIBUTION MIGRATION - PART 2 of 4: STOCK IN, TRANSFERS & ADJUSTMENTS
-- ============================================================================

DO $$
DECLARE
  v_main_branch_id UUID;
  v_inv_id UUID;
  v_supp_id UUID;
  v_log_id UUID;
BEGIN
  SELECT id INTO v_main_branch_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;


  -- Stock In Log Batch: CSI-33977 (GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-33977', '2026-05-30'::timestamp, 72590, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 50, 1451.8, 72590, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 50, 1451.8, 72590, 'STOCK IN: CSI-33977', '2026-05-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 30, 1451.8, 43554, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 30, 1451.8, 43554, 'STOCK IN: CSI-33977', '2026-05-30'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 81.19, 9742.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 81.19, 9742.8, 'STOCK IN: CSI-33977', '2026-05-30'::timestamp);
  END IF;

  -- Stock In Log Batch: INV_06/4-11/26 (INVENTORY - JUNE 4-11, 2026)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'INVENTORY - JUNE 4-11, 2026' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'INV_06/4-11/26', '2026-06-04'::timestamp, 1451.8, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1451.8, 1451.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1451.8, 1451.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 550.53, 4404.24, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 550.53, 4404.24, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATFLWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 888.96, 10667.52, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 888.96, 10667.52, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 500, 3000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 500, 3000, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATSGWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 929.58, 3718.32, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 929.58, 3718.32, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 1448.4, 2896.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 1448.4, 2896.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBUMBR-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 79.42, 1906.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 79.42, 1906.08, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCVENRD-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 44, 80.77, 3553.88, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 44, 80.77, 3553.88, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 568.58, 7960.12, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 568.58, 7960.12, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUSLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1064.95, 21299, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1064.95, 21299, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUTC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1344.73, 26894.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1344.73, 26894.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1448.4, 31864.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1448.4, 31864.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'APLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 220, 517.27, 113799.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 220, 517.27, 113799.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPPUR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 694.93, 4169.58, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 694.93, 4169.58, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 168, 336, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 168, 336, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 246.4, 2464, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 246.4, 2464, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 432, 1728, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 432, 1728, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-3' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 726.4, 5811.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 726.4, 5811.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPTRL-7' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 250, 58.5, 14625, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 250, 58.5, 14625, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPGLXWHT-16L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 2608.23, 5216.46, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 2608.23, 5216.46, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 45, 27.98, 1259.1, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 45, 27.98, 1259.1, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 37, 888, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 37, 888, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 37, 888, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 37, 888, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCRS-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 36.1, 866.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 36.1, 866.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 37, 666, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 37, 666, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 37, 888, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 37, 888, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 34.75, 834, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 34.75, 834, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBR-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 87.54, 3151.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 87.54, 3151.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCBS-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 39, 76.71, 2991.69, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 39, 76.71, 2991.69, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCFYO-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 77.62, 931.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 77.62, 931.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCHY-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 91.15, 3281.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 91.15, 3281.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCLB-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 71.3, 1711.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 71.3, 1711.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCRS-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 77.62, 1862.88, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 77.62, 1862.88, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCRU-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 72.2, 2599.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 72.2, 2599.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCTB-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 80.77, 1938.48, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 80.77, 1938.48, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPOTCTG-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 80.77, 2584.64, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 80.77, 2584.64, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 105.59, 1267.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 105.59, 1267.08, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 105.59, 2534.16, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 105.59, 2534.16, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVQDCG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 851, 16169, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 851, 16169, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 105.59, 1055.9, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 105.59, 1055.9, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITTH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 548, 13152, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 548, 13152, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 498, 514.05, 255996.9, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 498, 514.05, 255996.9, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1094.8, 21896, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1094.8, 21896, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 950, 19000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 950, 19000, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, -2, 1110, -2220, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', -2, 1110, -2220, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, -3, 1310, -3930, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', -3, 1310, -3930, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1313' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1305, 13050, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1305, 13050, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 102, 800, 81600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 102, 800, 81600, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1110-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2490, 9960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2490, 9960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 105.59, 1267.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 105.59, 1267.08, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCTR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 100.18, 1202.16, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 100.18, 1202.16, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2573, 7719, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2573, 7719, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 99.28, 1191.36, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 99.28, 1191.36, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 4980, 29880, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 4980, 29880, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SNDMSTER-36' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 9590, 9590, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 9590, 9590, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 528, 154.56, 81607.68, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 528, 154.56, 81607.68, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-B' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 360, 4320, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 360, 4320, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 5575.48, 22301.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 5575.48, 22301.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-CB' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 3410, 44330, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 3410, 44330, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-EY' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 1370, 15070, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 1370, 15070, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-V' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1030, 12360, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1030, 12360, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-T' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 1160, 12760, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 1160, 12760, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-A' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1100, 11000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1100, 11000, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-OG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1880, 24440, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1880, 24440, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 55, 2158, 118690, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 55, 2158, 118690, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-E' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 580, 6960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 580, 6960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-D' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 590, 4130, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 590, 4130, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-R' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 580, 6960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 580, 6960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-HT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 2100, 23100, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 2100, 23100, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-LR' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 2260, 24860, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 2260, 24860, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-F' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 610, 3660, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 610, 3660, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-OR' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 640, 3200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 640, 3200, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-KX' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 630, 7560, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 630, 7560, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB745' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 691, 33168, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 691, 33168, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5436, 545, 2962620, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5436, 545, 2962620, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1248, 430, 536640, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1248, 430, 536640, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 42, 830, 34860, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 42, 830, 34860, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 792, 415, 328680, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 792, 415, 328680, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 806, 11284, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 806, 11284, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1353, 13530, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1353, 13530, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX1062' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 581, 1162, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 581, 1162, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 996, 11952, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 996, 11952, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1107' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 889, 11557, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 889, 11557, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1110-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 806, 6448, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 806, 6448, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1113' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 889, 11557, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 889, 11557, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1114' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 676, 7436, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 676, 7436, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1153' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 913, 15521, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 913, 15521, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1157' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 889, 16002, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 889, 16002, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1158' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 889, 12446, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 889, 12446, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1160' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 830, 9960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 830, 9960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 889, 13335, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 889, 13335, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1163' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 889, 17780, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 889, 17780, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1164' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 41, 830, 34030, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 41, 830, 34030, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1165' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 972, 16524, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 972, 16524, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1166' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1470, 29400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1470, 29400, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1167' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1079, 23738, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1079, 23738, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1171' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1055, 29540, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1055, 29540, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1172' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1079, 23738, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1079, 23738, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1173' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1719, 13752, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1719, 13752, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1175' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 930, 9300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 930, 9300, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1180' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1660, 36520, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1660, 36520, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1300' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 2200, 39600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 2200, 39600, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 2200, 37400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 2200, 37400, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1303' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 26, 2200, 57200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 26, 2200, 57200, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1304' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 2200, 15400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 2200, 15400, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1305' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 23, 1743, 40089, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 23, 1743, 40089, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1411, 31042, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1411, 31042, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT149' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1544, 15440, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1544, 15440, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT158-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 1345, 22865, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 1345, 22865, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT180' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1030, 10300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1030, 10300, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT190' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 465, 4650, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 465, 4650, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 706, 8472, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 706, 8472, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT196' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1577, 20501, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1577, 20501, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT210' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1826, 29216, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1826, 29216, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT305' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1494, 17928, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1494, 17928, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT320' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 540, 15660, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 540, 15660, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 1079, 16185, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 1079, 16185, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1652, 620, 1024240, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1652, 620, 1024240, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT380' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 1295, 24605, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 1295, 24605, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT390' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 482, 7712, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 482, 7712, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT3974' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 35, 557, 19495, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 35, 557, 19495, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT410' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 847, 6776, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 847, 6776, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 415, 11620, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 415, 11620, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT490' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 664, 12616, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 664, 12616, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NF146G-5KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1278, 1278, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1278, 1278, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HIPROF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 622.73, 4981.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 622.73, 4981.84, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NF145W-5KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 1278, 2556, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 1278, 2556, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'LOPROF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 654.31, 5234.48, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 654.31, 5234.48, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT530' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1245, 19920, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1245, 19920, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT550' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 515, 7725, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 515, 7725, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT555' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 565, 6780, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 565, 6780, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT556' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 747, 14193, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 747, 14193, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT557' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 540, 10800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 540, 10800, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT595' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 581, 9296, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 581, 9296, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT705-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 430, 7310, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 430, 7310, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT706-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 27, 430, 11610, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 27, 430, 11610, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT707-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 580, 8700, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 580, 8700, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 706, 4236, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 706, 4236, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 515, 2060, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 515, 2060, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT716' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 27, 515, 13905, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 27, 515, 13905, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT720' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 747, 21663, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 747, 21663, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT725' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 723, 20967, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 723, 20967, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT727' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 1162, 33698, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 1162, 33698, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT729' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 53, 889, 47117, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 53, 889, 47117, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT733' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 515, 12360, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 515, 12360, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT736' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 23, 747, 17181, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 23, 747, 17181, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT740' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 557, 10026, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 557, 10026, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT745' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 996, 28884, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 996, 28884, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 605, 4840, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 605, 4840, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 78, 1000, 78000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 78, 1000, 78000, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06M' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 3569, 35690, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 3569, 35690, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT001' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 2241, 42579, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 2241, 42579, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2241, 8964, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2241, 8964, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2241, 17928, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2241, 17928, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2241, 26892, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2241, 26892, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT006' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2241, 26892, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2241, 26892, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT008' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2241, 17928, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2241, 17928, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 1909, 41998, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 1909, 41998, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT023' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 2075, 18675, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 2075, 18675, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA4021' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 1245, 39840, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 1245, 39840, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT025' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1909, 13363, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1909, 13363, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 2241, 15687, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 2241, 15687, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT030' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 1909, 61088, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 1909, 61088, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT033' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2241, 26892, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2241, 26892, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT050' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 3071, 30710, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 3071, 30710, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT051' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 3320, 79680, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 3320, 79680, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3071, 12284, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3071, 12284, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT065' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3071, 36852, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3071, 36852, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1983' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1245, 19920, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1245, 19920, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT066' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 3071, 21497, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 3071, 21497, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3071, 24568, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3071, 24568, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 3569, 85656, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 3569, 85656, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3569, 42828, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3569, 42828, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT071' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3071, 36852, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3071, 36852, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT072' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3071, 36852, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3071, 36852, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT075' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 3071, 30710, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 3071, 30710, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT076' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 3071, 58349, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 3071, 58349, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT078' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 3071, 42994, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 3071, 42994, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3071, 24568, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3071, 24568, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT080' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3071, 36852, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3071, 36852, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 3071, 27639, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 3071, 27639, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3071, 12284, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3071, 12284, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT085' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 3071, 33781, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 3071, 33781, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT086' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3071, 24568, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3071, 24568, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT093' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 3071, 39923, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 3071, 39923, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 5810, 29050, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 5810, 29050, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 1245, 2490, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 1245, 2490, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 3320, 29880, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 3320, 29880, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 4980, 29880, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 4980, 29880, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT170' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 2075, 22825, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 2075, 22825, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT172' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 3154, 34694, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 3154, 34694, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT175' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 31, 1992, 61752, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 31, 1992, 61752, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1372' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 115, 1494, 171810, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 115, 1494, 171810, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1162, 23240, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1162, 23240, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1204, 15652, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1204, 15652, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1909, 22908, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1909, 22908, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT301' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 2573, 41168, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 2573, 41168, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT302' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 2158, 28054, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 2158, 28054, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT303' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 2075, 31125, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 2075, 31125, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT304' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 3486, 31374, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 3486, 31374, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT305' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1951, 25363, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1951, 25363, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT307' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 2988, 26892, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 2988, 26892, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1131' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 2075, 29050, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 2075, 29050, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT401' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 2656, 18592, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 2656, 18592, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT405' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 3611, 115552, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 3611, 115552, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1487' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1494, 7470, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1494, 7470, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 659, 15816, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 659, 15816, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ASKM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 347.46, 5211.9, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 347.46, 5211.9, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 670, 8040, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 670, 8040, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPABFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1616, 1616, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1616, 1616, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 714, 12138, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 714, 12138, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT501' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 2075, 39425, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 2075, 39425, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 2117, 14819, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 2117, 14819, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NCGL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 27, 627, 16929, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 27, 627, 16929, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2365.5, 28386, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2365.5, 28386, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPCGV-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 42, 1390, 58380, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 42, 1390, 58380, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT506' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 2075, 20750, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 2075, 20750, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 2905, 14525, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 2905, 14525, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 6388.2, 12776.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 6388.2, 12776.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS80' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 7434, 22302, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 7434, 22302, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT508' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 2573, 12865, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 2573, 12865, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVEPOPTCH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 2655, 15930, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 2655, 15930, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT601' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2075, 8300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2075, 8300, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 2490, 14940, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 2490, 14940, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT603' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 2075, 20750, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 2075, 20750, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2075, 24900, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2075, 24900, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT606' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1909, 13363, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1909, 13363, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2158, 17264, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2158, 17264, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1992, 9960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1992, 9960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT704' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2905, 23240, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2905, 23240, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT705' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 2075, 10375, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 2075, 10375, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 1743, 19173, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 1743, 19173, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT803' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1826, 18260, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1826, 18260, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1826, 9130, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1826, 9130, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT805' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1826, 14608, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1826, 14608, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT806' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1826, 14608, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1826, 14608, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBLK-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 80, 160, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 80, 160, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBLTNRD-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 96, 384, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 96, 384, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCBSNA-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 87, 1392, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 87, 1392, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCRWSNA-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 79, 79, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 79, 79, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVOTCVNRED-1/4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 90, 720, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 90, 720, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOIT-CAT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 225.82, 8129.52, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 225.82, 8129.52, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NDFL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 27, 643, 17361, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 27, 643, 17361, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DPB-4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 72, 93.33, 6719.76, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 72, 93.33, 6719.76, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT807' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1743, 12201, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1743, 12201, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA80' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 27.5, 8250, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 27.5, 8250, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 600, 20.35, 12210, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 600, 20.35, 12210, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 27.5, 13750, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 27.5, 13750, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCABSG-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 37, 895, 33115, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 37, 895, 33115, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCDBSG-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 914, 10968, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 914, 10968, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 972, 19440, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 972, 19440, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA220' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 20.35, 6105, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 20.35, 6105, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 934, 7472, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 934, 7472, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT903' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1743, 12201, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1743, 12201, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 900, 20.35, 18315, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 900, 20.35, 18315, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 114, 1560, 177840, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 114, 1560, 177840, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT904' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1743, 12201, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1743, 12201, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA320' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 20.35, 2035, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 20.35, 2035, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 1710, 5130, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 1710, 5130, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NB200-HARD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 685, 685, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 685, 685, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 800, 20.35, 16280, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 800, 20.35, 16280, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4406-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 1710, 18810, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 1710, 18810, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 47, 925, 43475, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 47, 925, 43475, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 132, 1145, 151140, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 132, 1145, 151140, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA800' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 600, 20.35, 12210, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 600, 20.35, 12210, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 1710, 18810, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 1710, 18810, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITSHLDALL-BOT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 144, 131.25, 18900, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 144, 131.25, 18900, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 59, 1710, 100890, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 59, 1710, 100890, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 108, 1560, 168480, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 108, 1560, 168480, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 21, 1710, 35910, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 21, 1710, 35910, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 1686, 5058, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 1686, 5058, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MTLPRRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 490, 1960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 490, 1960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPPBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1756, 1756, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1756, 1756, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEWHTE-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1124, 8992, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1124, 8992, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFBLACK-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1184, 8288, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1184, 8288, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFWHTE-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1184, 9472, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1184, 9472, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 174, 1218, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 174, 1218, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PUTTYKNI #4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 80, 9, 720, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 80, 9, 720, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 194.94, 4678.56, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 194.94, 4678.56, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGAB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 274, 4384, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 274, 4384, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGDB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 280, 5600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 280, 5600, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2100, 25200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2100, 25200, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 1475.33, 8851.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 1475.33, 8851.98, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPCGV-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 108, 427, 46116, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 108, 427, 46116, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 760, 45600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 760, 45600, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 176, 1056, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 176, 1056, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGPB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 298, 5960, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 298, 5960, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGTB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 286, 5720, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 286, 5720, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 349, 165, 57585, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 349, 165, 57585, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 770, 9240, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 770, 9240, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQGLDTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 868, 10416, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 868, 10416, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NFP-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 650, 7800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 650, 7800, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ABM-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1877, 9385, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1877, 9385, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DBM-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1912, 7648, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1912, 7648, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2036, 16288, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2036, 16288, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCABSG-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2551, 10204, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2551, 10204, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCDBSG-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 2606, 18242, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 2606, 18242, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 234, 936, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 234, 936, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQINTRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 896, 10752, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 896, 10752, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1016, 16256, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1016, 16256, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMETCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 826.4, 23139.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 826.4, 23139.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 826.4, 19833.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 826.4, 19833.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQMO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 894.4, 7155.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 894.4, 7155.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQPUTYWH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 778.4, 21795.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 778.4, 21795.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQTHBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 879.2, 10550.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 879.2, 10550.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQTHGR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 879.2, 3516.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 879.2, 3516.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMLCQWHTE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 760, 15200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 760, 15200, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAECY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 793.48, 9521.76, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 793.48, 9521.76, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1965.2, 23582.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1965.2, 23582.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 793.48, 3173.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 793.48, 3173.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEFR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 793.48, 3173.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 793.48, 3173.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 793.48, 6347.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 793.48, 6347.84, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAETG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 793.48, 6347.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 793.48, 6347.84, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAETB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 772.55, 6180.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 772.55, 6180.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1796.05, 14368.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1796.05, 14368.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2661, 7983, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2661, 7983, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 708.1, 7081, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 708.1, 7081, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 772.55, 6180.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 772.55, 6180.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 772.55, 6180.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 772.55, 6180.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEFB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 772.55, 3090.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 772.55, 3090.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEPENCATYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1136.55, 4546.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1136.55, 4546.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLEPENTHGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1094.8, 8758.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1094.8, 8758.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUPBRSH' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 112, 448, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 112, 448, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 72, 625, 45000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 72, 625, 45000, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TBM-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 180, 720, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 180, 720, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 580, 34800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 580, 34800, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TRAY' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 29, 32, 928, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 29, 32, 928, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONSAG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 2564.32, 5128.64, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 2564.32, 5128.64, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZANTPR-12' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 108, 79.86, 8624.88, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 108, 79.86, 8624.88, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 242, 1355, 327910, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 242, 1355, 327910, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3003.05, 24024.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3003.05, 24024.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZAY-06' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 110, 79.86, 8784.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 110, 79.86, 8784.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3003.05, 24024.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3003.05, 24024.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 3003.05, 33033.55, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 3003.05, 33033.55, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 3003.05, 21021.35, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 3003.05, 21021.35, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3003.05, 12012.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3003.05, 12012.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1776.5, 12435.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1776.5, 12435.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMRNTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1987.3, 9936.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1987.3, 9936.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 2660.5, 37247, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 2660.5, 37247, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMICARDFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 2660.5, 34586.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 2660.5, 34586.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMLYORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1776.5, 17765, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1776.5, 17765, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2900.2, 34802.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2900.2, 34802.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2900.2, 11600.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2900.2, 11600.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDYL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 2900.2, 14501, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 2900.2, 14501, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2900.2, 34802.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2900.2, 34802.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRMRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2312, 18496, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2312, 18496, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 1776.5, 8882.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 1776.5, 8882.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 1776.5, 15988.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 1776.5, 15988.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 2291.6, 22916, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 2291.6, 22916, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZCANRED-801' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 58, 82.28, 4772.24, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 58, 82.28, 4772.24, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZCLR-01' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 93, 79.86, 7426.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 93, 79.86, 7426.98, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 891, 8910, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 891, 8910, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 79.86, 1756.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 79.86, 1756.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 222, 480, 106560, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 222, 480, 106560, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDISIL-701' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 97.92, 2741.76, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 97.92, 2741.76, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4184-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 1710, 10260, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 1710, 10260, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4197-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 1910, 11460, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 1910, 11460, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4168-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1910, 22920, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1910, 22920, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURANGE-601' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 127.16, 3560.48, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 127.16, 3560.48, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'XTRMEQDWARMYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1710, 27360, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1710, 27360, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUPNK-603' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 127.16, 6103.68, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 127.16, 6103.68, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPJOINTCMPND-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 378, 1512, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 378, 1512, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 965, 7720, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 965, 7720, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOURED-602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 127.16, 4577.76, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 127.16, 4577.76, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEBLK-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1124, 7868, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1124, 7868, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEYEL-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1124, 7868, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1124, 7868, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROADLNEREFYLW-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 1184, 8288, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 1184, 8288, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUVIO-604' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 127.16, 1271.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 127.16, 1271.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZFLOUYEL-600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 123.42, 1481.04, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 123.42, 1481.04, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 54, 79.86, 4312.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 54, 79.86, 4312.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 924.48, 16640.64, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 924.48, 16640.64, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENINTRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1056.24, 16899.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1056.24, 16899.84, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1056.24, 63374.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1056.24, 63374.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 234, 1404, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 234, 1404, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCTBSG-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 224, 2688, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 224, 2688, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGYLGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 2283.1, 34246.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 2283.1, 34246.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HS-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, -11, 545, -5995, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', -11, 545, -5995, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGYLOXDE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 17, 1776.5, 30200.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 17, 1776.5, 30200.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PBM-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 188, 1128, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 188, 1128, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGLD-705' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 95.04, 5702.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 95.04, 5702.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZGRY-45' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 79.86, 2874.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 79.86, 2874.96, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZHTRSTSIL-709' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 146.2, 4093.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 146.2, 4093.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HIHEAT' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 84, 150.5, 12642, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 84, 150.5, 12642, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZLTGR-33' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 50, 79.86, 3993, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 50, 79.86, 3993, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZMTBLK-47' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 79.86, 3833.28, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 79.86, 3833.28, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZMTW-03' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 46, 79.86, 3673.56, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 46, 79.86, 3673.56, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSSG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 631.75, 5054, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 631.75, 5054, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTOG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 631.75, 2527, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 631.75, 2527, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 631.75, 7581, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 631.75, 7581, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSNP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 631.75, 8844.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 631.75, 8844.5, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSOSR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 812.25, 12996, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 812.25, 12996, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSIP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSMW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 690.41, 5523.28, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 690.41, 5523.28, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSS-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSIL-42' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 79.86, 4791.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 79.86, 4791.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZSKBL-22' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 79.86, 159.72, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 79.86, 159.72, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZVIO-20' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 79.86, 1756.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 79.86, 1756.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZWH-02' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 38, 79.86, 3034.68, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 38, 79.86, 3034.68, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-15L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 2550, 22950, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 2550, 22950, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 218, 582.67, 127022.06, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 218, 582.67, 127022.06, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBPNTSTRNR' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 39, 6.65, 259.35, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 39, 6.65, 259.35, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLLQWX-50ML' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 250, 44.8, 11200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 250, 44.8, 11200, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 54, 373.1, 20147.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 54, 373.1, 20147.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 37.8, 3780, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 37.8, 3780, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RST-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 735.54, 3677.7, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 735.54, 3677.7, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSSB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBGWN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 631.75, 7581, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 631.75, 7581, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSGB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 690.41, 13808.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 690.41, 13808.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 631.75, 12635, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 631.75, 12635, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCNT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 631.75, 15162, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 631.75, 15162, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSFM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 631.75, 2527, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 631.75, 2527, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSLO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1308.63, 20938.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1308.63, 20938.08, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 631.75, 5054, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 631.75, 5054, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSXG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 7, 609.19, 4264.33, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 7, 609.19, 4264.33, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 631.75, 10108, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 631.75, 10108, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSA-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 631.75, 5054, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 631.75, 5054, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 749.08, 8988.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 749.08, 8988.96, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSAB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 731.75, 5854, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 731.75, 5854, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACFRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 1186.96, 17804.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 1186.96, 17804.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACGLDTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1320.16, 15841.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1320.16, 15841.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACINTRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 1186.96, 2373.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 1186.96, 2373.92, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACLMNYLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 942.76, 30168.32, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 942.76, 30168.32, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1033.78, 20675.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1033.78, 20675.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1033.78, 20675.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1033.78, 20675.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACMORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 922.78, 11073.36, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 922.78, 11073.36, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 876.9, 10522.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 876.9, 10522.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 19, 876.9, 16661.1, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 19, 876.9, 16661.1, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACREDGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1168.46, 23369.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1168.46, 23369.2, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1140.34, 14824.42, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1140.34, 14824.42, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8300-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 41, 1505, 61705, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 41, 1505, 61705, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI122' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 23, 665, 15295, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 23, 665, 15295, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 81, 397.8, 32221.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 81, 397.8, 32221.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'UNDRCOATGUN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 576, 8640, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 576, 8640, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 626.34, 5010.72, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 626.34, 5010.72, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCGLXWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 140.79, 5068.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 140.79, 5068.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 413.35, 1653.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 413.35, 1653.4, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 183, 4392, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 183, 4392, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 166, 7968, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 166, 7968, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 151.62, 1819.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 151.62, 1819.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 613.7, 14728.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 613.7, 14728.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCALORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 884.45, 7960.05, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 884.45, 7960.05, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 151.62, 1819.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 151.62, 1819.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 559.55, 8952.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 559.55, 8952.8, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACTHGR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1050.06, 12600.72, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1050.06, 12600.72, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 570, 636.48, 362793.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 570, 636.48, 362793.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 922.78, 8305.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 922.78, 8305.02, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 252, 167.67, 42252.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 252, 167.67, 42252.84, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 440, 611.34, 268989.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 440, 611.34, 268989.6, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 694.93, 5559.44, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 694.93, 5559.44, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAS535' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, -3, 750, -2250, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', -3, 750, -2250, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 169.67, 8144.16, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 169.67, 8144.16, 'STOCK IN: INV_06/4-11/26', '2026-06-04'::timestamp);
  END IF;

  -- Stock In Log Batch: NO-REF (JULIUS CAESAR AYING)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'JULIUS CAESAR AYING' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ADJ-2026-06-16', '2026-06-16'::timestamp, 20500, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 41, 20500, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 41, 20500, 'STOCK IN: 2026-06-16', '2026-06-16'::timestamp);
  END IF;

  -- Stock In Log Batch: ST-00027 (APC DISTRIBUTION - VALENCIA)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ST-00027', '2026-06-24'::timestamp, 111600, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 180, 620, 111600, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 180, 620, 111600, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 180, 360, 64800, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 180, 360, 64800, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 240, 545, 130800, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 240, 545, 130800, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 706, 4236, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 706, 4236, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 925, 33300, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 925, 33300, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1909, 7636, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1909, 7636, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2117, 8468, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2117, 8468, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 613.7, 12274, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 613.7, 12274, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 806, 9672, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 806, 9672, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1560, 62400, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1560, 62400, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 1710, 5130, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 1710, 5130, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 2158, 43160, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 2158, 43160, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 550.53, 4404.24, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 550.53, 4404.24, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 500, 3000, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 500, 3000, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 80, 514.05, 41124, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 80, 514.05, 41124, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 80, 1710, 136800, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 80, 1710, 136800, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 1710, 5130, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 1710, 5130, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 6388.2, 6388.2, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 6388.2, 6388.2, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 200, 20.35, 4070, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 200, 20.35, 4070, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 1451.8, 21777, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 1451.8, 21777, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 400, 20.35, 8140, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 400, 20.35, 8140, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 891, 7128, 'STOCK TRANSFER');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 891, 7128, 'STOCK TRANSFER: ST-00027', '2026-06-24'::timestamp);
  END IF;

  -- Stock In Log Batch: NO-REF (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ADJ-2026-06-25', '2026-06-25'::timestamp, 13000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPSPGUN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 13000, 13000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 13000, 13000, 'STOCK IN: 2026-06-25', '2026-06-25'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-12780 (QUADGROUP DISTRIBUTION INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'QUADGROUP DISTRIBUTION INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-12780', '2026-06-25'::timestamp, 25300, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1000, 25.3, 25300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1000, 25.3, 25300, 'STOCK IN: CSI-12780', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1500, 16.5, 24750, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1500, 16.5, 24750, 'STOCK IN: CSI-12780', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 25.3, 7590, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 25.3, 7590, 'STOCK IN: CSI-12780', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1500, 20.35, 30525, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1500, 20.35, 30525, 'STOCK IN: CSI-12780', '2026-06-25'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1000, 20.35, 20350, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1000, 20.35, 20350, 'STOCK IN: CSI-12780', '2026-06-25'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-573371 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-573371', '2026-06-27'::timestamp, 45420, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DVGLW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 757, 45420, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 757, 45420, 'STOCK IN: CSI-573371', '2026-06-27'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BSTP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 18, 484, 8712, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 18, 484, 8712, 'STOCK IN: CSI-573371', '2026-06-27'::timestamp);
  END IF;

  -- Stock In Log Batch: NO-REF (JULIUS CAESAR AYING)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'JULIUS CAESAR AYING' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ADJ-2026-07-03', '2026-07-03'::timestamp, 20500, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 41, 20500, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 41, 20500, 'STOCK IN: 2026-07-03', '2026-07-03'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310448652 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310448652', '2026-07-07'::timestamp, 91000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 910, 91000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 910, 91000, 'STOCK IN: DR-2310448652', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 910, 91000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 910, 91000, 'STOCK IN: DR-2310448652', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310448649 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310448649', '2026-07-07'::timestamp, 432001.92, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1200, 360.0016, 432001.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1200, 360.0016, 432001.92, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 605.0015833, 72600.19, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 605.0015833, 72600.19, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1710.005, 34200.1, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1710.005, 34200.1, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1224-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 1710.005, 10260.03, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 1710.005, 10260.03, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1309.996875, 20959.95, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1309.996875, 20959.95, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA4021' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1245.003, 24900.06, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1245.003, 24900.06, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 863, 164.9984009, 142393.62, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 863, 164.9984009, 142393.62, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 15, 1743, 26145, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 15, 1743, 26145, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 25, 1710.0048, 42750.12, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 25, 1710.0048, 42750.12, 'STOCK IN: DR-2310448649', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310446180 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310446180', '2026-07-07'::timestamp, 168324.37, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 78, 2158.004744, 168324.37, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 78, 2158.004744, 168324.37, 'STOCK IN: DR-2310446180', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 1826.003333, 5478.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 1826.003333, 5478.01, 'STOCK IN: DR-2310446180', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2240.996667, 6722.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2240.996667, 6722.99, 'STOCK IN: DR-2310446180', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310448650 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310448650', '2026-07-07'::timestamp, 30875.98, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT728' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 1286.499167, 30875.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 1286.499167, 30875.98, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 2572.998571, 36021.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 2572.998571, 36021.98, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 514.998, 5149.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 514.998, 5149.98, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT147' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 1337, 48132, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 1337, 48132, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 26, 930.0030769, 24180.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 26, 930.0030769, 24180.08, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1809.9985, 72399.94, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1809.9985, 72399.94, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2489.995, 9959.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2489.995, 9959.98, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT601' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2075.0025, 8300.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2075.0025, 8300.01, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2905, 11620, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2905, 11620, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 2117.00125, 16936.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 2117.00125, 16936.01, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 1908.995313, 61087.85, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 1908.995313, 61087.85, 'STOCK IN: DR-2310448650', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310448241 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310448241', '2026-07-07'::timestamp, 2059.99, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 514.9975, 2059.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 514.9975, 2059.99, 'STOCK IN: DR-2310448241', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310447179 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310447179', '2026-07-07'::timestamp, 5149.98, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 514.998, 5149.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 514.998, 5149.98, 'STOCK IN: DR-2310447179', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT805' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1826, 1826, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1826, 1826, 'STOCK IN: DR-2310447179', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1991.99875, 15935.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1991.99875, 15935.99, 'STOCK IN: DR-2310447179', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT006' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 2240.996, 11204.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 2240.996, 11204.98, 'STOCK IN: DR-2310447179', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310448651 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310448651', '2026-07-07'::timestamp, 9960.03, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1245.00375, 9960.03, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1245.00375, 9960.03, 'STOCK IN: DR-2310448651', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3070.995, 12283.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3070.995, 12283.98, 'STOCK IN: DR-2310448651', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT068' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 5975.995, 71711.94, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 5975.995, 71711.94, 'STOCK IN: DR-2310448651', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3070.995, 12283.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3070.995, 12283.98, 'STOCK IN: DR-2310448651', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HS-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 544.9916667, 6539.9, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 544.9916667, 6539.9, 'STOCK IN: DR-2310448651', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310446952 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310446952', '2026-07-07'::timestamp, 4236.02, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 706.0033333, 4236.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 706.0033333, 4236.02, 'STOCK IN: DR-2310446952', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT556' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 746.9966667, 2240.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 746.9966667, 2240.99, 'STOCK IN: DR-2310446952', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310447178 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310447178', '2026-07-07'::timestamp, 3384, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1K145W-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 3384, 3384, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 3384, 3384, 'STOCK IN: DR-2310447178', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1K1602T-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2999.596667, 8998.79, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2999.596667, 8998.79, 'STOCK IN: DR-2310447178', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-0037944 (COLOR-WAY PAINT TRADING CO.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'COLOR-WAY PAINT TRADING CO.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-0037944', '2026-07-07'::timestamp, 14950, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 13, 1150, 14950, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 13, 1150, 14950, 'STOCK IN: DR-0037944', '2026-07-07'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBREENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 47, 1260, 59220, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 47, 1260, 59220, 'STOCK IN: DR-0037944', '2026-07-07'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-573640 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-573640', '2026-07-08'::timestamp, 16060, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SR-913' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 803, 16060, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 803, 16060, 'STOCK IN: CSI-573640', '2026-07-08'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1141 (GRIT SUPPLY INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'GRIT SUPPLY INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1141', '2026-07-09'::timestamp, 49680, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QSHG710-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 72, 690, 49680, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 72, 690, 49680, 'STOCK IN: CSI-1141', '2026-07-09'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-12886 (QUADGROUP DISTRIBUTION INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'QUADGROUP DISTRIBUTION INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-12886', '2026-07-09'::timestamp, 20350, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1000, 20.35, 20350, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1000, 20.35, 20350, 'STOCK IN: CSI-12886', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 29.7, 8910, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 29.7, 8910, 'STOCK IN: CSI-12886', '2026-07-09'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 776, 9312, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 776, 9312, 'STOCK IN: CSI-12886', '2026-07-09'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-57225 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-57225', '2026-07-14'::timestamp, 16060, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRAW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 803, 16060, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 803, 16060, 'STOCK IN: CSI-57225', '2026-07-14'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-574230 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-574230', '2026-07-15'::timestamp, 32120, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRSG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 803, 32120, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 803, 32120, 'STOCK IN: CSI-574230', '2026-07-15'::timestamp);
  END IF;

  -- Stock In Log Batch: INV_7/22-25/26 (INVENTORY - JULY 22-25, 2026)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'INVENTORY - JULY 22-25, 2026' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'INV_7/22-25/26', '2026-07-28'::timestamp, 4890.72, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 611.34, 4890.72, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 611.34, 4890.72, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 922.78, 922.78, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 922.78, 922.78, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOACPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 876.9, 876.9, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 876.9, 876.9, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TBM-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 180, 360, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 180, 360, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 620, 7440, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 620, 7440, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 582.67, 13984.08, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 582.67, 13984.08, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 79.86, 159.72, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 79.86, 159.72, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 360, 17280, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 360, 17280, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 770, 3080, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 770, 3080, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX141' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 180, 430, 77400, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 180, 430, 77400, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 470, 1410, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 470, 1410, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT557' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 540, 1080, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 540, 1080, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1110-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 2490, 2490, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 2490, 2490, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1743, 6972, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1743, 6972, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 4980, 4980, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 4980, 4980, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 5, 3071, 15355, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 5, 3071, 15355, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT066' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3071, 36852, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3071, 36852, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 3071, 27639, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 3071, 27639, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 2241, 2241, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 2241, 2241, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPPBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1844, 1844, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1844, 1844, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 480, 5760, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 480, 5760, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 234, 936, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 234, 936, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGPB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 298, 596, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 298, 596, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGTB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 286, 572, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 286, 572, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PLTHGDB-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 280, 560, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 280, 560, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1776.5, 1776.5, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1776.5, 1776.5, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 2291.6, 2291.6, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 2291.6, 2291.6, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 580, 580, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 580, 580, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBLK-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 151.62, 1819.44, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 151.62, 1819.44, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCGLXWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 11, 140.79, 1548.69, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 11, 140.79, 1548.69, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 772.55, 3090.2, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 772.55, 3090.2, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEMC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 772.55, 3090.2, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 772.55, 3090.2, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAEIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 793.48, 3173.92, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 793.48, 3173.92, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLAECY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 793.48, 7141.32, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 793.48, 7141.32, 'ADJUSTMENT (-): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 3071, 3071, 'ADJUSTMENT (+)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 3071, 3071, 'ADJUSTMENT (+): INV_7/22-25/26', '2026-07-28'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-12975 (QUADGROUP DISTRIBUTION INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'QUADGROUP DISTRIBUTION INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-12975', '2026-07-28'::timestamp, 10175, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA600' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA60' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 29.7, 8910, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 29.7, 8910, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1000, 20.35, 20350, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1000, 20.35, 20350, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 27.5, 13750, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 27.5, 13750, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1500, 20.35, 30525, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1500, 20.35, 30525, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'STOCK IN: CSI-12975', '2026-07-28'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-574766 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-574766', '2026-07-28'::timestamp, 23400, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BSAXPRWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1170, 23400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1170, 23400, 'STOCK IN: CSI-574766', '2026-07-28'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406632 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406632', '2026-07-24'::timestamp, 71300, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 713, 71300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 713, 71300, 'STOCK IN: CSI-1406632', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 753, 75300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 753, 75300, 'STOCK IN: CSI-1406632', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 920, 36800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 920, 36800, 'STOCK IN: CSI-1406632', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406633 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406633', '2026-07-24'::timestamp, 56072.8, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGFLTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 2002.6, 56072.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 2002.6, 56072.8, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PG888RED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 2541.5, 71162, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 2541.5, 71162, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1975.4, 39508, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1975.4, 39508, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGAPLRED-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 2521.1, 70590.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 2521.1, 70590.8, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGSPRKLIRD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1806.25, 50575, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1806.25, 50575, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTCPR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 3898.95, 31191.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 3898.95, 31191.6, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1795.2, 71808, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1795.2, 71808, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUJTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1895.5, 75820, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1895.5, 75820, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPRLFB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 3190.05, 38280.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 3190.05, 38280.6, 'STOCK IN: CSI-1406633', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406634 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406634', '2026-07-24'::timestamp, 57324, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTC-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 477.7, 57324, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 477.7, 57324, 'STOCK IN: CSI-1406634', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406635 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406635', '2026-07-24'::timestamp, 50694, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUSF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 422.45, 50694, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 422.45, 50694, 'STOCK IN: CSI-1406635', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406631 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406631', '2026-07-24'::timestamp, 26440, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 661, 26440, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 661, 26440, 'STOCK IN: CSI-1406631', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406629 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406629', '2026-07-24'::timestamp, 18000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXQDBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 450, 18000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 450, 18000, 'STOCK IN: CSI-1406629', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406476 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406476', '2026-07-24'::timestamp, 27075, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSI-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 676.875, 27075, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 676.875, 27075, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSFM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 676.875, 27075, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 676.875, 27075, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSCB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 676.875, 27075, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 676.875, 27075, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSGT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 676.875, 27075, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 676.875, 27075, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RST-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 789.6875, 9476.25, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 789.6875, 9476.25, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSMW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 740.05, 8880.6, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 740.05, 8880.6, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTOG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSTW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 676.875, 27075, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 676.875, 27075, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREPA-WHITE' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 550.525, 11010.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 550.525, 11010.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSHB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSBH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 789.6875, 9476.25, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 789.6875, 9476.25, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'RSLB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 676.875, 13537.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 676.875, 13537.5, 'STOCK IN: CSI-1406476', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406630 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406630', '2026-07-24'::timestamp, 11360, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TFLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 284, 11360, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 284, 11360, 'STOCK IN: CSI-1406630', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TSGLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 425, 17000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 425, 17000, 'STOCK IN: CSI-1406630', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TGLXW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 473, 18920, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 473, 18920, 'STOCK IN: CSI-1406630', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXSRUB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 541, 21640, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 541, 21640, 'STOCK IN: CSI-1406630', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406491 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406491', '2026-07-24'::timestamp, 59565, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 595.65, 59565, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 595.65, 59565, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-16L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 2373.575, 23735.75, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 2373.575, 23735.75, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPSGLXWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 685.9, 68590, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 685.9, 68590, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPSGLXWHT-16L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 2734.575, 27345.75, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 2734.575, 27345.75, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCRWSIENA-LTR' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 105.5925, 2534.22, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 105.5925, 2534.22, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 82.1275, 2956.59, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 82.1275, 2956.59, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPLTCHY-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 135.375, 4873.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 135.375, 4873.5, 'STOCK IN: CSI-1406491', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406815 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406815', '2026-07-24'::timestamp, 11696.4, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDAG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 731.025, 11696.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 731.025, 11696.4, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 857.375, 13718, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 857.375, 13718, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCRB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 685.9, 10974.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 685.9, 10974.4, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 694.925, 11118.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 694.925, 11118.8, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDMR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 920.55, 14728.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 920.55, 14728.8, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDSB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 685.9, 10974.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 685.9, 10974.4, 'STOCK IN: CSI-1406815', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406814 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406814', '2026-07-24'::timestamp, 11010.5, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 550.525, 11010.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 550.525, 11010.5, 'STOCK IN: CSI-1406814', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1001.775, 40071, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1001.775, 40071, 'STOCK IN: CSI-1406814', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATGLWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1069.4625, 17111.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1069.4625, 17111.4, 'STOCK IN: CSI-1406814', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 798.7125, 31948.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 798.7125, 31948.5, 'STOCK IN: CSI-1406814', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1406492 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1406492', '2026-07-24'::timestamp, 15053.7, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFLXWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 125.4475, 15053.7, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 125.4475, 15053.7, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCSGLXWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 148.9125, 17869.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 148.9125, 17869.5, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCGLXWHT-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 148.9125, 17869.5, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 148.9125, 17869.5, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCFWE-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 186.8175, 11209.05, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 186.8175, 11209.05, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 442.225, 17689, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 442.225, 17689, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 122.28875, 14674.65, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 122.28875, 14674.65, 'STOCK IN: CSI-1406492', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1408540 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1408540', '2026-07-24'::timestamp, 68000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPRO-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 680, 68000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 680, 68000, 'STOCK IN: CSI-1408540', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1407988 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1407988', '2026-07-24'::timestamp, 50575, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMETFNE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1806.25, 50575, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1806.25, 50575, 'STOCK IN: CSI-1407988', '2026-07-24'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMETCRSE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1806.25, 50575, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1806.25, 50575, 'STOCK IN: CSI-1407988', '2026-07-24'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1409766 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1409766', '2026-07-31'::timestamp, 56400, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 940, 56400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 940, 56400, 'STOCK IN: CSI-1409766', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENTB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 920, 55200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 920, 55200, 'STOCK IN: CSI-1409766', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEENIR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 888, 17760, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 888, 17760, 'STOCK IN: CSI-1409766', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 753, 75300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 753, 75300, 'STOCK IN: CSI-1409766', '2026-07-31'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 713, 71300, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 713, 71300, 'STOCK IN: CSI-1409766', '2026-07-31'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1408737 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1408737', '2026-07-31'::timestamp, 28866, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGCAT-CAN' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 240.55, 28866, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 240.55, 28866, 'STOCK IN: CSI-1408737', '2026-07-31'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1408738 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1408738', '2026-07-31'::timestamp, 35649, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGA-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2970.75, 35649, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2970.75, 35649, 'STOCK IN: CSI-1408738', '2026-07-31'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-4313 (LLEM HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'LLEM HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-4313', '2026-08-03'::timestamp, 14656, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 366.4, 14656, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 366.4, 14656, 'STOCK IN: DR-4313', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 168, 3360, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 168, 3360, 'STOCK IN: DR-4313', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 246.4, 4928, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 246.4, 4928, 'STOCK IN: DR-4313', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 454.4, 4544, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 454.4, 4544, 'STOCK IN: DR-4313', '2026-08-03'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2BBBRLR 4"' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 400, 28, 11200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 400, 28, 11200, 'STOCK IN: DR-4313', '2026-08-03'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-46816 (MARCH RESOURCES MANUFACTURING CORPORATION)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MARCH RESOURCES MANUFACTURING CORPORATION' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-46816', '2026-08-05'::timestamp, 63600, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBRSPGUN-F75' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 636, 63600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 636, 63600, 'STOCK IN: DR-46816', '2026-08-05'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-46817 (MARCH RESOURCES MANUFACTURING CORPORATION)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MARCH RESOURCES MANUFACTURING CORPORATION' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-46817', '2026-08-05'::timestamp, 120000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBREENTG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 1000, 120000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 1000, 120000, 'STOCK IN: DR-46817', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WEEW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 1000, 120000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 1000, 120000, 'STOCK IN: DR-46817', '2026-08-05'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBREEB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 1000, 120000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 1000, 120000, 'STOCK IN: DR-46817', '2026-08-05'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1198 (GRIT SUPPLY INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'GRIT SUPPLY INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1198', '2026-08-05'::timestamp, 23400, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 390, 23400, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 390, 23400, 'STOCK IN: CSI-1198', '2026-08-05'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310451376 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310451376', '2026-08-04'::timestamp, 91000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 910, 91000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 910, 91000, 'STOCK IN: DR-2310451376', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310451510 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310451510', '2026-08-04'::timestamp, 6840.02, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1710.005, 6840.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1710.005, 6840.02, 'STOCK IN: DR-2310451510', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452556 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452556', '2026-08-04'::timestamp, 1239996.8, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2000, 619.9984, 1239996.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2000, 619.9984, 1239996.8, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1560.00325, 62400.13, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1560.00325, 62400.13, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1560.00325, 62400.13, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1560.00325, 62400.13, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 240, 924.9967917, 221999.23, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 240, 924.9967917, 221999.23, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 104, 1145.009615, 119081, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 104, 1145.009615, 119081, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 805.9966667, 29015.88, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 805.9966667, 29015.88, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 31, 1743, 54033, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 31, 1743, 54033, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 2572.9985, 51459.97, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 2572.9985, 51459.97, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 22, 514.9981818, 11329.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 22, 514.9981818, 11329.96, 'STOCK IN: DR-2310452556', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310451492 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310451492', '2026-08-04'::timestamp, 3420.01, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1224-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 1710.005, 3420.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 1710.005, 3420.01, 'STOCK IN: DR-2310451492', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1309.9975, 5239.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1309.9975, 5239.99, 'STOCK IN: DR-2310451492', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 805.9966667, 19343.92, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 805.9966667, 19343.92, 'STOCK IN: DR-2310451492', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT728' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1286.5, 5146, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1286.5, 5146, 'STOCK IN: DR-2310451492', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452165 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452165', '2026-08-04'::timestamp, 15437.99, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 2572.998333, 15437.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 2572.998333, 15437.99, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 514.9985714, 7209.98, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 514.9985714, 7209.98, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 706.0033333, 16944.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 706.0033333, 16944.08, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 930.003, 9300.03, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 930.003, 9300.03, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPULTIMATRVISWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1599.9985, 31999.97, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1599.9985, 31999.97, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPULTIMA-HARD 1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 599.995, 11999.9, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 599.995, 11999.9, 'STOCK IN: DR-2310452165', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452558 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452558', '2026-08-04'::timestamp, 26891.96, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 2240.996667, 26891.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 2240.996667, 26891.96, 'STOCK IN: DR-2310452558', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1000.003167, 60000.19, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1000.003167, 60000.19, 'STOCK IN: DR-2310452558', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 228, 624.9935965, 142498.54, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 228, 624.9935965, 142498.54, 'STOCK IN: DR-2310452558', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452163 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452163', '2026-08-04'::timestamp, 172640.38, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 80, 2158.00475, 172640.38, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 80, 2158.00475, 172640.38, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 38, 1710.004737, 64980.18, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 38, 1710.004737, 64980.18, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1224-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1710.005, 6840.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1710.005, 6840.02, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE4090' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 180, 1309.996778, 235799.42, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 180, 1309.996778, 235799.42, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 200, 1109.9984, 221999.68, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 200, 1109.9984, 221999.68, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 97, 164.9983505, 16004.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 97, 164.9983505, 16004.84, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 25, 1743, 43575, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 25, 1743, 43575, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT728' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1286.49875, 10291.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1286.49875, 10291.99, 'STOCK IN: DR-2310452163', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452171 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452171', '2026-08-04'::timestamp, 110999.84, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1988' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 1109.9984, 110999.84, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 1109.9984, 110999.84, 'STOCK IN: DR-2310452171', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 240, 624.9935833, 149998.46, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 240, 624.9935833, 149998.46, 'STOCK IN: DR-2310452171', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452557 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452557', '2026-08-04'::timestamp, 16944.08, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 706.0033333, 16944.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 706.0033333, 16944.08, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 706.0033333, 8472.04, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 706.0033333, 8472.04, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1078.996667, 12947.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1078.996667, 12947.96, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT149' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 1543.998333, 37055.96, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 1543.998333, 37055.96, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 889, 12446, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 889, 12446, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1159' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 930.0033333, 22320.08, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 930.0033333, 22320.08, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 996.005, 11952.06, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 996.005, 11952.06, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1353.005, 10824.04, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1353.005, 10824.04, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 4980.0025, 19920.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 4980.0025, 19920.01, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 4980.001667, 59760.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 4980.001667, 59760.02, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2240.9975, 8963.99, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2240.9975, 8963.99, 'STOCK IN: DR-2310452557', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310451144 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310451144', '2026-08-04'::timestamp, 7550.41, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1532P-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1887.6025, 7550.41, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1887.6025, 7550.41, 'STOCK IN: DR-2310451144', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2099A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 2372.005, 4744.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 2372.005, 4744.01, 'STOCK IN: DR-2310451144', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2123A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2150.6, 6451.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2150.6, 6451.8, 'STOCK IN: DR-2310451144', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '145(N1)-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1736, 1736, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1736, 1736, 'STOCK IN: DR-2310451144', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452059 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452059', '2026-08-04'::timestamp, 7550.41, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1532P-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1887.6025, 7550.41, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1887.6025, 7550.41, 'STOCK IN: DR-2310452059', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2099A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 2372.005, 4744.01, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 2372.005, 4744.01, 'STOCK IN: DR-2310452059', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2123A-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 3, 2150.6, 6451.8, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 3, 2150.6, 6451.8, 'STOCK IN: DR-2310452059', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '145(N1)-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1736, 1736, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1736, 1736, 'STOCK IN: DR-2310452059', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452723 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452723', '2026-08-04'::timestamp, 69319.94, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPDBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1732.9985, 69319.94, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1732.9985, 69319.94, 'STOCK IN: DR-2310452723', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310452056 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310452056', '2026-08-04'::timestamp, 70800.13, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1770.00325, 70800.13, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1770.00325, 70800.13, 'STOCK IN: DR-2310452056', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SEALRMAX5170-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1050, 42000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1050, 42000, 'STOCK IN: DR-2310452056', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-C' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 500.0016667, 6000.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 500.0016667, 6000.02, 'STOCK IN: DR-2310452056', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-E' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 6, 580.0033333, 3480.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 6, 580.0033333, 3480.02, 'STOCK IN: DR-2310452056', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-2402 (DO IT MARKETING CO., PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'DO IT MARKETING CO., PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-2402', '2026-08-06'::timestamp, 68640, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 39, 1760, 68640, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 39, 1760, 68640, 'STOCK IN: CSI-2402', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 32, 2640, 84480, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 32, 2640, 84480, 'STOCK IN: CSI-2402', '2026-08-06'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-2372 (DO IT MARKETING CO., PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'DO IT MARKETING CO., PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-2372', '2026-08-06'::timestamp, 30800, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 14, 2200, 30800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 14, 2200, 30800, 'STOCK IN: CSI-2372', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 1, 1760, 1760, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 1, 1760, 1760, 'STOCK IN: CSI-2372', '2026-08-06'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBTCKCLTH' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 42, 4200, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 42, 4200, 'STOCK IN: CSI-2372', '2026-08-06'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-00174111 (SUPERGLOBE, INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'SUPERGLOBE, INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-00174111', '2026-08-04'::timestamp, 20347.2, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1017.36, 20347.2, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1017.36, 20347.2, 'STOCK IN: CSI-00174111', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1056.24, 63374.4, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1056.24, 63374.4, 'STOCK IN: CSI-00174111', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PINEPENTHBLU-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1090.8, 65448, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1090.8, 65448, 'STOCK IN: CSI-00174111', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-00174110 (SUPERGLOBE, INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'SUPERGLOBE, INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-00174110', '2026-08-04'::timestamp, 411240, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 800, 514.05, 411240, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 800, 514.05, 411240, 'STOCK IN: CSI-00174110', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 600, 154.56, 92736, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 600, 154.56, 92736, 'STOCK IN: CSI-00174110', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 250, 42, 10500, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 250, 42, 10500, 'STOCK IN: CSI-00174110', '2026-08-04'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOAT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 300, 530, 159000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 300, 530, 159000, 'STOCK IN: CSI-00174110', '2026-08-04'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1410894 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1410894', '2026-08-10'::timestamp, 61800, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'USAEPENWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1030, 61800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1030, 61800, 'STOCK IN: CSI-1410894', '2026-08-10'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1410997 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1410997', '2026-08-10'::timestamp, 39100, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1955, 39100, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1955, 39100, 'STOCK IN: CSI-1410997', '2026-08-10'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1410778 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1410778', '2026-08-10'::timestamp, 54740, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHBLU-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1955, 54740, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1955, 54740, 'STOCK IN: CSI-1410778', '2026-08-10'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1228 (GRIT SUPPLY INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'GRIT SUPPLY INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1228', '2026-08-18'::timestamp, 21450, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NLT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 55, 390, 21450, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 55, 390, 21450, 'STOCK IN: CSI-1228', '2026-08-18'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-575634 (MACKUN HARDWARE)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'MACKUN HARDWARE' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-575634', '2026-08-19'::timestamp, 60225, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SRSG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 75, 803, 60225, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 75, 803, 60225, 'STOCK IN: CSI-575634', '2026-08-19'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-1412209 (ASIAN COATINGS, PHILS., INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'ASIAN COATINGS, PHILS., INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-1412209', '2026-08-20'::timestamp, 82800, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 690, 82800, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 690, 82800, 'STOCK IN: CSI-1412209', '2026-08-20'::timestamp);
  END IF;

  -- Stock In Log Batch: NO-REF (JULIUS CAESAR AYING)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'JULIUS CAESAR AYING' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ADJ-2026-08-10', '2026-08-10'::timestamp, 20500, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 41, 20500, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 41, 20500, 'STOCK IN: 2026-08-10', '2026-08-10'::timestamp);
  END IF;

  -- Stock In Log Batch: CSI-18384 (COLOR-WAY PAINT TRADING CO.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'COLOR-WAY PAINT TRADING CO.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'CSI-18384', '2026-08-25'::timestamp, 75600, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WEEW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1260, 75600, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1260, 75600, 'STOCK IN: CSI-18384', '2026-08-25'::timestamp);
  END IF;

  -- Stock In Log Batch: ST-00028 (APC DISTRIBUTION - VALENCIA)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'ST-00028', '2026-08-22'::timestamp, 148800, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 240, 620, 148800, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 240, 620, 148800, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 192, 360, 69120, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 192, 360, 69120, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 360, 470, 169200, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 360, 470, 169200, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 120, 925, 111000, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 120, 925, 111000, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1909, 7636, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1909, 7636, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 2117, 8468, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 2117, 8468, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT728' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 1286.5, 15438, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 1286.5, 15438, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXQDBL-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 450, 9000, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 450, 9000, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 798.7125, 15974.25, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 798.7125, 15974.25, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 515, 12360, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 515, 12360, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX10100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 806, 19344, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 806, 19344, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 706, 25416, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 706, 25416, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 1560, 62400, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 1560, 62400, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1710, 13680, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1710, 13680, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 2158, 43160, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 2158, 43160, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 550.525, 11010.5, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 550.525, 11010.5, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ALPATPW-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 28, 1001.775, 28049.7, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 28, 1001.775, 28049.7, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 80, 514.05, 41124, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 80, 514.05, 41124, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 611.34, 24453.6, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 611.34, 24453.6, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TXSRUB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 541, 6492, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 541, 6492, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCMPRO-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 122.2888333, 7337.33, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 122.2888333, 7337.33, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 200, 20.35, 4070, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 200, 20.35, 4070, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 500, 20.35, 10175, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 500, 20.35, 10175, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 20.35, 2035, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 20.35, 2035, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTH-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 690, 41400, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 690, 41400, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUTC-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 36, 477.7, 17197.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 36, 477.7, 17197.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUSF-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 422.45, 25347, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 422.45, 25347, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 21, 520, 10920, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 21, 520, 10920, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WBRSPGUN-F75' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 40, 636, 25440, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 40, 636, 25440, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBTCKCLTH' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 30, 42, 1260, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 30, 42, 1260, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 48, 625, 30000, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 48, 625, 30000, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDAG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 731.025, 5848.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 731.025, 5848.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCRB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 685.9, 5487.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 685.9, 5487.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDMR-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 920.55, 7364.4, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 920.55, 7364.4, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDSB-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 685.9, 5487.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 685.9, 5487.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDCG-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 694.925, 5559.4, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 694.925, 5559.4, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'WCQDBP-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 857.375, 6859, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 857.375, 6859, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGFLTBLK-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 2002.6, 32041.6, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 2002.6, 32041.6, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGPUWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1795.2, 35904, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1795.2, 35904, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHGRN-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1776.5, 14212, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1776.5, 14212, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGTHBLU-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1955, 15640, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1955, 15640, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1975.4, 15803.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1975.4, 15803.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGMLYORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 8, 1776.5, 14212, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 8, 1776.5, 14212, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTORNGE-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3003.05, 12012.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3003.05, 12012.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PGGLEMSTWHT-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 3003.05, 12012.2, 'ADJUSTMENT (-)');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 3003.05, 12012.2, 'ADJUSTMENT (-): ST-00028', '2026-08-22'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310453229 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310453229', '2026-08-26'::timestamp, 91000, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 100, 910, 91000, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 100, 910, 91000, 'STOCK IN: DR-2310453229', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXE1313' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 24, 1305.001667, 31320.04, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 24, 1305.001667, 31320.04, 'STOCK IN: DR-2310453229', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310453244 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310453244', '2026-08-26'::timestamp, 63270.1776, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 37, 1710.0048, 63270.1776, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 37, 1710.0048, 63270.1776, 'STOCK IN: DR-2310453244', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1710.0048, 34200.096, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1710.0048, 34200.096, 'STOCK IN: DR-2310453244', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310453245 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310453245', '2026-08-26'::timestamp, 6840.02, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1710.005, 6840.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1710.005, 6840.02, 'STOCK IN: DR-2310453245', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310453772 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310453772', '2026-08-26'::timestamp, 110640.1, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPPBFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1844.001667, 110640.1, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1844.001667, 110640.1, 'STOCK IN: DR-2310453772', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310453813 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310453813', '2026-08-26'::timestamp, 101820.1, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MPABFC-5L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1697.001667, 101820.1, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1697.001667, 101820.1, 'STOCK IN: DR-2310453813', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310454704 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310454704', '2026-08-26'::timestamp, 18320.15, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 16, 1145.009375, 18320.15, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 16, 1145.009375, 18320.15, 'STOCK IN: DR-2310454704', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 9, 1743, 15687, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 9, 1743, 15687, 'STOCK IN: DR-2310454704', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310455287 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310455287', '2026-08-26'::timestamp, 4320.02, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ECO100-B' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 12, 360.0016667, 4320.02, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 12, 360.0016667, 4320.02, 'STOCK IN: DR-2310455287', '2026-08-26'::timestamp);
  END IF;

  -- Stock In Log Batch: DR-2310455007 (NIPPON PAINT (COATINGS) PHILS. INC.)
  SELECT id INTO v_supp_id FROM public.suppliers WHERE name = 'NIPPON PAINT (COATINGS) PHILS. INC.' LIMIT 1;
  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, received_by)
  VALUES (v_main_branch_id, v_supp_id, 'DR-2310455007', '2026-08-26'::timestamp, 17100.048, 'System Migration')
  RETURNING id INTO v_log_id;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 1710.0048, 17100.048, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 1710.0048, 17100.048, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 20, 1710.0048, 34200.096, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 20, 1710.0048, 34200.096, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NPA1983' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 60, 1245.0032, 74700.192, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 60, 1245.0032, 74700.192, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 2, 514.9984, 1029.9968, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 2, 514.9984, 1029.9968, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 10, 889, 8890, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 10, 889, 8890, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;
  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT103' AND branch_id = v_main_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost, total_cost, movement_type)
    VALUES (v_log_id, v_inv_id, 4, 1353.0048, 5412.0192, 'STOCK IN');
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, total_amount, reason, created_at)
    VALUES (v_inv_id, v_main_branch_id, 'IN', 4, 1353.0048, 5412.0192, 'STOCK IN: DR-2310455007', '2026-08-26'::timestamp);
  END IF;

  RAISE NOTICE 'Part 2 (Stock-In) completed successfully!';
END $$;
