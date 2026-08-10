-- Migrate Isuzu Historical Sales
DO $$
DECLARE inv_id UUID;
DECLARE b_id UUID;
BEGIN
  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.1875, 5520, 0, 1035, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.1875, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.1875, 'Historical Sale: ' || 'CSI 004003', 5520, 1035, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004003', 820, 410, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004003', 710, 177.5, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 220, 0, 440, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004003', 220, 440, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 40, 0, 80, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004003', 40, 80, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004003', 25, 75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004003', 25, 75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004003', 25, 75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004003', 35, 105, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004003', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004003' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004003', 900, 225, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004004', 25, 75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004004', 35, 105, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004004', 4000, 100, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 590, 0, 590, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004004', 590, 590, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004004', 35, 70, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004004', 900, 225, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004004', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004004' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004004', 4000, 100, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 3145, 0, 1572.5, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004005', 3145, 1572.5, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004005', 1640, 820, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004005', 820, 410, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1195, 0, 298.75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004005', 1195, 298.75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004005', 35, 105, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1/2MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004005', 25, 25, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004005', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004005', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004005', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004005', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004005' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004005', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1075, 0, 268.75, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004006', 1075, 268.75, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004006', 820, 307.5, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004006', 1640, 820, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004006', 710, 177.5, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004006', 35, 105, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004006', 900, 225, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004006', 4000, 100, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004006', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004006', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004006', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004006' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004006', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 25, 50, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 35, 70, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-13', timezone('utc'::text, now())), 'CSI 004007', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004007' || ')', COALESCE('2026-06-13', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004007', 35, 70, COALESCE('2026-06-13', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1.5, 3270, 0, 4905, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004008', 3270, 4905, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1.5, 1640, 0, 2460, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004008', 1640, 2460, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004008', 820, 820, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004008', 710, 177.5, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004008', 25, 100, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004008', 25, 100, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 25, 0, 150, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004008', 25, 150, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 35, 0, 210, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004008', 35, 210, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 35, 0, 210, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004008', 35, 210, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004008', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1020, 0, 255, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004008' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004008', 1020, 255, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 5, 35, 0, 175, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004009', 35, 175, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004009', 900, 225, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004009', 4000, 100, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 40, 0, 120, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004009', 40, 120, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 590, 0, 590, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004009', 590, 590, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 5520, 0, 2760, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004009', 5520, 2760, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 710, 0, 1420, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004009', 710, 1420, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004009', 820, 820, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 25, 0, 250, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004009', 25, 250, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-17', timezone('utc'::text, now())), 'CSI 004009', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 35, 0, 140, 'System Migration', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004009' || ')', COALESCE('2026-06-17', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004009', 35, 140, COALESCE('2026-06-17', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3390, 0, 847.5, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004010', 3390, 847.5, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004010', 820, 307.5, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1640, 0, 410, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004010', 1640, 410, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004010', 3145, 786.25, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.125, 3145.04, 0, 393.13, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004010', 3145.04, 393.13, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.125, 3390, 0, 423.75, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004010', 3390, 423.75, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004010', 35, 35, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1/2MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004010', 25, 25, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1010, 0, 252.5, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004010', 1010, 252.5, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004010', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004010' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004010', 900, 225, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 75, 0, 75, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004011', 75, 75, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004011', 25, 50, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004011', 35, 70, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004011', 35, 70, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 25, 0, 250, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004011', 25, 250, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 25, 0, 250, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004011', 25, 250, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 35, 0, 350, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004011', 35, 350, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 35, 0, 350, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004011', 35, 350, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004011', 900, 225, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004011', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004011' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004011', 4000, 100, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1.5, 1075, 0, 1612.5, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004012', 1075, 1612.5, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 1640, 0, 3280, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004012', 1640, 3280, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004012', 820, 820, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 590, 0, 1180, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004012', 590, 1180, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1380, 0, 345, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004012', 1380, 345, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1.5, 710, 0, 1065, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004012', 710, 1065, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 5, 35, 0, 175, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004012', 35, 175, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '36FSPSUP' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 90, 0, 180, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004012', 90, 180, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 25, 0, 250, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004012', 25, 250, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-20', timezone('utc'::text, now())), 'CSI 004012', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 25, 0, 250, 'System Migration', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004012' || ')', COALESCE('2026-06-20', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004012', 25, 250, COALESCE('2026-06-20', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 3145, 0, 1572.5, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004013', 3145, 1572.5, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004013', 820, 307.5, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004013', 1640, 820, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 220, 0, 220, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004013', 220, 220, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 40, 0, 80, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 40, 80, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004013', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004013' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004013', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004014', 4000, 100, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004014', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004014' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004014', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004015', 3145, 786.25, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3390, 0, 847.5, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004015', 3390, 847.5, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004015', 1640, 820, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004015', 820, 307.5, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004015', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004015' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004015', 35, 70, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004016', 3145, 786.25, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004016', 820, 307.5, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1640, 0, 410, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004016', 1640, 410, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 220, 0, 220, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004016', 220, 220, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 40, 0, 40, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004016', 40, 40, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004016', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004016', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004016', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004016', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-24', timezone('utc'::text, now())), 'CSI 004016', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004016' || ')', COALESCE('2026-06-24', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004016', 25, 50, COALESCE('2026-06-24', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3390, 0, 847.5, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004017', 3390, 847.5, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004017', 820, 307.5, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 1640, 0, 410, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004017', 1640, 410, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.125, 3145.04, 0, 393.13, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004017', 3145.04, 393.13, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004017', 35, 70, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004017', 25, 25, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004017', 25, 25, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004017', 25, 25, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004017', 25, 25, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004017', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004017' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004017', 35, 35, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004018', 35, 35, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004018', 900, 225, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004018', 4000, 100, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 12, 25, 0, 300, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 12, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 12, 'Historical Sale: ' || 'CSI 004018', 25, 300, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 12, 35, 0, 420, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 12, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 12, 'Historical Sale: ' || 'CSI 004018', 35, 420, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 12, 35, 0, 420, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 12, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 12, 'Historical Sale: ' || 'CSI 004018', 35, 420, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 900, 0, 450, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004018', 900, 450, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004018', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.075, 4000, 0, 300, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.075, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004018' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.075, 'Historical Sale: ' || 'CSI 004018', 4000, 300, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 3145, 0, 12580, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004019', 3145, 12580, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 820, 0, 1640, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004019', 820, 1640, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 1940, 0, 5820, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004019', 1940, 5820, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 710, 0, 710, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004019', 710, 710, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1010, 0, 505, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004019', 1010, 505, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004019', 3145, 786.25, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 10, 35, 0, 350, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 10, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 10, 'Historical Sale: ' || 'CSI 004019', 35, 350, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004019', 25, 100, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004019', 25, 100, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-06-27', timezone('utc'::text, now())), 'CSI 004019', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004019' || ')', COALESCE('2026-06-27', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004019', 25, 100, COALESCE('2026-06-27', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 3390, 0, 1695, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004020', 3390, 1695, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004020', 820, 410, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004020', 1640, 820, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004020', 240, 240, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004020', 35, 70, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TCROB' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 85, 0, 85, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004020', 85, 85, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 40, 0, 40, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004020', 40, 40, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 40, 0, 40, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004020', 40, 40, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004020', 25, 75, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004020', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004020' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004020', 25, 75, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004021', 900, 225, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004021', 25, 50, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004021', 35, 70, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004021', 35, 70, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 100, 0, 100, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004021', 100, 100, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004021', 900, 225, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 240, 0, 480, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004021', 240, 480, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1075, 0, 537.5, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004021', 1075, 537.5, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004021', 820, 410, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-01', timezone('utc'::text, now())), 'CSI 004021', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004021' || ')', COALESCE('2026-07-01', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004021', 25, 50, COALESCE('2026-07-01', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 3145, 0, 1572.5, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004022', 3145, 1572.5, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004022', 1640, 820, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004022', 820, 410, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004022', 3145, 786.25, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 35, 70, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 25, 50, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 25, 50, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 25, 50, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 25, 50, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004022', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004022' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004022', 25, 50, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004023', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004023' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004023', 35, 70, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004023', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004023' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004023', 35, 70, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004023', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004023' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004023', 900, 225, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004023', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004023' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004023', 4000, 100, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-02', timezone('utc'::text, now())), 'CSI 004023', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.0625, 1020, 0, 63.75, 'System Migration', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.0625, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004023' || ')', COALESCE('2026-07-02', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.0625, 'Historical Sale: ' || 'CSI 004023', 1020, 63.75, COALESCE('2026-07-02', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.375, 5520, 0, 2070, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004024', 5520, 2070, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004024', 820, 820, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 710, 0, 355, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004024', 710, 355, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 680, 0, 680, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004024', 680, 680, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004024', 35, 70, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '36FSPSUP' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 120, 0, 120, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004024', 120, 120, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 40, 0, 40, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004024', 40, 40, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 40, 0, 40, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004024', 40, 40, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004024', 25, 100, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004024', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004024' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004024', 25, 100, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004025', 25, 100, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 25, 0, 100, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004025', 25, 100, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 4, 35, 0, 140, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004025', 35, 140, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 900, 0, 450, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004025', 900, 450, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.05, 4000, 0, 200, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.05, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.05, 'Historical Sale: ' || 'CSI 004025', 4000, 200, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004025', 240, 240, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004025', 25, 75, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 5, 25, 0, 125, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004025', 25, 125, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004025', 1640, 820, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-04', timezone('utc'::text, now())), 'CSI 004025', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 820, 0, 205, 'System Migration', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004025' || ')', COALESCE('2026-07-04', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004025', 820, 205, COALESCE('2026-07-04', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 3145, 0, 3145, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 3145, 3145, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 3390, 0, 3390, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 3390, 3390, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 820, 820, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 1640, 0, 1640, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 1640, 1640, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 710, 0, 710, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 710, 710, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 35, 0, 210, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004026', 35, 210, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004026', 240, 240, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 40, 0, 120, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004026', 40, 120, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 7, 25, 0, 175, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 7, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 7, 'Historical Sale: ' || 'CSI 004026', 25, 175, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004026', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004026' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004026', 25, 75, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 25, 0, 150, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004027', 25, 150, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 25, 0, 150, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004027', 25, 150, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 35, 0, 210, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004027', 35, 210, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 6, 35, 0, 210, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004027', 35, 210, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004027', 900, 225, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 0.125, 1020, 0, 127.5, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004027', 1020, 127.5, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'TCROB' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 85, 0, 85, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004027', 85, 85, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004027', 'NORTH-MIN AUTO DEALERSHIP INC.', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004027' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004027', 240, 240, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004028', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.03125, 5520, 0, 172.5, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.03125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004028' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.03125, 'Historical Sale: ' || 'CSI 004028', 5520, 172.5, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004028', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004028' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004028', 35, 35, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004028', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.125, 1075.04, 0, 134.38, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004028' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004028', 1075.04, 134.38, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004028', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004028' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004028', 35, 35, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004028', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004028' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004028', 820, 820, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 3390, 0, 1695, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004029', 3390, 1695, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004029', 820, 410, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004029', 1640, 820, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004029', 35, 105, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 25, 0, 75, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004029', 25, 75, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004029', 35, 105, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004029', 25, 50, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004029', 900, 225, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX3974' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-08', timezone('utc'::text, now())), 'CSI 004029', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.125, 1380, 0, 172.5, 'System Migration', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004029' || ')', COALESCE('2026-07-08', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004029', 1380, 172.5, COALESCE('2026-07-08', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1075, 0, 537.5, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004030', 1075, 537.5, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.375, 820, 0, 307.5, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.375, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.375, 'Historical Sale: ' || 'CSI 004030', 820, 307.5, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004030', 1640, 820, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 1010, 0, 252.5, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004030', 1010, 252.5, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004030', 3145, 786.25, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 35, 0, 35, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004030', 35, 35, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1/2MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004030', 25, 25, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004030', 25, 50, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 25, 0, 25, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004030', 25, 25, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004030', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004030' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004030', 25, 50, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004031', 35, 70, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004031', 35, 70, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004031', 900, 225, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004031', 710, 177.5, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004031', 35, 105, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004031', 240, 240, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004031', 1640, 820, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004031', 900, 225, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004031', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 25, 0, 125, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004031' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004031', 25, 125, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004032', 3145, 786.25, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004032', 820, 410, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004032', 1640, 820, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004032', 35, 105, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 25, 0, 50, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004032', 25, 50, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004032', 35, 70, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004032', 35, 70, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004032', 900, 225, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004032', 4000, 100, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-11', timezone('utc'::text, now())), 'CSI 004032', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004032' || ')', COALESCE('2026-07-11', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004032', 3145, 786.25, COALESCE('2026-07-11', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1075, 0, 537.5, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004033', 1075, 537.5, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004033', 1640, 820, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004033', 820, 410, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004033', 710, 177.5, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 2, 35, 0, 70, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 2, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 2, 'Historical Sale: ' || 'CSI 004033', 35, 70, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004033', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004033', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004033', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004033', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004033', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004033' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004033', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 40, 0, 120, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004034', 40, 120, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004034', 900, 225, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004034', 4000, 100, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.0625, 1020, 0, 63.75, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.0625, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.0625, 'Historical Sale: ' || 'CSI 004034', 1020, 63.75, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004034', 240, 240, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004034', 820, 410, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 3145, 0, 1572.5, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004034', 3145, 1572.5, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 3390, 0, 1695, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004034', 3390, 1695, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004034', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004034' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004034', 1640, 820, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1.5, 3145, 0, 4717.5, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004035', 3145, 4717.5, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 3390, 0, 3390, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004035', 3390, 3390, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004035', 820, 820, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1.5, 1640, 0, 2460, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004035', 1640, 2460, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 710, 0, 355, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004035', 710, 355, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004035', 240, 240, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004035', 35, 105, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 45, 0, 45, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004035', 45, 45, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004035', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004035', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004035' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004035', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 30, 150, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 40, 0, 200, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 40, 200, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 40, 0, 200, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004036', 40, 200, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 900, 0, 450, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004036', 900, 450, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.075, 4000, 0, 300, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.075, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.075, 'Historical Sale: ' || 'CSI 004036', 4000, 300, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004036', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.125, 1020, 0, 127.5, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004036' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004036', 1020, 127.5, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004037', 3145, 786.25, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 820, 0, 410, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004037', 820, 410, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1640, 0, 820, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004037', 1640, 820, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 35, 0, 105, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004037', 35, 105, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004037', 30, 90, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 40, 0, 120, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004037', 40, 120, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 40, 0, 120, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004037', 40, 120, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 900, 0, 225, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004037', 900, 225, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-15', timezone('utc'::text, now())), 'CSI 004037', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.025, 4000, 0, 100, 'System Migration', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.025, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004037' || ')', COALESCE('2026-07-15', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.025, 'Historical Sale: ' || 'CSI 004037', 4000, 100, COALESCE('2026-07-15', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1.5, 3145, 0, 4717.5, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004038', 3145, 4717.5, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1.5, 1640, 0, 2460, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1.5, 'Historical Sale: ' || 'CSI 004038', 1640, 2460, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004038', 820, 820, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 710, 0, 710, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004038', 710, 710, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 1010, 0, 505, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004038', 1010, 505, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 240, 0, 240, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004038', 240, 240, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 35, 0, 175, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004038', 35, 175, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004038', 30, 150, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004038', 30, 150, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004038', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004038' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004038', 30, 90, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004039', 30, 90, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004039', 30, 150, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 30, 0, 150, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004039', 30, 150, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 6, 30, 0, 180, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004039', 30, 180, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 6, 40, 0, 240, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004039', 40, 240, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 6, 40, 0, 240, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 6, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 6, 'Historical Sale: ' || 'CSI 004039', 40, 240, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 900, 0, 450, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004039', 900, 450, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.05, 4000, 0, 200, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.05, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.05, 'Historical Sale: ' || 'CSI 004039', 4000, 200, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3145, 0, 786.25, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004039', 3145, 786.25, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-18', timezone('utc'::text, now())), 'CSI 004039', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 3390, 0, 847.5, 'System Migration', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004039' || ')', COALESCE('2026-07-18', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004039', 3390, 847.5, COALESCE('2026-07-18', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 3390, 0, 3390, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004040', 3390, 3390, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 820, 0, 820, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004040', 820, 820, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 1, 1640, 0, 1640, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 1, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 1, 'Historical Sale: ' || 'CSI 004040', 1640, 1640, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.25, 710, 0, 177.5, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.25, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.25, 'Historical Sale: ' || 'CSI 004040', 710, 177.5, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 5, 35, 0, 175, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 5, 'Historical Sale: ' || 'CSI 004040', 35, 175, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.5, 900, 0, 450, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.5, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.5, 'Historical Sale: ' || 'CSI 004040', 900, 450, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004040', 30, 90, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 3, 30, 0, 90, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 3, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 3, 'Historical Sale: ' || 'CSI 004040', 30, 90, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 4, 30, 0, 120, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004040', 30, 120, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004040', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 4, 30, 0, 120, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004040' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004040', 30, 120, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004041', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 4, 40, 0, 160, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 4, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004041' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 4, 'Historical Sale: ' || 'CSI 004041', 40, 160, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

  SELECT id INTO inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = b_id LIMIT 1;
  IF FOUND THEN
    INSERT INTO public.sales (date, invoice_no, customer_name, payment_type, branch_id, item_id, quantity, unit_price, unit_cost, total_amount, performed_by, created_at)
    VALUES (COALESCE('2026-07-22', timezone('utc'::text, now())), 'CSI 004041', 'NORTH-MIN AUTO DEALERSHIP INC', 'Charge', b_id, inv_id, 0.125, 1020, 0, 127.5, 'System Migration', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.transactions (item_id, quantity, transaction_type, module_type, performed_by, remarks, timestamp)
    VALUES (inv_id, 0.125, 'outbound', 'paints', '00000000-0000-0000-0000-000000000000', 'Historical Sale Migration (Inv: ' || 'CSI 004041' || ')', COALESCE('2026-07-22', timezone('utc'::text, now())));
    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (inv_id, b_id, 'OUT', 0.125, 'Historical Sale: ' || 'CSI 004041', 1020, 127.5, COALESCE('2026-07-22', timezone('utc'::text, now())));
  END IF;

END $$;
