-- Migrate Isuzu Stock In Data
DO $$
DECLARE
  v_supplier_id uuid;
  v_log_id uuid;
  v_inv_id uuid;
  v_branch_id uuid;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;

  -- ==============================================
  -- Invoice: ISUZU-SI-2026-06-09 | 2026-06-09 | INVENTORY BALANCE
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY BALANCE' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('INVENTORY BALANCE') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'ISUZU-SI-2026-06-09') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'ISUZU-SI-2026-06-09', '2026-06-09', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'ISUZU-SI-2026-06-09' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 4200);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 4200, 8400, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT401' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2000, 2000, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT085' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT303' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2000, 2000, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT307' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2021);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2021, 2021, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3680, 3680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1800);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1800, 1800, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT076' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3067.1984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3067.1984, 3067.1984, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT050' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT066' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3153.71);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3153.71, 3153.71, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 3000, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 3000, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT901' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT904' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT807' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT805' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT030' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 1840, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT806' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1699);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1699, 1699, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 192, 24.22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 192, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 192, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 24.22, 4650.24, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1/2MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 247, 15.73);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 247, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 247, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 15.73, 3885.31, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 95, 31.46);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 95, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 95, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 31.46, 2988.7, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 24, 64.58);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 64.58, 1549.92, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT190' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 357);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 357, 178.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 980, 490, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX3974' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 451);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 451, 112.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT390' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 371);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 371, 46.375, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT158' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1450, 1087.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 540);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 540, 405, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1450, 543.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT320' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 440);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 440, 330, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2.25, 353);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 353, 794.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 12, 160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 160, 1920, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 1065);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1065, 2130, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3, 930);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 930, 2790, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP8100T' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 1260);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1260, 5040, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 1125, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1668, 1668, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT390' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 371);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 371, 371, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT716' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 422);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 422, 844, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT595' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3, 550);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 550, 1650, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1450, 1450, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT190' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 357);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 357, 357, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT410' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 693);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 693, 693, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT556' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 651.4256);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 651.4256, 1302.8512, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT1164' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 640);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 640, 1280, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT192' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 540);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 540, 540, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT320' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 440);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 440, 440, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 409);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 409, 409, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 8, 496);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 496, 3968, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT380' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 1100);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1100, 4400, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT143' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1450, 8700, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT210' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6, 1600);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1600, 9600, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT321' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6, 980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 980, 5880, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT068' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 6320);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6320, 12640, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 6180);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6180, 12360, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 1125, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT806' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1698.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1698.9952, 1274.2464, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT078' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3220.8064);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3220.8064, 3220.8064, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1980, 1980, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 1125, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1980, 1980, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT078' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3220.8064);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3220.8064, 3220.8064, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2230);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2230, 2230, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1668, 834, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT705' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1896);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1896, 1422, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT175' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1499.9964, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT903' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1260, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT904' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 840, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT803' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1260, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT902' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1260, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2375);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2375, 1781.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT606' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840.0032, 920.0016, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2268, 1134, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT405' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 999.9976, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT501' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1499.9964, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT503' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1980, 495, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT401' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT307' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2020.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2020.9952, 1515.7464, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT305' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1835.8256);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1835.8256, 1835.8256, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT304' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3465);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3465, 3465, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT303' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT302' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1778.9968);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1778.9968, 1334.2476, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT033' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 1380, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 562.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 2159.9984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2159.9984, 539.9996, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1000SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 184, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 184, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 184, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 3404, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 101, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 101, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 101, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 28, 2828, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT601' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1849);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1849, 1386.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT025' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1745);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1745, 1308.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 2900);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2900, 362.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 1380, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT008' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 1612.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT006' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 268.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT004' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2230);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2230, 1672.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2200);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2200, 2200, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 1612.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT001' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2268, 1701, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT103' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1090);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1090, 545, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT050' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT051' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 1580, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 3650);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3650, 1368.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 3680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3680, 460, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 5123.5184);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 5123.5184, 1280.8796, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1668, 1251, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 281.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT201' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1125, 281.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT508' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2349);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2349, 1761.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT301' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840.0032, 920.0016, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT172' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.875, 6000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.875, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.875, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6000, 5250, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.875, 1585);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.875, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.875, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1585, 1386.875, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NB200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2100);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2100, 1575, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 243, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 243, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 243, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 4495.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 153, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 153, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 153, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 28, 4284, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 130, 13.2);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 130, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 130, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 13.2, 1716, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 200, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 200, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 200, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 3700, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 115, 13.2);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 115, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 115, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 13.2, 1518, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 243, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 243, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 243, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 4495.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 94, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 94, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 94, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 1739, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '240SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 220, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 220, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 220, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 18.5, 4070, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '60SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 99, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 99, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 99, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 28, 2772, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 151, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 151, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 151, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 28, 4228, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT804' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 840, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2955);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2955, 1477.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1800);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1800, 900, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 210, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT603' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2022.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2022.0032, 1516.5024, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT506' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 999.9976, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT704' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2022.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2022.0032, 1011.0016, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT805' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 420, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2292.9984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2292.9984, 2292.9984, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT065' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT066' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3153.71);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3153.71, 2365.2825, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT067' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 750, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT068' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 6320);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6320, 4740, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT093' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3153.7072);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3153.7072, 2365.2804, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT071' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT096' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 6180);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6180, 1545, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 790, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT078' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3220.8064);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3220.8064, 1610.4032, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT076' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3067.1984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3067.1984, 1533.5992, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT075' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT072' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3673.4992);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3673.4992, 1836.7496, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT080' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 2250, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT081' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 1500, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 395, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT085' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 1580, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT086' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 1580, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT030' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 920, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT030' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 0);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 0, 0, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT170' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 2370, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2845);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2845, 2133.75, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT175' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT603' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2022.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2022.0032, 2022.0032, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT172' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT705' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1896);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1896, 1896, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT601' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1849);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1849, 1849, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2900);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2900, 2900, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT071' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT025' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1745);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1745, 1745, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT028' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2268, 2268, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT903' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT033' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 1840, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT023' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1994);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1994, 1994, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT079' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06M' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3679.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3679.9952, 3679.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06A' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3650);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3650, 3650, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT508' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2349);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2349, 2349, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT080' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3000, 3000, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT061' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT075' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT305' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1835.8256);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1835.8256, 1835.8256, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT302' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1778.9968);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1778.9968, 1778.9968, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT701' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1800);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1800, 1800, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1680, 1680, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT170' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT506' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT103' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1090);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1090, 1090, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT304' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3465);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3465, 3465, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT134' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2845);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2845, 2845, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT086' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT136' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 5123.5184);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 5123.5184, 5123.5184, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT093' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3153.7072);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3153.7072, 3153.7072, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT301' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1840.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840.0032, 1840.0032, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX3974' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 29, 451);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 29, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 29, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 451, 13079, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT100-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6.25, 1545);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1545, 9656.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT990-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 1585);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1585, 3170, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLA-5615' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 855);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 855, 3420, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'GLA-5690' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3, 765);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 765, 2295, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 48, 930);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 48, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 48, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 930, 44640, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT712-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 2180);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2180, 817.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAT719-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 2325);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2325, 871.875, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT065' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT012' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840, 1840, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2375);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2375, 2375, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT001' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2268, 2268, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1668, 1668, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT008' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 2150, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT006' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 2150, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2150, 2150, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT051' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3160, 3160, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT501' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT704' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2022.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2022.0032, 2022.0032, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT405' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1999.9952);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1999.9952, 1999.9952, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT606' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1840.0032);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1840.0032, 1840.0032, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT505' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2900);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2900, 2900, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT604' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2159.9984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2159.9984, 2159.9984, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT602' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2375);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2375, 2375, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT507' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2955);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2955, 2955, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT072' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3673.4992);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 3673.4992, 3673.4992, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 61, 160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 61, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 61, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 160, 9760, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 7, 570);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 570, 3990, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 1160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1160, 4640, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 9.25, 780);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 9.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 9.25, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 780, 7215, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NUP3038' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1450, 4350, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NB100' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 16.5, 2165);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 16.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 16.5, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 2165, 35722.5, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'QDUWHTEXT' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1485);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1485, 1485, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.125, 6000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.125, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 6000, 6750, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9700' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 24, 1065);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 24, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 24, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 1065, 25560, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6, 445);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 445, 2670, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX108' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 43, 700);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 43, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 43, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 700, 30100, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 21.01016, 680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 21.01016, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 21.01016, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 680, 14286.9088, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NUH444-1L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 660);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 660, 2640, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3602-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 735);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 735, 1470, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.375, 710);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 710, 976.25, '2026-06-09');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3001-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.375, 710);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', '2026-06-09');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.375, 'Historical Stock In: ' || 'ISUZU-SI-2026-06-09', 710, 976.25, '2026-06-09');
  END IF;

  -- ==============================================
  -- Invoice: DR 1387 | 2026-06-24 | APC DISTRIBUTION
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('APC DISTRIBUTION') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1387') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1387', '2026-06-24', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1387' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT203' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1387', 1668, 1668, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT607' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 2292.9984);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1387', 2292.9984, 4585.9968, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT002' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1387', 2150, 4300, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT100-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 6000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1387', 6000, 12000, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 12, 680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: ' || 'DR 1387', 680, 8160, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'FF151' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 6, 1160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 6, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 6, 'Historical Stock In: ' || 'DR 1387', 1160, 6960, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 36, 353);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: ' || 'DR 1387', 353, 12708, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 8, 496);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 8, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 8, 'Historical Stock In: ' || 'DR 1387', 496, 3968, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0, 'Historical Stock In: ' || 'DR 1387', 18.5, 0, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 200, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 200, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 200, 'Historical Stock In: ' || 'DR 1387', 28, 5600, '2026-06-24');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'HSFNP' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 550);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1387', '2026-06-24');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1387', 550, 550, '2026-06-24');
  END IF;

  -- ==============================================
  -- Invoice: DR 1138 | 2026-06-27 | APC-AGORA
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC-AGORA' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('APC-AGORA') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1138') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1138', '2026-06-27', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1138' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'TCROB' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 50);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'DR 1138', '2026-06-27');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'DR 1138', 50, 200, '2026-06-27');
  END IF;

  -- ==============================================
  -- Invoice: DR 1397 | 2026-07-13 | APC DISTRIBUTION
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('APC DISTRIBUTION') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1397') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1397', '2026-07-13', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1397' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT202' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1280);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 1280, 1280, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT003' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2360);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 2360, 2360, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT801' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1850);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 1850, 1850, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT06H' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3750);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 3750, 3750, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT083' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3250);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 3250, 3250, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 18, 680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: ' || 'DR 1397', 680, 12240, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '3/4MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 128, 24.21875);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 128, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 128, 'Historical Stock In: ' || 'DR 1397', 24.21875, 3100, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '120SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 200, 22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 200, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 200, 'Historical Stock In: ' || 'DR 1397', 22, 4400, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '320SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 100, 22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: ' || 'DR 1397', 22, 2200, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 100, 22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: ' || 'DR 1397', 22, 2200, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 100, 22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: ' || 'DR 1397', 22, 2200, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 100, 22);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 100, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 100, 'Historical Stock In: ' || 'DR 1397', 22, 2200, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 12, 800);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: ' || 'DR 1397', 800, 9600, '2026-07-13');
  END IF;

  -- ==============================================
  -- Invoice: DR 1397 | 2026-07-13 | FROM STOCKS
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCKS' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('FROM STOCKS') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1397') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1397', '2026-07-13', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1397' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'DR 1397', 2403.78, 9615.12, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 2403.78, 2403.78, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 569.52);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'DR 1397', 569.52, 2278.08, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 2403.78, 2403.78, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'DR 1397', 2403.78, 9615.12, '2026-07-13');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1397', '2026-07-13');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1397', 2403.78, 2403.78, '2026-07-13');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-27 | APC DISTRIBUTION
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('APC DISTRIBUTION') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-27', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 12, 570);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 12, 'Historical Stock In: ' || 'DR 1412', '2026-07-27');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 12, 'Historical Stock In: ' || 'DR 1412', 570, 6840, '2026-07-27');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | TRANSFER TO MIXING AREA
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'TRANSFER TO MIXING AREA' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('TRANSFER TO MIXING AREA') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 1160, 1160, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | FROM STOCKS
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCKS' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('FROM STOCKS') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 375);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 375, 187.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 980, 490, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 451);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 451, 112.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 371);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 371, 46.375, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1450, 1087.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 540);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 540, 405, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'DR 1412', 1450, 543.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 440);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 440, 330, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1699);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1699, 1274.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1668, 834, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1896);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1896, 1422, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2000, 1500, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1680, 1260, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1680, 840, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1680, 1260, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1680, 1260, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2375);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2375, 1781.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1840, 920, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 2268, 1134, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 2000, 1000, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2000, 1500, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1980);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 1980, 495, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2021);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2021, 1515.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 2000, 2000, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1779);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1779, 1334.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1840, 1380, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1125, 562.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 2160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 2160, 540, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1849);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1849, 1386.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1745);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1745, 1308.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 2900);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 2900, 362.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1840, 1380, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2150, 1612.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 2150, 268.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2230);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2230, 1672.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2150);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2150, 1612.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2268);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2268, 1701, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1090);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1090, 545, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3160, 1580, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.375, 3650);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.375, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.375, 'Historical Stock In: ' || 'DR 1412', 3650, 1368.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 3680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 3680, 460, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 5123.52);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 5123.52, 1280.88, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 1668);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 1668, 1251, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 1125, 281.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1125);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 1125, 281.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2349);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2349, 1761.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1840, 920, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.875, 6000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.875, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.875, 'Historical Stock In: ' || 'DR 1412', 6000, 5250, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.875, 1585);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.875, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.875, 'Historical Stock In: ' || 'DR 1412', 1585, 1386.875, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3, 525);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3, 'Historical Stock In: ' || 'DR 1412', 525, 1575, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1680, 840, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2955);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 2955, 1477.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1800);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1800, 900, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 1680, 210, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2022);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2022, 1516.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 2000, 1000, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 2022);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 2022, 1011, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 1680, 420, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2293);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 2293, 2293, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3153.71);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3153.71, 2365.2825, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 3000, 750, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 6320);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 6320, 4740, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3153.71);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3153.71, 2365.2825, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 6180);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 6180, 1545, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 3160, 790, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3220.81);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3220.81, 1610.405, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3067.2);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3067.2, 1533.6, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3673.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3673.5, 1836.75, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3000, 2250, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3000);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3000, 1500, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.125, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.125, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.125, 'Historical Stock In: ' || 'DR 1412', 3160, 395, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3160, 1580, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 3160, 1580, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1840);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1840, 920, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 3160, 2370, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.75, 2845);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.75, 'Historical Stock In: ' || 'DR 1412', 2845, 2133.75, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | INVENTORY BALANCE
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY BALANCE' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('INVENTORY BALANCE') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '36FSPSUP' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 144, 67.3333);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 144, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 144, 'Historical Stock In: ' || 'DR 1412', 67.3333, 9695.9952, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | FROM STOCKS
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCKS' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('FROM STOCKS') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 386.25);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 386.25, 386.25, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.5, 545);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.5, 'Historical Stock In: ' || 'DR 1412', 545, 817.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.5, 581.25);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.5, 'Historical Stock In: ' || 'DR 1412', 581.25, 871.875, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 18, 541.25);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 18, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 18, 'Historical Stock In: ' || 'DR 1412', 541.25, 9742.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.5, 1500);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.5, 'Historical Stock In: ' || 'DR 1412', 1500, 750, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 3680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 3680, 3680, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 3160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 3160, 6320, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1450);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 1450, 1450, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 550);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 550, 550, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2293);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 2293, 2293, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | FOR EXPENSE
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FOR EXPENSE' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('FOR EXPENSE') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOB757' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.36484, 680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.36484, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.36484, 'Historical Stock In: ' || 'DR 1412', 680, 248.0912, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | ADDITIONAL BALANCE
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'ADDITIONAL BALANCE' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('ADDITIONAL BALANCE') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1/4MTCRO' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 15);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 15, 30, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1000SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4, 'Historical Stock In: ' || 'DR 1412', 18.5, 74, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1200SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 13, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 13, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 13, 'Historical Stock In: ' || 'DR 1412', 18.5, 240.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '1500SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 25, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 25, 'Historical Stock In: ' || 'DR 1412', 28, 700, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '2000SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 19, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 19, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 19, 'Historical Stock In: ' || 'DR 1412', 28, 532, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '400SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 15, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 15, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 15, 'Historical Stock In: ' || 'DR 1412', 18.5, 277.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '600SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 36, 18.5);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 36, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 36, 'Historical Stock In: ' || 'DR 1412', 18.5, 666, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '80SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 11, 28);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 11, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 11, 'Historical Stock In: ' || 'DR 1412', 28, 308, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = '800SPEAG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 7, 13.2);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 7, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 7, 'Historical Stock In: ' || 'DR 1412', 13.2, 92.4, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NP9200' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 4.75, 930);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 4.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 4.75, 'Historical Stock In: ' || 'DR 1412', 930, 4417.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI3634' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 353);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 353, 706, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MEG3901-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 0.25, 710);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 0.25, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 0.25, 'Historical Stock In: ' || 'DR 1412', 710, 177.5, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF1LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 160);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 160, 320, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'BF4LDOM' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 570);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 570, 1140, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'MT803' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 1680);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 1680, 1680, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NGMTX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.525, 2400);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.525, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.525, 'Historical Stock In: ' || 'DR 1412', 2400, 3660, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAX/EXTMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.625, 569.52);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.625, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.625, 'Historical Stock In: ' || 'DR 1412', 569.52, 925.47, '2026-07-25');
  END IF;

  -- ==============================================
  -- Invoice: DR 1412 | 2026-07-25 | FROM STOCKS
  -- ==============================================
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'FROM STOCKS' LIMIT 1;
  IF v_supplier_id IS NULL THEN
    INSERT INTO public.suppliers (name) VALUES ('FROM STOCKS') RETURNING id INTO v_supplier_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.stock_in_logs WHERE invoice_number = 'DR 1412') THEN
    INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount)
    VALUES (v_branch_id, v_supplier_id, 'DR 1412', '2026-07-25', 0)
    RETURNING id INTO v_log_id;
  ELSE
    SELECT id INTO v_log_id FROM public.stock_in_logs WHERE invoice_number = 'DR 1412' LIMIT 1;
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1, 2640);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1, 'Historical Stock In: ' || 'DR 1412', 2640, 2640, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'NAXISUTRA-4L' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 3.09375, 2420);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 3.09375, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 3.09375, 'Historical Stock In: ' || 'DR 1412', 2420, 7486.875, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PRI1680' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.5, 496);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.5, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.5, 'Historical Stock In: ' || 'DR 1412', 496, 744, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'PREMILAMIX' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 5.75, 2403.78);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 5.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 5.75, 'Historical Stock In: ' || 'DR 1412', 2403.78, 13821.735, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'ROBRC-1KG' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 2, 780);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 2, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 2, 'Historical Stock In: ' || 'DR 1412', 780, 1560, '2026-07-25');
  END IF;

  SELECT id INTO v_inv_id FROM public.inventory WHERE sku = 'SOD145' AND branch_id = v_branch_id LIMIT 1;
  IF v_inv_id IS NOT NULL THEN
    INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
    VALUES (v_log_id, v_inv_id, 1.75, 445);

    INSERT INTO public.transactions (item_id, module_type, transaction_type, quantity, remarks, timestamp)
    VALUES (v_inv_id, 'paints', 'inbound', 1.75, 'Historical Stock In: ' || 'DR 1412', '2026-07-25');

    INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, reason, unit_price, total_amount, created_at)
    VALUES (v_inv_id, v_branch_id, 'IN', 1.75, 'Historical Stock In: ' || 'DR 1412', 445, 778.75, '2026-07-25');
  END IF;

END $$;
