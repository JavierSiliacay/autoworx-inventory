-- Migrate Historical Sales
DO $$
DECLARE inv_id UUID;
DECLARE b_id UUID;
BEGIN
  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;
  IF b_id IS NULL THEN
    SELECT id INTO b_id FROM public.branches ORDER BY created_at LIMIT 1;
  END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI-004306', 'CAR CRAZY', 'Charge', b_id, inv_id, 24, 725, 0, 17400, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI-004306', 'CAR CRAZY', 'Charge', b_id, inv_id, 3, 2300, 0, 6900, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI-004306', 'CAR CRAZY', 'Charge', b_id, inv_id, 2, 3000, 0, 6000, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-15', timezone('utc'::text, now())), 'CSI-004307', 'JJ PAINT CENTER', 'Charge', b_id, inv_id, 30, 730, 0, 21900, 'System Migration', COALESCE('2026-06-15', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-15', timezone('utc'::text, now())), 'CSI-004307', 'JJ PAINT CENTER', 'Charge', b_id, inv_id, 6, 860, 0, 5160, 'System Migration', COALESCE('2026-06-15', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 2850, 0, 2850, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 2550, 0, 2550, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 2700, 0, 2700, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 6000, 0, 6000, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 2500, 0, 2500, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 3500, 0, 3500, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 4000, 0, 4000, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 1, 2300, 0, 2300, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004308', 'KING V PAINT CENTER', 'Charge', b_id, inv_id, 4, 2600, 0, 10400, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-16', timezone('utc'::text, now())), 'CSI-004309', 'CAR CRAZY', 'Charge', b_id, inv_id, 60, 65, 0, 3900, 'System Migration', COALESCE('2026-06-16', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'USAEPRO-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-18', timezone('utc'::text, now())), 'CSI-004310', 'ARKO ENTERPRISES', 'Charge', b_id, inv_id, 48, 240, 0, 11520, 'System Migration', COALESCE('2026-06-18', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-18', timezone('utc'::text, now())), 'CSI-004310', 'ARKO ENTERPRISES', 'Charge', b_id, inv_id, 48, 195, 0, 9360, 'System Migration', COALESCE('2026-06-18', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 48, 450, 0, 21600, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 8, 570, 0, 4560, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 8, 635, 0, 5080, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4113-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 8, 1800, 0, 14400, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 24, 560, 0, 13440, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSMW-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 4, 730, 0, 2920, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-SACHET' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 50, 65, 0, 3250, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLAEBLK-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 10, 780, 0, 7800, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MPTBFC-5L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 2, 1690, 0, 3380, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1161' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 4, 940, 0, 3760, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 24, 180, 0, 4320, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 30, 680, 0, 20400, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PLQDCB-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 4, 730, 0, 2920, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'GLEENTB-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 12, 1240, 0, 14880, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DVQDCG-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1385', 'APC AGORA', 'Charge', b_id, inv_id, 4, 860, 0, 3440, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 8, 1640, 0, 13120, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 8, 1800, 0, 14400, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX21' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 240, 225, 0, 54000, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 4, 2010, 0, 8040, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 120, 560, 0, 67200, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 3, 2705, 0, 8115, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT715-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 4, 545, 0, 2180, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 60, 450, 0, 27000, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 24, 570, 0, 13680, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 20, 635, 0, 12700, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 60, 680, 0, 40800, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 400, 45, 0, 18000, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOITTH-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 24, 600, 0, 14400, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1164' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 12, 875, 0, 10500, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BUFFPAD' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1383', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 5, 670, 0, 3350, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA240' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1384', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 500, 22, 0, 11000, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1384', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 10, 1550, 0, 15500, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'DR-1384', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 12, 650, 0, 7800, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MSC' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 40, 45, 0, 1800, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ALPGLXWHT-16L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 2, 2775, 0, 5550, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 20, 570, 0, 11400, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-2 1/2' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 4, 465, 0, 1860, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 48, 560, 0, 26880, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 300, 18.5, 0, 5550, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLLQWX-50ML' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 50, 65, 0, 3250, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 6, 650, 0, 3900, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PYLZPRGR-145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 24, 95, 0, 2280, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RST-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 4, 890, 0, 3560, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'RSHD-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 4, 740, 0, 2960, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 20, 570, 0, 11400, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU7391-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 4, 1800, 0, 7200, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPB-1' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 2, 300, 0, 600, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 3, 1550, 0, 4650, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2BPTRL-7' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1386', 'APC AGORA', 'Charge', b_id, inv_id, 50, 65, 0, 3250, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 1, 2010, 0, 2010, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 2, 2280, 0, 4560, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT002-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 2, 2360, 0, 4720, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 2, 5240, 0, 10480, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 12, 680, 0, 8160, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 6, 1100, 0, 6600, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 36, 450, 0, 16200, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 8, 635, 0, 5080, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 300, 22, 0, 6600, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA2000' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 200, 29, 0, 5800, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'HS-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'DR-1387', 'APC AGORA_ISUZU', 'Charge', b_id, inv_id, 1, 575, 0, 575, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT3/4' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', b_id, inv_id, 5, 1570, 0, 7850, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', b_id, inv_id, 8, 620, 0, 4960, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TLRUBCMP-CAN' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI-004311', 'MATTEO PAINT CENTER', 'Charge', b_id, inv_id, 27, 480, 0, 12960, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NPSPGUN' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-25', timezone('utc'::text, now())), 'CSI-004313', 'AUTOWORX REPAIR AND GENERAL MDSE. CO. LTD', 'Charge', b_id, inv_id, 1, 13000, 0, 13000, 'System Migration', COALESCE('2026-06-25', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TOBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-25', timezone('utc'::text, now())), 'CSI-004312', 'MATTEO PAINT CENTER', 'Charge', b_id, inv_id, 8, 720, 0, 5760, 'System Migration', COALESCE('2026-06-25', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-25', timezone('utc'::text, now())), 'CSI-004312', 'MATTEO PAINT CENTER', 'Charge', b_id, inv_id, 48, 500, 0, 24000, 'System Migration', COALESCE('2026-06-25', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP8100T-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-26', timezone('utc'::text, now())), 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', b_id, inv_id, 24, 1500, 0, 36000, 'System Migration', COALESCE('2026-06-26', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-26', timezone('utc'::text, now())), 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', b_id, inv_id, 24, 1350, 0, 32400, 'System Migration', COALESCE('2026-06-26', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-26', timezone('utc'::text, now())), 'CSI-004314', 'JAMS PAINT HAUZ', 'Charge', b_id, inv_id, 12, 500, 0, 6000, 'System Migration', COALESCE('2026-06-26', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI-15413', 'JAMES PAINT CENTER', 'Cash', b_id, inv_id, 12, 195, 0, 2340, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI-15413', 'JAMES PAINT CENTER', 'Cash', b_id, inv_id, 4, 620, 0, 2480, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EPOXYTHNR-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 25, 650, 0, 16250, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA1200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 500, 22, 0, 11000, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA1500' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 500, 28, 0, 14000, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 120, 560, 0, 67200, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 60, 680, 0, 40800, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB642' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 36, 840, 0, 30240, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU4075-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 12, 1640, 0, 19680, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NXU1965-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 12, 1640, 0, 19680, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PNB100' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 4, 2280, 0, 9120, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 30, 800, 0, 24000, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT1106' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 6, 1050, 0, 6300, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT202-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 4, 1280, 0, 5120, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'CRO-MT1/2' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 5, 1550, 0, 7750, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'DOMBF-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1388', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 24, 180, 0, 4320, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA120' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1389', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 300, 22, 0, 6600, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'EA400' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1389', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 200, 22, 0, 4400, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1389', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 6, 745, 0, 4470, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1389', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 4, 3750, 0, 15000, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PGZNCPR-1L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'DR-1389', 'APC KAUSWAGAN', 'Charge', b_id, inv_id, 36, 560, 0, 20160, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1532P-5L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'CSI-15430', 'JOEM TADURA', 'Cash', b_id, inv_id, 4, 2521.2, 0, 10084.8, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2099A-5L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'CSI-15430', 'JOEM TADURA', 'Cash', b_id, inv_id, 2, 3118.5, 0, 6237, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2123A-5L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'CSI-15430', 'JOEM TADURA', 'Cash', b_id, inv_id, 3, 2821.5, 0, 8464.5, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
  SELECT id INTO inv_id FROM public.inventory WHERE sku = '145(N1)-5L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-29', timezone('utc'::text, now())), 'CSI-15430', 'JOEM TADURA', 'Cash', b_id, inv_id, 1, 2310.33, 0, 2310.33, 'System Migration', COALESCE('2026-06-29', timezone('utc'::text, now())));
    \n    UPDATE public.inventory SET quantity = quantity - (SELECT quantity FROM public.transactions WHERE id = currval(\'transactions_id_seq\')) WHERE id = inv_id;
END IF;
END
$$;
