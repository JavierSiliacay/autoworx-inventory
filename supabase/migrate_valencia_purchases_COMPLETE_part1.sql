
-- COMPLETE MIGRATION FOR VALENCIA PURCHASES (STOCK INS & ADJUSTMENTS) - PART 1
DO $$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  -- 1. DELETE ALL EXISTING MIGRATED STOCK TRANSACTIONS TO AVOID DUPLICATES
  DELETE FROM public.stock_transactions WHERE branch_id = v_branch_id AND reason LIKE 'Migration:%';
  DELETE FROM public.stock_in_logs WHERE branch_id = v_branch_id;

  DECLARE
    v_item_id UUID;
    v_supplier_id UUID;
    v_stock_in_id UUID;
  BEGIN

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'APC DISTRIBUTION - VALENCIA' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('APC DISTRIBUTION - VALENCIA', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'CSI-03664', '2026-04-25', 22861, '2026-04-25'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = '2B-PB-2' OR product_name = '2B PAINT BRUSH #2') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('2B PAINT BRUSH #2', '2B-PB-2', v_branch_id, 0, 30.5) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 30.5);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 30.5, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DOMBF-1L' OR product_name = 'DOMINO BODY FILTER WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'DOMBF-1L', v_branch_id, 0, 160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 160, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 720) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 720);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 720, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU7391-4L' OR product_name = 'NIPPON EXTREME QDU SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU SILVER 4L', 'NXU7391-4L', v_branch_id, 0, 2000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2000, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1965-4L' OR product_name = 'NIPPON EXTREME QDU BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU BLACK 4L', 'NXU1965-4L', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1850, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'POLYGTHIN-4L' OR product_name = 'POLYGLOSS URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('POLYGLOSS URETHANE THINNER 4L', 'POLYGTHIN-4L', v_branch_id, 0, 650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 650, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-SG-4L' OR product_name = 'RAIN OR SHINE STONE GRAY 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE STONE GRAY 4L', 'ROS-SG-4L', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 665, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX301' OR product_name = 'NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'NAX301', v_branch_id, 0, 900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 900, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROS-629-4L' OR product_name = 'RAIN OR SHINE ROS-629 TULIPS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'ROS-629-4L', v_branch_id, 0, 665) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 665);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 665, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLYZGBLK-48' OR product_name = 'PYLOX LAZER GLOSS BLACK 48') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER GLOSS BLACK 48', 'PLYZGBLK-48', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 95, 'Migration: ' || 'CSI-03664', '2026-04-25'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-1', '2026-03-31', 4779, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT904' OR product_name = 'NAX PREMILA MT904 SHADOWN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'MT904', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-1', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-2', '2026-03-31', 4683, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT903' OR product_name = 'NAX PREMILA MT903 SUN GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'MT903', v_branch_id, 0, 1561) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1561);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1561, 'Migration: ' || 'UNREF-2', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-3', '2026-03-31', 4779, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT902' OR product_name = 'NAX PREMILA MT902 GRASS GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT902 GRASS GREEN 1L', 'MT902', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-3', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-4', '2026-03-31', 4779, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT807' OR product_name = 'NAX PREMILA MT807 VACANCE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'MT807', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-4', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-5', '2026-03-31', 3186, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT806' OR product_name = 'NAX PREMILA MT806 HERMES BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'MT806', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1593, 'Migration: ' || 'UNREF-5', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-6', '2026-03-31', 1593, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT805' OR product_name = 'NAX PREMILA MT805 CUSTOM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'MT805', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || 'UNREF-6', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-7', '2026-03-31', 1593, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT804' OR product_name = 'NAX PREMILA MT804 ORIENT BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'MT804', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1593, 'Migration: ' || 'UNREF-7', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-8', '2026-03-31', 3186, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT803' OR product_name = 'NAX PREMILA MT803 FRESH BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'MT803', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1593, 'Migration: ' || 'UNREF-8', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-9', '2026-03-31', 4779, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT801' OR product_name = 'NAX PREMILA MT801 CYANINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'MT801', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-9', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-10', '2026-03-31', 7584, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT705' OR product_name = 'NAX PREMILA MT705 FLORA VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'MT705', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1896, 'Migration: ' || 'UNREF-10', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-11', '2026-03-31', 4779, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT704' OR product_name = 'NAX PREMILA MT704 FINE VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'MT704', v_branch_id, 0, 1593) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1593);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1593, 'Migration: ' || 'UNREF-11', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-12', '2026-03-31', 2048, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT607' OR product_name = 'NAX PREMILA MT607 AUTUMN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'MT607', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2048, 'Migration: ' || 'UNREF-12', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-13', '2026-03-31', 3216, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT606' OR product_name = 'NAX PREMILA MT606 GIRAFFE YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'MT606', v_branch_id, 0, 1608) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1608);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1608, 'Migration: ' || 'UNREF-13', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-14', '2026-03-31', 2048, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT604' OR product_name = 'NAX PREMILA MT604 EXTRA MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'MT604', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2048, 'Migration: ' || 'UNREF-14', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-15', '2026-03-31', 5688, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT603' OR product_name = 'NAX PREMILA MT603 CINQUASIA BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'MT603', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-15', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-16', '2026-03-31', 6906, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT602' OR product_name = 'NAX PREMILA MT602 PEGASUS MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'MT602', v_branch_id, 0, 2302) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2302);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2302, 'Migration: ' || 'UNREF-16', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-17', '2026-03-31', 5547, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT601' OR product_name = 'NAX PREMILA MT601 IRON RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT601 IRON RED 1L', 'MT601', v_branch_id, 0, 1849) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1849);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1849, 'Migration: ' || 'UNREF-17', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-18', '2026-03-31', 4698, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT508' OR product_name = 'NAX PREMILA MT508 INDIAN RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'MT508', v_branch_id, 0, 2349) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2349);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2349, 'Migration: ' || 'UNREF-18', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-19', '2026-03-31', 8601, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT507' OR product_name = 'NAX PREMILA MT507 RUBY RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'MT507', v_branch_id, 0, 2867) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2867);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2867, 'Migration: ' || 'UNREF-19', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-20', '2026-03-31', 5688, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT506' OR product_name = 'NAX PREMILA MT506 CINQUASIA RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'MT506', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-20', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-21', '2026-03-31', 8700, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT505' OR product_name = 'NAX PREMILA MT505 SPARK RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'MT505', v_branch_id, 0, 2900) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2900);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2900, 'Migration: ' || 'UNREF-21', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-22', '2026-03-31', 6144, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT501' OR product_name = 'NAX PREMILA MT501 STRONG RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'MT501', v_branch_id, 0, 2048) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2048);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2048, 'Migration: ' || 'UNREF-22', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-23', '2026-03-31', 1896, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT405' OR product_name = 'NAX PREMILA MT405 SUN ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'MT405', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1896, 'Migration: ' || 'UNREF-23', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-24', '2026-03-31', 4852, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT401' OR product_name = 'NAX PREMILA MT401 MAXIM ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'MT401', v_branch_id, 0, 2426) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2426);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2426, 'Migration: ' || 'UNREF-24', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-25', '2026-03-31', 5916, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT307' OR product_name = 'NAX PREMILA MT307 EXTRA YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'MT307', v_branch_id, 0, 2958) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2958);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2958, 'Migration: ' || 'UNREF-25', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-26', '2026-03-31', 3488, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT305' OR product_name = 'NAX PREMILA MT305 NATURAL YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'MT305', v_branch_id, 0, 1744) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1744);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1744, 'Migration: ' || 'UNREF-26', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-27', '2026-03-31', 7200, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT304' OR product_name = 'NAX PREMILA MT304 GAILY YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'MT304', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3600, 'Migration: ' || 'UNREF-27', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-28', '2026-03-31', 1896, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT303' OR product_name = 'NAX PREMILA MT303 FINE YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'MT303', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1896, 'Migration: ' || 'UNREF-28', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-29', '2026-03-31', 3792, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT302' OR product_name = 'NAX PREMILA MT302 JEWEL YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'MT302', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1896, 'Migration: ' || 'UNREF-29', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-30', '2026-03-31', 5688, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT301' OR product_name = 'NAX PREMILA MT301 MAPICO YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'MT301', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1896, 'Migration: ' || 'UNREF-30', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-31', '2026-03-31', 3336, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT203' OR product_name = 'NAX PREMILA MT203 DEEP BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'MT203', v_branch_id, 0, 1668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1668, 'Migration: ' || 'UNREF-31', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-32', '2026-03-31', 1090, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT202-1L' OR product_name = 'NAX PREMILA MT202 TINTING BLACK NP 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'MT202-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1090, 'Migration: ' || 'UNREF-32', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-33', '2026-03-31', 4360, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT201' OR product_name = 'NAX PREMILA MT201 BLUE BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'MT201', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1090, 'Migration: ' || 'UNREF-33', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-34', '2026-03-31', 3792, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT175' OR product_name = 'NAX PREMILA MT175 GRAPHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'MT175', v_branch_id, 0, 1896) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1896);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1896, 'Migration: ' || 'UNREF-34', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-35', '2026-03-31', 8988, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT172' OR product_name = 'NAX PREMILA MT172 OPAL COLOR 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'MT172', v_branch_id, 0, 2996) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2996);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2996, 'Migration: ' || 'UNREF-35', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-36', '2026-03-31', 2752, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT170' OR product_name = 'NAX PREMILA MT170 OPAL COLOR LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'MT170', v_branch_id, 0, 1376) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1376);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1376, 'Migration: ' || 'UNREF-36', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-37', '2026-03-31', 10100, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT136' OR product_name = 'NAX PREMILA MT136 METALLIC ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'MT136', v_branch_id, 0, 5050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 5050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 5050, 'Migration: ' || 'UNREF-37', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-38', '2026-03-31', 7200, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT134' OR product_name = 'NAX PREMILA MT134 METALLIC GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'MT134', v_branch_id, 0, 3600) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3600);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3600, 'Migration: ' || 'UNREF-38', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-39', '2026-03-31', 2180, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT103' OR product_name = 'NAX PREMILA MT103 WHITE LS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'MT103', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1090, 'Migration: ' || 'UNREF-39', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-40', '2026-03-31', 12480, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-4L' OR product_name = 'NAX PREMILA MT100 WHITE HS 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'MT100-4L', v_branch_id, 0, 4160) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 4160);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 4160, 'Migration: ' || 'UNREF-40', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-41', '2026-03-31', 6540, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT100-1L' OR product_name = 'NAX PREMILA MT100 WHITE HS 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'MT100-1L', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1090, 'Migration: ' || 'UNREF-41', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-42', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT096' OR product_name = 'NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'MT096', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 6000, 'Migration: ' || 'UNREF-42', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-43', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT093' OR product_name = 'NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'MT093', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-43', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-44', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT086' OR product_name = 'NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'MT086', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-44', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-45', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT085' OR product_name = 'NAX PREMILA MT085 MICA BASE 4G GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'MT085', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-45', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-46', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT083' OR product_name = 'NAX PREMILA MT083 MICA BASE 4R RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'MT083', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-46', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-47', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT081' OR product_name = 'NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'MT081', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-47', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-48', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT080' OR product_name = 'NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'MT080', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-48', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-49', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT079' OR product_name = 'NAX PREMILA MT079 MICA BASE 2V VIOLET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'MT079', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-49', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-50', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT078' OR product_name = 'NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'MT078', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-50', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-51', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT076' OR product_name = 'NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'MT076', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-51', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-52', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT075' OR product_name = 'NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'MT075', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-52', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-53', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT072' OR product_name = 'NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'MT072', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-53', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-54', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT071' OR product_name = 'NAX PREMILA MT071 MICA BASE 5B BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'MT071', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-54', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-55', '2026-03-31', 10950, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06M' OR product_name = 'NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'MT06M', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3650, 'Migration: ' || 'UNREF-55', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-56', '2026-03-31', 7300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06H' OR product_name = 'NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'MT06H', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3650, 'Migration: ' || 'UNREF-56', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-57', '2026-03-31', 7300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT06A' OR product_name = 'NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'MT06A', v_branch_id, 0, 3650) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3650);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3650, 'Migration: ' || 'UNREF-57', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-58', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT068' OR product_name = 'NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'MT068', v_branch_id, 0, 6000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 6000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 6000, 'Migration: ' || 'UNREF-58', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-59', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT067' OR product_name = 'NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'MT067', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-59', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-60', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT066' OR product_name = 'NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'MT066', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 3000, 'Migration: ' || 'UNREF-60', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-61', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT065' OR product_name = 'NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'MT065', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-61', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-62', '2026-03-31', 9000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT061' OR product_name = 'NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'MT061', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 3000, 'Migration: ' || 'UNREF-62', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-63', '2026-03-31', 6000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT051' OR product_name = 'NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'MT051', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 3000, 'Migration: ' || 'UNREF-63', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-64', '2026-03-31', 3000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT050' OR product_name = 'NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'MT050', v_branch_id, 0, 3000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 3000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 3000, 'Migration: ' || 'UNREF-64', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-65', '2026-03-31', 3990, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT033' OR product_name = 'NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'MT033', v_branch_id, 0, 1995) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1995);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1995, 'Migration: ' || 'UNREF-65', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-66', '2026-03-31', 1745, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT030' OR product_name = 'NAX PREMILA MT030 WHITE MET. SNOW FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'MT030', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-66', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-67', '2026-03-31', 6450, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT028' OR product_name = 'NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'MT028', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-67', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-68', '2026-03-31', 1745, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT025' OR product_name = 'NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'MT025', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-68', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-69', '2026-03-31', 5982, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT023' OR product_name = 'NAX PREMILA MT023 HIGH SPARKLE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'MT023', v_branch_id, 0, 1994) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1994);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1994, 'Migration: ' || 'UNREF-69', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-70', '2026-03-31', 1745, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT012' OR product_name = 'NAX PREMILA MT012 MET. BASE FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'MT012', v_branch_id, 0, 1745) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1745);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1745, 'Migration: ' || 'UNREF-70', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-71', '2026-03-31', 6450, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT008' OR product_name = 'NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'MT008', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-71', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-72', '2026-03-31', 4300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT006' OR product_name = 'NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'MT006', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2150, 'Migration: ' || 'UNREF-72', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-73', '2026-03-31', 4300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT004' OR product_name = 'NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'MT004', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2150, 'Migration: ' || 'UNREF-73', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-74', '2026-03-31', 2150, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT003' OR product_name = 'NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'MT003', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2150, 'Migration: ' || 'UNREF-74', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-75', '2026-03-31', 8600, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT002-1L' OR product_name = 'NAX PREMILA MT002 CRYSTAL SILVER FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'MT002-1L', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2150, 'Migration: ' || 'UNREF-75', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-76', '2026-03-31', 6450, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MT001' OR product_name = 'NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'MT001', v_branch_id, 0, 2150) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2150);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2150, 'Migration: ' || 'UNREF-76', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-77', '2026-03-31', 1326, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX1062' OR product_name = 'NAX NAT-1062 QDU 040 SUPER WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'NAX1062', v_branch_id, 0, 442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 442, 'Migration: ' || 'UNREF-77', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-78', '2026-03-31', 3375, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX10100' OR product_name = 'NAX NAT-10100 NH-585 PEARL WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'NAX10100', v_branch_id, 0, 675) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 675);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 675, 'Migration: ' || 'UNREF-78', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-79', '2026-03-31', 2460, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT992' OR product_name = 'NAX NAT-992 TTC BLACK NO.8 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'NAT992', v_branch_id, 0, 410) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 410);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 410, 'Migration: ' || 'UNREF-79', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-80', '2026-03-31', 15180, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-4L' OR product_name = 'NAX NAT-990 TTC BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 4L', 'NAT990-4L', v_branch_id, 0, 1518) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 1518);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 1518, 'Migration: ' || 'UNREF-80', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-81', '2026-03-31', 4499, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT990-1L' OR product_name = 'NAX NAT-990 TTC BLACK 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-990 TTC BLACK 1L', 'NAT990-1L', v_branch_id, 0, 409) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 409);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 409, 'Migration: ' || 'UNREF-81', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-82', '2026-03-31', 4980, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT745' OR product_name = 'NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'NAT745', v_branch_id, 0, 830) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 830);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 830, 'Migration: ' || 'UNREF-82', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-83', '2026-03-31', 2820, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT740' OR product_name = 'NAX NAT-740 TTC ULTRA FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'NAT740', v_branch_id, 0, 470) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 470);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 470, 'Migration: ' || 'UNREF-83', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-84', '2026-03-31', 2055, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT736' OR product_name = 'NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'NAT736', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 685, 'Migration: ' || 'UNREF-84', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-85', '2026-03-31', 3924, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT733' OR product_name = 'NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'NAT733', v_branch_id, 0, 436) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 436);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 436, 'Migration: ' || 'UNREF-85', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-86', '2026-03-31', 4560, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT729' OR product_name = 'NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'NAT729', v_branch_id, 0, 760) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 760);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 760, 'Migration: ' || 'UNREF-86', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-87', '2026-03-31', 995, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT728' OR product_name = 'NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'NAT728', v_branch_id, 0, 995) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 995);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 995, 'Migration: ' || 'UNREF-87', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-88', '2026-03-31', 6510, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT727' OR product_name = 'NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'NAT727', v_branch_id, 0, 1085) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1085);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1085, 'Migration: ' || 'UNREF-88', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-89', '2026-03-31', 3912, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT725' OR product_name = 'NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'NAT725', v_branch_id, 0, 652) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 652);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 652, 'Migration: ' || 'UNREF-89', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-90', '2026-03-31', 3726, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT720' OR product_name = 'NAX NAT-720 TTC SPARKLE WHITE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'NAT720', v_branch_id, 0, 621) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 621);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 621, 'Migration: ' || 'UNREF-90', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-91', '2026-03-31', 9300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-4L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'NAT719-4L', v_branch_id, 0, 2325) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2325);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2325, 'Migration: ' || 'UNREF-91', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-92', '2026-03-31', 5355, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT719-1L' OR product_name = 'NAX NAT-719 TTC COARSE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'NAT719-1L', v_branch_id, 0, 595) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 595);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 595, 'Migration: ' || 'UNREF-92', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-93', '2026-03-31', 2532, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT716' OR product_name = 'NAX NAT-716 TTC SPARKLE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'NAT716', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 422, 'Migration: ' || 'UNREF-93', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-94', '2026-03-31', 1266, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT715-1L' OR product_name = 'NAX NAT-715 TTC FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'NAT715-1L', v_branch_id, 0, 422) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 422);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 422, 'Migration: ' || 'UNREF-94', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-95', '2026-03-31', 4067, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT712-1L' OR product_name = 'NAX NAT-712 TTC MEDIUM FINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'NAT712-1L', v_branch_id, 0, 581) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 581);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 581, 'Migration: ' || 'UNREF-95', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-96', '2026-03-31', 2490, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT595' OR product_name = 'NAX NAT-595 TTC CYANINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'NAT595', v_branch_id, 0, 498) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 498);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 498, 'Migration: ' || 'UNREF-96', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-97', '2026-03-31', 2700, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT557' OR product_name = 'NAX NAT-557 TTC BLUE NO.9 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'NAT557', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 450, 'Migration: ' || 'UNREF-97', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-98', '2026-03-31', 1240, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT556' OR product_name = 'NAX NAT-556 TTC BLUE NO.8 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'NAT556', v_branch_id, 0, 620) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 620);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 620, 'Migration: ' || 'UNREF-98', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-99', '2026-03-31', 3102, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT555' OR product_name = 'NAX NAT-555 TTC BLUE NO.7 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'NAT555', v_branch_id, 0, 517) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 517);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 517, 'Migration: ' || 'UNREF-99', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-100', '2026-03-31', 870, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT550' OR product_name = 'NAX NAT-550 TTC SUPER BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'NAT550', v_branch_id, 0, 435) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 435);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 435, 'Migration: ' || 'UNREF-100', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-101', '2026-03-31', 3270, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT530' OR product_name = 'NAX NAT-530 TTC FINE BLUE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'NAT530', v_branch_id, 0, 1090) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1090);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1090, 'Migration: ' || 'UNREF-101', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-102', '2026-03-31', 2500, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT490' OR product_name = 'NAX NAT-490 TTC EVERGREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'NAT490', v_branch_id, 0, 500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 500, 'Migration: ' || 'UNREF-102', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-103', '2026-03-31', 4781, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT410' OR product_name = 'NAX NAT-410 TTC CYANINE GREEN 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'NAT410', v_branch_id, 0, 683) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 683);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 683, 'Migration: ' || 'UNREF-103', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-104', '2026-03-31', 3303, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT390' OR product_name = 'NAX NAT-390 TTC IRON YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'NAT390', v_branch_id, 0, 367) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 367);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 367, 'Migration: ' || 'UNREF-104', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-105', '2026-03-31', 4140, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT380' OR product_name = 'NAX NAT-380 TTC SUPER YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'NAT380', v_branch_id, 0, 1035) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1035);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1035, 'Migration: ' || 'UNREF-105', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-106', '2026-03-31', 9867, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT321' OR product_name = 'NAX NAT-321 TTC HOSTAPERM YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'NAT321', v_branch_id, 0, 897) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 11, 897);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 11, 897, 'Migration: ' || 'UNREF-106', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-107', '2026-03-31', 2975, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT320' OR product_name = 'NAX NAT-320 TTC GOLD YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'NAT320', v_branch_id, 0, 425) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 425);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 425, 'Migration: ' || 'UNREF-107', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-108', '2026-03-31', 6900, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT305' OR product_name = 'NAX NAT-305 TTC GREEN YELLOW 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'NAT305', v_branch_id, 0, 1380) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1380);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1380, 'Migration: ' || 'UNREF-108', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-109', '2026-03-31', 9066, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT210' OR product_name = 'NAX NAT-210 TTC SUPER ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'NAT210', v_branch_id, 0, 1511) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1511);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1511, 'Migration: ' || 'UNREF-109', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-110', '2026-03-31', 15750, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT196' OR product_name = 'NAX NAT-196 TTC PURPLISH RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'NAT196', v_branch_id, 0, 1125) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 14, 1125);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 14, 1125, 'Migration: ' || 'UNREF-110', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-111', '2026-03-31', 2160, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT192' OR product_name = 'NAX NAT-192 TTC BRIGHT RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'NAT192', v_branch_id, 0, 540) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 540);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 540, 'Migration: ' || 'UNREF-111', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-112', '2026-03-31', 1975, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT190' OR product_name = 'NAX NAT-190 TTC IRON RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-190 TTC IRON RED 1L', 'NAT190', v_branch_id, 0, 395) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 395);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 395, 'Migration: ' || 'UNREF-112', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-113', '2026-03-31', 5370, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT180' OR product_name = 'NAX NAT-180 TTC STRAWBERRY RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'NAT180', v_branch_id, 0, 895) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 895);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 895, 'Migration: ' || 'UNREF-113', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-114', '2026-03-31', 13320, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT149' OR product_name = 'NAX NAT-149 TTC DARK MAROON 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'NAT149', v_branch_id, 0, 1110) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1110);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1110, 'Migration: ' || 'UNREF-114', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-115', '2026-03-31', 10080, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT147' OR product_name = 'NAX NAT-147 TTC THRENE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'NAT147', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 1120, 'Migration: ' || 'UNREF-115', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-116', '2026-03-31', 15780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT143' OR product_name = 'NAX NAT-143 TTC FLAME RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'NAT143', v_branch_id, 0, 1315) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1315);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1315, 'Migration: ' || 'UNREF-116', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-117', '2026-03-31', 9252, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1305' OR product_name = 'NAX NAT-1305 TTC 211 MICA BASE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'NAT1305', v_branch_id, 0, 1542) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1542);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1542, 'Migration: ' || 'UNREF-117', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-118', '2026-03-31', 5868, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1304' OR product_name = 'NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'NAT1304', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1956, 'Migration: ' || 'UNREF-118', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-119', '2026-03-31', 11736, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1303' OR product_name = 'NAX NAT-1303 TTC OMEGA PEARL 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'NAT1303', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1956, 'Migration: ' || 'UNREF-119', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-120', '2026-03-31', 9780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1301' OR product_name = 'NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'NAT1301', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1956, 'Migration: ' || 'UNREF-120', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-121', '2026-03-31', 9780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1300' OR product_name = 'NAX NAT-1300 TTC CRYSTALLINE SILVER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'NAT1300', v_branch_id, 0, 1956) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 1956);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 1956, 'Migration: ' || 'UNREF-121', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-122', '2026-03-31', 9258, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1180' OR product_name = 'NAX NAT-1180 TTC OYSTER WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'NAT1180', v_branch_id, 0, 1543) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1543);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1543, 'Migration: ' || 'UNREF-122', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-123', '2026-03-31', 3990, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1175' OR product_name = 'NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'NAT1175', v_branch_id, 0, 798) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 798);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 798, 'Migration: ' || 'UNREF-123', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-124', '2026-03-31', 9594, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1173' OR product_name = 'NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'NAT1173', v_branch_id, 0, 1599) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1599);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1599, 'Migration: ' || 'UNREF-124', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-125', '2026-03-31', 5460, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1172' OR product_name = 'NAX NAT-1172 TTC BRIGHT GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'NAT1172', v_branch_id, 0, 910) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 910);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 910, 'Migration: ' || 'UNREF-125', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-126', '2026-03-31', 5040, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1171' OR product_name = 'NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'NAT1171', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 840);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 840, 'Migration: ' || 'UNREF-126', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-127', '2026-03-31', 5040, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1167' OR product_name = 'NAX NAT-1167 TTC PALE GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'NAT1167', v_branch_id, 0, 840) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 840);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 840, 'Migration: ' || 'UNREF-127', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-128', '2026-03-31', 5316, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1166' OR product_name = 'NAX NAT-1166 TTC EARTH BROWN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'NAT1166', v_branch_id, 0, 886) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 886);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 886, 'Migration: ' || 'UNREF-128', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-129', '2026-03-31', 780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1165' OR product_name = 'NAX NAT-1165 TTC HI-LITE RED 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'NAT1165', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 780, 'Migration: ' || 'UNREF-129', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-130', '2026-03-31', 1920, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1164' OR product_name = 'NAX NAT-1164 TTC BRIGHT GOLD MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'NAT1164', v_branch_id, 0, 640) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 640);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 640, 'Migration: ' || 'UNREF-130', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-131', '2026-03-31', 3900, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1163' OR product_name = 'NAX NAT-1163 TTC FINE GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'NAT1163', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 780, 'Migration: ' || 'UNREF-131', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-132', '2026-03-31', 4164, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1160' OR product_name = 'NAX NAT-1160 TTC RED COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'NAT1160', v_branch_id, 0, 694) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 694);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 694, 'Migration: ' || 'UNREF-132', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-133', '2026-03-31', 3120, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1158' OR product_name = 'NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'NAT1158', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 780, 'Migration: ' || 'UNREF-133', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-134', '2026-03-31', 2340, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1157' OR product_name = 'NAX NAT-1157 TTC BRIGHT COPPER MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'NAT1157', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 780, 'Migration: ' || 'UNREF-134', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-135', '2026-03-31', 1560, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1153' OR product_name = 'NAX NAT-1153 TTC SUPER RED MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'NAT1153', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 780, 'Migration: ' || 'UNREF-135', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-136', '2026-03-31', 2644, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1114' OR product_name = 'NAX NAT-1114 TTC GREEN MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'NAT1114', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 661, 'Migration: ' || 'UNREF-136', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-137', '2026-03-31', 1322, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1113' OR product_name = 'NAX NAT-1113 TTC FINE BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'NAT1113', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 661, 'Migration: ' || 'UNREF-137', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-138', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-4L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'NAT1110-4L', v_branch_id, 0, 2400) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 2400);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 2400, 'Migration: ' || 'UNREF-138', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-139', '2026-03-31', 3810, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1110-1L' OR product_name = 'NAX NAT-1110 TTC BRIGHT WHITE 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'NAT1110-1L', v_branch_id, 0, 635) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 635);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 635, 'Migration: ' || 'UNREF-139', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-140', '2026-03-31', 4674, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1107' OR product_name = 'NAX NAT-1107 TTC FINE RED MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'NAT1107', v_branch_id, 0, 779) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 779);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 779, 'Migration: ' || 'UNREF-140', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-141', '2026-03-31', 2589, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT1106' OR product_name = 'NAX NAT-1106 TTC PEARL BLUE MICA 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'NAT1106', v_branch_id, 0, 863) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 863);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 863, 'Migration: ' || 'UNREF-141', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-142', '2026-03-31', 7290, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT103' OR product_name = 'NAX NAT-103 TTC OPAL 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-103 TTC OPAL 1L', 'NAT103', v_branch_id, 0, 1215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1215);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1215, 'Migration: ' || 'UNREF-142', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-143', '2026-03-31', 3000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAT100-4L' OR product_name = 'NAX NAT-100 TTC WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAT-100 TTC WHITE 4L', 'NAT100-4L', v_branch_id, 0, 1500) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1500);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1500, 'Migration: ' || 'UNREF-143', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-144', '2026-03-31', 7455, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3901-4L' OR product_name = 'METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'MEG3901-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10.5, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 10.5, 710, 'Migration: ' || 'UNREF-144', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-145', '2026-03-31', 4966.25, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3602-4L' OR product_name = 'METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'MEG3602-4L', v_branch_id, 0, 685) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7.25, 685);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7.25, 685, 'Migration: ' || 'UNREF-145', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-146', '2026-03-31', 5790, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3100-1L' OR product_name = 'METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'MEG3100-1L', v_branch_id, 0, 193) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 30, 193);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 30, 193, 'Migration: ' || 'UNREF-146', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-147', '2026-03-31', 4664.7, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'MEG3001-4L' OR product_name = 'METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'MEG3001-4L', v_branch_id, 0, 710) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.57, 710);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6.57, 710, 'Migration: ' || 'UNREF-147', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-148', '2026-03-31', 4140, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-5L' OR product_name = 'NIPPON DOU CLASSIC SG 715 WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'DCSG715-5L', v_branch_id, 0, 828) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 828);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 828, 'Migration: ' || 'UNREF-148', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-149', '2026-03-31', 5360, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCSG715-15L' OR product_name = 'NIPPON DOU CLASSIC SG WHITE 715 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'DCSG715-15L', v_branch_id, 0, 2680) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 2680);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 2680, 'Migration: ' || 'UNREF-149', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-150', '2026-03-31', 1890, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-5L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'DCF701-5L', v_branch_id, 0, 630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 630, 'Migration: ' || 'UNREF-150', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-151', '2026-03-31', 1320, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-1L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'DCF701-1L', v_branch_id, 0, 165) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 165);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 165, 'Migration: ' || 'UNREF-151', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-152', '2026-03-31', 8520, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'DCF701-15L' OR product_name = 'NIPPON DOU CLASSIC FLAT WHITE 701 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'DCF701-15L', v_branch_id, 0, 2130) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2130);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2130, 'Migration: ' || 'UNREF-152', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-153', '2026-03-31', 14467, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-5L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'QSHG710-5L', v_branch_id, 0, 851) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 17, 851);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 17, 851, 'Migration: ' || 'UNREF-153', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-154', '2026-03-31', 9768, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'QSHG710-15L' OR product_name = 'Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'QSHG710-15L', v_branch_id, 0, 2442) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 2442);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 2442, 'Migration: ' || 'UNREF-154', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-155', '2026-03-31', 3490, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDRB-4L' OR product_name = 'PLATONE QDE ROYAL BLUE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE ROYAL BLUE 4L', 'PLQDRB-4L', v_branch_id, 0, 698) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 698);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 698, 'Migration: ' || 'UNREF-155', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-156', '2026-03-31', 732, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDJG-4L' OR product_name = 'PLATONE QDE JADE GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE JADE GREEN 4L', 'PLQDJG-4L', v_branch_id, 0, 732) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 732);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 732, 'Migration: ' || 'UNREF-156', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-157', '2026-03-31', 1546, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDIR-4L' OR product_name = 'PLATONE QDE INTERNATIONAL RED 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'PLQDIR-4L', v_branch_id, 0, 773) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 773);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 773, 'Migration: ' || 'UNREF-157', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-158', '2026-03-31', 2004, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDCB-4L' OR product_name = 'PLATONE QDE CHOCOLATE BROWN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'PLQDCB-4L', v_branch_id, 0, 668) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 668);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 668, 'Migration: ' || 'UNREF-158', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-159', '2026-03-31', 5288, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PLQDB-4L' OR product_name = 'PLATONE QDE BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PLATONE QDE BLACK 4L', 'PLQDB-4L', v_branch_id, 0, 661) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 661);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 661, 'Migration: ' || 'UNREF-159', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-160', '2026-03-31', 9780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'XTRMEQDWARMYLW-4L' OR product_name = 'NIPPON EXTREME QDU WARM YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'XTRMEQDWARMYLW-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1630, 'Migration: ' || 'UNREF-160', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-161', '2026-03-31', 3260, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4406-4L' OR product_name = 'NIPPON EXTREME QDU GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU GREEN 4L', 'NXU4406-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1630, 'Migration: ' || 'UNREF-161', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-162', '2026-03-31', 1550, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU4075-4L' OR product_name = 'NIPPON EXTREME QDU WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU WHITE 4L', 'NXU4075-4L', v_branch_id, 0, 1550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1550, 'Migration: ' || 'UNREF-162', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-163', '2026-03-31', 19560, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1338-4L' OR product_name = 'NIPPON EXTREME QDU YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'NXU1338-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1630, 'Migration: ' || 'UNREF-163', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-164', '2026-03-31', 6520, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXU1224-4L' OR product_name = 'NIPPON EXTREME QDU ORANGE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'NXU1224-4L', v_branch_id, 0, 1630) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 1630);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 1630, 'Migration: ' || 'UNREF-164', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-165', '2026-03-31', 850, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-BOT' OR product_name = 'UNO LACQUER THINNER BOT') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER BOT', 'UNOLT-BOT', v_branch_id, 0, 50) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 17, 50);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 17, 50, 'Migration: ' || 'UNREF-165', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-166', '2026-03-31', 1800, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'UNOLT-4L' OR product_name = 'UNO LACQUER THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('UNO LACQUER THINNER 4L', 'UNOLT-4L', v_branch_id, 0, 360) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5, 360);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5, 360, 'Migration: ' || 'UNREF-166', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-167', '2026-03-31', 510, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'TOUT-4L' OR product_name = 'TIMEOUT URETHANE THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('TIMEOUT URETHANE THINNER 4L', 'TOUT-4L', v_branch_id, 0, 510) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 510);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 510, 'Migration: ' || 'UNREF-167', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-168', '2026-03-31', 4323, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOB745' OR product_name = 'NAX SOB745 BLENDING THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOB745 BLENDING THINNER 4L', 'SOB745', v_branch_id, 0, 786) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5.5, 786);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5.5, 786, 'Migration: ' || 'UNREF-168', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-169', '2026-03-31', 10800, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS535' OR product_name = 'NIPPON ACRYLIC GLOSS THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'NAS535', v_branch_id, 0, 450) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 24, 450);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 24, 450, 'Migration: ' || 'UNREF-169', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-170', '2026-03-31', 3135, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'EPOXYTHNR-4L' OR product_name = 'NIPPON EPOXY THINNER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON EPOXY THINNER 4L', 'EPOXYTHNR-4L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 5.7, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 5.7, 550, 'Migration: ' || 'UNREF-170', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-171', '2026-03-31', 3090, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9700' OR product_name = 'NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'NP9700', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 1030, 'Migration: ' || 'UNREF-171', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-172', '2026-03-31', 9145.5, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NP9200' OR product_name = 'NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'NP9200', v_branch_id, 0, 871) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10.5, 871);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 10.5, 871, 'Migration: ' || 'UNREF-172', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-173', '2026-03-31', 25198, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX141' OR product_name = 'NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'NAX141', v_branch_id, 0, 344) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 73.25, 344);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 73.25, 344, 'Migration: ' || 'UNREF-173', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-174', '2026-03-31', 4600, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX108' OR product_name = 'NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'NAX108', v_branch_id, 0, 460) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 460);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 460, 'Migration: ' || 'UNREF-174', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-175', '2026-03-31', 1780, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'SOD145' OR product_name = 'NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'SOD145', v_branch_id, 0, 445) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 445);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 445, 'Migration: ' || 'UNREF-175', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-176', '2026-03-31', 6448, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI1680' OR product_name = 'NAX PP BUMPER PRIMER GRAY 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'PRI1680', v_branch_id, 0, 496) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 13, 496);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 13, 496, 'Migration: ' || 'UNREF-176', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-177', '2026-03-31', 565, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PUT3050-4KG' OR product_name = 'NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'PUT3050-4KG', v_branch_id, 0, 565) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 565);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 565, 'Migration: ' || 'UNREF-177', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-178', '2026-03-31', 9240, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE4090' OR product_name = 'NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'NXE4090', v_branch_id, 0, 1320) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 1320);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 1320, 'Migration: ' || 'UNREF-178', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-179', '2026-03-31', 8400, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NXE1988' OR product_name = 'NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'NXE1988', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 1050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 1050, 'Migration: ' || 'UNREF-179', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-180', '2026-03-31', 12000, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA4021' OR product_name = 'NIPPELAC ACE BRIGHT WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'NPA4021', v_branch_id, 0, 1000) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 12, 1000);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 12, 1000, 'Migration: ' || 'UNREF-180', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-181', '2026-03-31', 9450, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1983' OR product_name = 'NIPPELAC ACE JET BLACK 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE JET BLACK 4L', 'NPA1983', v_branch_id, 0, 1050) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9, 1050);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9, 1050, 'Migration: ' || 'UNREF-181', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-182', '2026-03-31', 6720, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1372' OR product_name = 'NIPPELAC ACE LEMON YELLOW 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'NPA1372', v_branch_id, 0, 1120) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1120);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1120, 'Migration: ' || 'UNREF-182', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-183', '2026-03-31', 14800, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1131' OR product_name = 'NIPPELAC ACE RED TRIPPLE 8 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE RED TRIPPLE 8 4L', 'NPA1131', v_branch_id, 0, 1850) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 8, 1850);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 8, 1850, 'Migration: ' || 'UNREF-183', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-184', '2026-03-31', 7290, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NPA1487' OR product_name = 'NIPPELAC ACE THALO GREEN 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPELAC ACE THALO GREEN 4L', 'NPA1487', v_branch_id, 0, 1215) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6, 1215);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6, 1215, 'Migration: ' || 'UNREF-184', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-185', '2026-03-31', 6300, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PNB100' OR product_name = 'NAX PREMILA NB100 B/C BINDER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'PNB100', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 3, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 3, 2100, 'Migration: ' || 'UNREF-185', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-186', '2026-03-31', 2100, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NB200' OR product_name = 'NAX PREMILA NB200 BINDER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA NB200 BINDER', 'NB200', v_branch_id, 0, 2100) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 2100);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 2100, 'Migration: ' || 'UNREF-186', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-187', '2026-03-31', 1030, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NB200-HAR' OR product_name = 'NAX PREMILA 2K NB200 HARDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX PREMILA 2K NB200 HARDENER', 'NB200-HAR', v_branch_id, 0, 1030) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1030);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1030, 'Migration: ' || 'UNREF-187', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-188', '2026-03-31', 9225, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFWE-4L' OR product_name = 'NIPPON FLATWALL ENAMEL WHITE 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'NFWE-4L', v_branch_id, 0, 615) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 615);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 615, 'Migration: ' || 'UNREF-188', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-189', '2026-03-31', 2640, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NCGL-4L' OR product_name = 'NIPPON CLEAR GLOSS LACQUER 4L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON CLEAR GLOSS LACQUER 4L', 'NCGL-4L', v_branch_id, 0, 660) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 4, 660);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 4, 660, 'Migration: ' || 'UNREF-189', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-190', '2026-03-31', 5510, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAX21' OR product_name = 'NAX NAX21 URETHANE HAEDENER') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX NAX21 URETHANE HAEDENER', 'NAX21', v_branch_id, 0, 190) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 29, 190);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 29, 190, 'Migration: ' || 'UNREF-190', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-191', '2026-03-31', 3571.92, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PRI3634' OR product_name = 'NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'PRI3634', v_branch_id, 0, 363) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 9.84, 363);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 9.84, 363, 'Migration: ' || 'UNREF-191', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-192', '2026-03-31', 5500, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'HS-1L' OR product_name = 'NIPPON HS FILLER 1L') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON HS FILLER 1L', 'HS-1L', v_branch_id, 0, 550) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 10, 550);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 10, 550, 'Migration: ' || 'UNREF-192', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-193', '2026-03-31', 1342, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NFI46G-5KG' OR product_name = 'NIPPON FLEXI-SEAL 146 GRAY 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'NFI46G-5KG', v_branch_id, 0, 1342) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 1, 1342);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 1, 1342, 'Migration: ' || 'UNREF-193', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-194', '2026-03-31', 2684, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NF145W-5KG' OR product_name = 'NIPPON FLEXI-SEAL 145 WHITE 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'NF145W-5KG', v_branch_id, 0, 1342) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 2, 1342);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 2, 1342, 'Migration: ' || 'UNREF-194', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-195', '2026-03-31', 2814, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'NAS-5G' OR product_name = 'NIPPON ACRYLIC SKIMCOAT 5KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'NAS-5G', v_branch_id, 0, 402) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 402);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 402, 'Migration: ' || 'UNREF-195', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-196', '2026-03-31', 7920, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'BSKSMCOAT-BAG' OR product_name = 'BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'BSKSMCOAT-BAG', v_branch_id, 0, 495) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 16, 495);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 16, 495, 'Migration: ' || 'UNREF-196', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-197', '2026-03-31', 5265, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBRC-1KG' OR product_name = 'ROBERLO RUBBING COMPOUND 1KG') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'ROBRC-1KG', v_branch_id, 0, 780) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 6.75, 780);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 6.75, 780, 'Migration: ' || 'UNREF-197', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-198', '2026-03-31', 165, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'ROBPNTSTRNR' OR product_name = 'ROBFILTER PAINT STRAINER 125M') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('ROBFILTER PAINT STRAINER 125M', 'ROBPNTSTRNR', v_branch_id, 0, 11) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 15, 11);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 15, 11, 'Migration: ' || 'UNREF-198', '2026-03-31'::timestamp);

  -- Supplier lookup
  SELECT id INTO v_supplier_id FROM public.suppliers WHERE name = 'INVENTORY - MARCH 31, 2026' AND branch_id = v_branch_id LIMIT 1;
  IF v_supplier_id IS NULL THEN
     INSERT INTO public.suppliers (name, branch_id) VALUES ('INVENTORY - MARCH 31, 2026', v_branch_id) RETURNING id INTO v_supplier_id;
  END IF;

  INSERT INTO public.stock_in_logs (branch_id, supplier_id, invoice_number, date_received, total_amount, created_at)
  VALUES (v_branch_id, v_supplier_id, 'UNREF-199', '2026-03-31', 665, '2026-03-31'::timestamp) RETURNING id INTO v_stock_in_id;

  -- Item lookup
  SELECT id INTO v_item_id FROM public.inventory WHERE (sku = 'PYLZWH-02' OR product_name = 'PYLOX LAZER WHITE 02') AND branch_id = v_branch_id LIMIT 1;
  IF v_item_id IS NULL THEN
    INSERT INTO public.inventory (product_name, sku, branch_id, quantity, cost) VALUES ('PYLOX LAZER WHITE 02', 'PYLZWH-02', v_branch_id, 0, 95) RETURNING id INTO v_item_id;
  END IF;

  INSERT INTO public.stock_in_items (stock_in_id, inventory_id, quantity_received, unit_cost)
  VALUES (v_stock_in_id, v_item_id, 7, 95);
  
  INSERT INTO public.stock_transactions (inventory_id, branch_id, type, quantity, unit_price, reason, created_at)
  VALUES (v_item_id, v_branch_id, 'IN', 7, 95, 'Migration: ' || 'UNREF-199', '2026-03-31'::timestamp);
  END;
END $$;
