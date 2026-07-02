-- Migrate Historical Stock In
DO $$
DECLARE inv_id UUID;
BEGIN
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 50, 'Historical Migration', 'CSI-33977', 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', 1451.8, 72590, COALESCE('2026-05-30', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 30, 'Historical Migration', 'CSI-33977', 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', 1451.8, 43554, COALESCE('2026-05-30', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 120, 'Historical Migration', 'CSI-33977', 'GLOBAL SYNERGY TRADE AND DISTRIBUTION CORP.', 81.19, 9742.8, COALESCE('2026-05-30', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1451.8, 1451.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 550.53, 4404.24, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATFLWHT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 888.96, 10667.52, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 500, 3000, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATSGWHT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 929.58, 3718.32, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT2' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1448.4, 2896.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCBUMBR-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.42, 1906.08, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCVENRD-CAN' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 44, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 80.77, 3553.88, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPFLXWHT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 568.58, 7960.12, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPPUSLR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1064.95, 21299, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPPUTC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1344.73, 26894.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT1' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1448.4, 31864.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'APLT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 220, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 517.27, 113799.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPPUR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 694.93, 4169.58, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-1' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 168, 336, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-1 1/2' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 246.4, 2464, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 432, 1728, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-3' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 726.4, 5811.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPTRL-7' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 250, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 58.5, 14625, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPGLXWHT-16L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2608.23, 5216.46, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCBLK-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 45, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 27.98, 1259.1, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 37, 888, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 37, 888, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCRS-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 36.1, 866.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 18, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 37, 666, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 37, 888, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 34.75, 834, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCBR-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 87.54, 3151.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCBS-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 39, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 76.71, 2991.69, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCFYO-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 77.62, 931.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCHY-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 91.15, 3281.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCLB-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 71.3, 1711.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCRS-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 77.62, 1862.88, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCRU-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 72.2, 2599.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCTB-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 80.77, 1938.48, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPOTCTG-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 32, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 80.77, 2584.64, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCBS-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 105.59, 1267.08, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCBU-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 105.59, 2534.16, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVQDCG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 851, 16169, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCTB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 105.59, 1055.9, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOITTH-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 548, 13152, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 498, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 514.05, 255996.9, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1094.8, 21896, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 950, 19000, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXE1988' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', -2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1110, -2220, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXE4090' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', -3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1310, -3930, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXE1313' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1305, 13050, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB642' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 102, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 800, 81600, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1110-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2490, 9960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCTG-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 105.59, 1267.08, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCTR-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 100.18, 1202.16, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT719-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2573, 7719, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPLTCVR-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 99.28, 1191.36, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT100-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 4980, 29880, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SNDMSTER-36' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 9590, 9590, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 528, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 154.56, 81607.68, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-B' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 360, 4320, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 5575.48, 22301.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-CB' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3410, 44330, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-EY' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1370, 15070, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-V' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1030, 12360, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-T' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1160, 12760, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-A' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1100, 11000, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-OG' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1880, 24440, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PNB100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 55, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2158, 118690, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-E' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 580, 6960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-D' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 590, 4130, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-R' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 580, 6960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-HT' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2100, 23100, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-LR' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2260, 24860, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-F' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 610, 3660, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-OR' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 640, 3200, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ECO100-KX' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 630, 7560, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB745' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 48, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 691, 33168, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5436, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 545, 2962620, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX141' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1248, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 430, 536640, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX301' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 42, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 830, 34860, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 792, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 415, 328680, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX10100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 806, 11284, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT103' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1353, 13530, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX1062' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 581, 1162, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1106' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 996, 11952, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1107' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 11557, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1110-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 806, 6448, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1113' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 11557, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1114' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 676, 7436, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1153' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 913, 15521, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1157' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 18, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 16002, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1158' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 12446, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1160' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 830, 9960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1161' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 9779, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1163' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 17780, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1164' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 41, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 830, 34030, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1165' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 972, 16524, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1166' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1470, 29400, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1167' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1079, 23738, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1171' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1055, 29540, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1172' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1079, 23738, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1173' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1719, 13752, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1175' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 930, 9300, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1180' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1660, 36520, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1300' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 18, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2200, 39600, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1301' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2200, 37400, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1303' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 26, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2200, 57200, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1304' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2200, 15400, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1305' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 23, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1743, 40089, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT143' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1411, 31042, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT149' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1544, 15440, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT158-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1345, 22865, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT180' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1030, 10300, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT190' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 465, 4650, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT192' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 706, 8472, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT196' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1577, 20501, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT210' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1826, 29216, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT305' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1494, 17928, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT320' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 540, 15660, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT321' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1079, 16185, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1652, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 620, 1024240, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT380' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1295, 24605, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT390' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 482, 7712, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT3974' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 35, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 557, 19495, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT410' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 847, 6776, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 415, 11620, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT490' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 664, 12616, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NF146G-5KG' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1278, 1278, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'HIPROF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 622.73, 4981.84, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NF145W-5KG' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1278, 2556, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'LOPROF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 654.31, 5234.48, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT530' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1245, 19920, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT550' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 515, 7725, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT555' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 565, 6780, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT556' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 747, 14193, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT557' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 540, 10800, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT595' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 581, 9296, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT705-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 430, 7310, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT706-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 27, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 430, 11610, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT707-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 580, 8700, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT712-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 706, 4236, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT715-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 515, 2060, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT716' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 27, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 515, 13905, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT720' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 747, 21663, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT725' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 723, 20967, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT727' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1162, 33698, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT729' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 53, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 889, 47117, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT733' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 515, 12360, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT736' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 23, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 747, 17181, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT740' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 18, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 557, 10026, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT745' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 996, 28884, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 605, 4840, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'FF151' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 79, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1000, 79000, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT06M' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3569, 35690, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT001' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 42579, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT002-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 8964, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT003' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 17928, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT004' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 26892, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT006' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 26892, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT008' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 17928, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT012' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1909, 41998, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT023' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 18675, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPA4021' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1245, 4980, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT025' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1909, 13363, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT028' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 15687, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT030' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 32, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1909, 61088, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT033' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2241, 26892, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT050' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 30710, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT051' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3320, 79680, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT061' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 12284, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT065' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 36852, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPA1983' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1245, 19920, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT066' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 21497, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT067' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 24568, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT06A' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3569, 85656, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT06H' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3569, 42828, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT071' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 36852, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT072' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 36852, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT075' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 30710, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT076' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 58349, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT078' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 42994, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT079' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 24568, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT080' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 36852, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT081' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 27639, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT083' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 12284, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT085' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 33781, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT086' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 24568, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT093' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3071, 39923, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT096' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 5810, 29050, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT103' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1245, 2490, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT134' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3320, 29880, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT136' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 4980, 29880, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT170' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 22825, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT172' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3154, 34694, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT175' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 31, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1992, 61752, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPA1372' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 115, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1494, 171810, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT201' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1162, 23240, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT202-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1204, 15652, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT203' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1909, 22908, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT301' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2573, 41168, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT302' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2158, 28054, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT303' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 31125, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT304' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3486, 31374, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT305' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1951, 25363, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT307' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2988, 26892, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPA1131' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 29050, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT401' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2656, 18592, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT405' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 32, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3611, 115552, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPA1487' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1494, 7470, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ABM-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 659, 15816, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ASKM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 347.46, 5211.9, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DBM-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 670, 8040, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MPABFC-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1616, 1616, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PBM-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 714, 12138, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT501' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 39425, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT503' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2117, 14819, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NCGL-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 27, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 627, 16929, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT505' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2365.5, 28386, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPCGV-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 42, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1390, 58380, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT506' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 20750, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT507' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2905, 14525, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 6388.2, 12776.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS80' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 7434, 22302, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT508' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2573, 12865, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVEPOPTCH-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2655, 15930, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT601' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 8300, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT602' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2490, 14940, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT603' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 20750, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT604' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 24900, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT606' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1909, 13363, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT607' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2158, 17264, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT701' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1992, 9960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT704' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2905, 23240, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT705' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2075, 10375, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT801' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1743, 19173, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT803' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1826, 18260, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT804' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1826, 9130, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT805' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1826, 14608, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT806' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1826, 14608, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVOTCBLK-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 80, 160, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVOTCBLTNRD-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 96, 384, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVOTCBSNA-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 87, 1392, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVOTCRWSNA-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79, 79, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVOTCVNRED-1/4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 90, 720, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOIT-CAT' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 225.82, 8129.52, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NDFL-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 27, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 643, 17361, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DPB-4' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 72, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 93.33, 6719.76, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT807' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1743, 12201, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA60' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 400, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 29.7, 11880, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA80' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 300, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 27.5, 8250, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA1000' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 600, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 12210, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 500, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 10175, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA2000' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 500, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 27.5, 13750, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCABSG-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 37, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 895, 33115, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCDBSG-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 914, 10968, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCPBSG-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 972, 19440, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA220' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 300, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 6105, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCTBSG-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 934, 7472, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT903' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1743, 12201, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA240' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 900, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 18315, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 114, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1560, 177840, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT904' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1743, 12201, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA320' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 100, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 2035, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 5130, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NB200-HARD' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 685, 685, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA400' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 800, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 16280, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4406-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 18810, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 59, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 925, 54575, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA600' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 500, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 10175, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9700' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 132, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1145, 151140, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA800' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 600, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 20.35, 12210, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 18810, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOITSHLDALL-BOT' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 144, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 131.25, 18900, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 59, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 100890, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 108, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1560, 168480, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1338-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 21, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 35910, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1686, 5058, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MTLPRRO-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 490, 1960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MPPBFC-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1756, 1756, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEWHTE-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1124, 8992, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROADLNEREFBLACK-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1184, 8288, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROADLNEREFWHTE-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1184, 9472, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ABM-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 174, 1218, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PUTTYKNI #4' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 80, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 9, 720, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPQDWHT-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 194.94, 4678.56, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLTHGAB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 274, 4384, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLTHGDB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 280, 5600, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOITBLACK-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2100, 25200, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOITWHITE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1475.33, 8851.98, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPCGV-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 108, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 427, 46116, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQBLK-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 60, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 760, 45600, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DBM-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 176, 1056, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLTHGPB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 298, 5960, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLTHGTB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 286, 5720, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX21' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 349, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 165, 57585, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 770, 9240, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQGLDTNR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 868, 10416, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NFP-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 650, 7800, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ABM-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1877, 9385, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DBM-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1912, 7648, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PBM-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2036, 16288, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCABSG-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2551, 10204, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCDBSG-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2606, 18242, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 234, 936, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQINTRD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 896, 10752, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQLY-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1016, 16256, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQMETCRSE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 826.4, 23139.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQMETFNE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 826.4, 19833.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQMO-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 894.4, 7155.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQPUTYWH-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 778.4, 21795.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQTHBL-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 879.2, 10550.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQTHGR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 879.2, 3516.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMLCQWHTE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 760, 15200, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAECY-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 793.48, 9521.76, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGBNRED-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1965.2, 23582.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEIR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 793.48, 3173.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEFR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 793.48, 3173.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEMRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 793.48, 6347.84, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAETG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 793.48, 6347.84, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAETB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 772.55, 6180.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGBRTALUM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1796.05, 14368.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCTBSG-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2661, 7983, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEBLK-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 708.1, 7081, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEMF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 772.55, 6180.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEMC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 772.55, 6180.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEFB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 772.55, 3090.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLEPENCATYLW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1136.55, 4546.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLEPENTHGRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1094.8, 8758.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CUPBRSH' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 112, 448, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'HSCLR-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 72, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 625, 45000, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TBM-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 180, 720, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BUFFPAD' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 60, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 580, 34800, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TRAY' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 29, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 32, 928, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NONSAG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2564.32, 5128.64, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZANTPR-12' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 108, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 8624.88, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 242, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1355, 327910, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGGLEMSTMRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3003.05, 24024.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZAY-06' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 110, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 8784.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGGLEMSTORNGE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3003.05, 24024.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGGLEMSTRED-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3003.05, 33033.55, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGGLEMSTWHT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3003.05, 21021.35, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGGLEMSTYLW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 3003.05, 12012.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGLTYLW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1776.5, 12435.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGMRNTNR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1987.3, 9936.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGMICARDCRSE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2660.5, 37247, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGMICARDFNE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2660.5, 34586.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGMLYORNGE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1776.5, 17765, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDGRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2900.2, 34802.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDRD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2900.2, 11600.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGPRLFRSTDYL-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2900.2, 14501, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGPRLWHT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2900.2, 34802.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGPRMRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2312, 18496, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGRDGLD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1776.5, 8882.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGTHGRN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1776.5, 15988.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGVIOTNR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2291.6, 22916, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSTC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZCANRED-801' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 58, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 82.28, 4772.24, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZCLR-01' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 93, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 7426.98, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 891, 8910, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZDR-17' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 1756.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 222, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 480, 106560, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZDISIL-701' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 97.92, 2741.76, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4184-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 10260, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4197-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1910, 11460, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4168-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1910, 22920, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZFLOURANGE-601' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 127.16, 3560.48, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'XTRMEQDWARMYLW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1710, 27360, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZFLOUPNK-603' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 48, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 127.16, 6103.68, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MPJOINTCMPND-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 378, 1512, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLQDLY-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 965, 7720, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZFLOURED-602' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 127.16, 4577.76, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEBLK-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1124, 7868, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NONREFLCTVEYEL-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1124, 7868, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROADLNEREFYLW-5L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1184, 8288, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZFLOUVIO-604' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 10, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 127.16, 1271.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZFLOUYEL-600' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 123.42, 1481.04, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZGLBLK-48' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 54, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 4312.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PINEPENCLR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 18, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 924.48, 16640.64, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PINEPENINTRD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1056.24, 16899.84, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PINEPENLY-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 60, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1056.24, 63374.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCPBSG-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 234, 1404, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DCTBSG-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 224, 2688, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGYLGLD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2283.1, 34246.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'HS-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', -11, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 545, -5995, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGYLOXDE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 17, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1776.5, 30200.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PBM-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 6, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 188, 1128, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZGLD-705' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 60, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 95.04, 5702.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZGRY-45' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 2874.96, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZHTRSTSIL-709' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 28, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 146.2, 4093.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'HIHEAT' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 84, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 150.5, 12642, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZLTGR-33' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 50, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 3993, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZMTBLK-47' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 48, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 3833.28, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZMTW-03' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 46, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 3673.56, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSSG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 5054, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSTOG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 2527, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 7581, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSNP-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 14, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 8844.5, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSOSR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 812.25, 12996, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSIP-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSCT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSMW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 690.41, 5523.28, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSS-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZSIL-42' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 60, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 4791.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZSKBL-22' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 159.72, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZVIO-20' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 22, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 1756.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZWH-02' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 38, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 79.86, 3034.68, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'QSHG710-15L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 2550, 22950, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 218, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 582.67, 127022.06, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBPNTSTRNR' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 39, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 6.65, 259.35, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLLQWX-50ML' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 250, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 44.8, 11200, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 54, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 373.1, 20147.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 100, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 37.8, 3780, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RST-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 5, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 735.54, 3677.7, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSSB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSBGWN-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSHD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSTLPS-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 7581, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSGB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 690.41, 13808.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSBG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 12635, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSCNT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 15162, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSCW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSFM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 2527, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSLO-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1308.63, 20938.08, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSCM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 5054, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSXG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 7, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 609.19, 4264.33, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSL-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 10108, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSA-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 631.75, 5054, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 749.08, 8988.96, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSAB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 731.75, 5854, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACFRED-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1186.96, 17804.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACGLDTNR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1320.16, 15841.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACINTRD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 2, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1186.96, 2373.92, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACLMNYLW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 32, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 942.76, 30168.32, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACMETCRSE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1033.78, 20675.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACMETFNE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1033.78, 20675.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACMORNGE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 922.78, 11073.36, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACPG-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 876.9, 10522.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACPW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 19, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 876.9, 16661.1, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACREDGLD-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1168.46, 23369.2, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACTB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 13, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1140.34, 14824.42, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP8300-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 41, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1505, 61705, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI122' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 23, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 665, 15295, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 81, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 397.8, 32221.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'UNDRCOATGUN' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 15, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 576, 8640, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCFWE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 626.34, 15032.16, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCGLXWHT-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 140.79, 5068.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCMPRO-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 4, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 413.35, 1653.4, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'USAEPW-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 24, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 183, 4392, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'USAEPRO-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 48, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 166, 7968, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDBLK-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 151.62, 1819.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 20, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 613.7, 12274, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDCALORNGE-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 884.45, 7960.05, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDCB-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 151.62, 1819.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDCB-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 16, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 559.55, 8952.8, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACTHGR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 12, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 1050.06, 12600.72, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOAT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 570, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 636.48, 362793.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOACW-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 9, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 922.78, 8305.02, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 252, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 167.67, 42252.84, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 440, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 611.34, 268989.6, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOUT-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 36, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 698.88, 25159.68, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDM-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 8, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 694.93, 5559.44, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAS535' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', -3, 'Historical Migration', 'INV_06/4-11/26', 'INVENTORY - JUNE 4-11, 2026', 750, -2250, COALESCE('2026-06-04', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MSC' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 500, 'Historical Migration', NULL, 'JULIUS CAESAR AYING', 41, 20500, COALESCE('2026-06-16', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 180, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 620, 111600, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 180, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 360, 64800, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 240, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 545, 130800, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT712-1L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 6, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 706, 4236, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 36, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 925, 33300, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT203' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 4, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1909, 7636, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT503' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 4, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 2117, 8468, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'WCQDBLK-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 20, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 613.7, 12274, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX10100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 12, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 806, 9672, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 40, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1560, 62400, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 3, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1710, 5130, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PNB100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 20, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 2158, 43160, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATC-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 8, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 550.53, 4404.24, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPATR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 6, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 500, 3000, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 80, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 514.05, 41124, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 80, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1710, 136800, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1587-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 3, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1710, 5130, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CUMISPREME-FS60' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 1, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 6388.2, 6388.2, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 200, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 20.35, 4070, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 15, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 1451.8, 21777, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA240' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 400, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 20.35, 8140, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA400' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 500, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 20.35, 10175, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLQDIR-4L' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'OUT', 8, 'Historical Migration', 'ST-00027', 'APC DISTRIBUTION - VALENCIA', 891, 7128, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPSPGUN' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1, 'Historical Migration', NULL, 'NIPPON PAINT (COATINGS) PHILS. INC.', 13000, 13000, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA1500' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1000, 'Historical Migration', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 25.3, 25300, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA1200' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1500, 'Historical Migration', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 16.5, 24750, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA100' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 300, 'Historical Migration', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 25.3, 7590, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1500, 'Historical Migration', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 20.35, 30525, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA240' LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.stock_transactions (inventory_id, type, quantity, reason, reference_no, supplier, unit_price, total_amount, created_at)
    VALUES (inv_id, 'IN', 1000, 'Historical Migration', 'CSI-12780', 'QUADGROUP DISTRIBUTION INC.', 20.35, 20350, COALESCE('2026-06-25', timezone('utc'::text, now())));
  END IF;
END
$$;
