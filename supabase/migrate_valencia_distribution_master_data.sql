-- ====================================================================
-- VALENCIA DISTRIBUTION MASTER DATA MIGRATION
-- Target Branch: Valencia Distribution
-- Total Master Items: 646
-- Total Suppliers: 3
-- Total Customers: 10
-- ====================================================================
DO $MIGRATION$
DECLARE
  v_branch_id UUID;
BEGIN
  -- 1. Find Valencia Distribution Branch ID
  SELECT id INTO v_branch_id FROM public.branches 
  WHERE name ILIKE '%Valencia Distribution%' 
  LIMIT 1;

  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia Distribution not found in database!';
  END IF;

  -- ==================================================================
  -- SECTION 1: SUPPLIERS LIST
  -- ==================================================================
  -- Supplier: INVENTORY JUNE 24-25 2026
  INSERT INTO public.suppliers (name, tin, address, contact_number, branch_id)
  SELECT 'INVENTORY JUNE 24-25 2026', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY JUNE 24-25 2026' AND branch_id = v_branch_id);

  -- Supplier: INVENTORY JULY 26-27 2026
  INSERT INTO public.suppliers (name, tin, address, contact_number, branch_id)
  SELECT 'INVENTORY JULY 26-27 2026', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'INVENTORY JULY 26-27 2026' AND branch_id = v_branch_id);

  -- Supplier: APC DISTRIBUTION MAIN
  INSERT INTO public.suppliers (name, tin, address, contact_number, branch_id)
  SELECT 'APC DISTRIBUTION MAIN', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.suppliers WHERE name = 'APC DISTRIBUTION MAIN' AND branch_id = v_branch_id);

  -- ==================================================================
  -- SECTION 2: CUSTOMERS LIST
  -- ==================================================================
  -- Customer: ERT ENTERPRISES (CUST_00001)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00001-VALENCIA_DIST', 'ERT ENTERPRISES', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'ERT ENTERPRISES' AND branch_id = v_branch_id);

  -- Customer: JFJ SURPLUS (CUST_00002)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00002-VALENCIA_DIST', 'JFJ SURPLUS', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JFJ SURPLUS' AND branch_id = v_branch_id);

  -- Customer: JOVANNI VILLAFUERTE (CUST_00003)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00003-VALENCIA_DIST', 'JOVANNI VILLAFUERTE', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JOVANNI VILLAFUERTE' AND branch_id = v_branch_id);

  -- Customer: DUENAS HARDWARE (CUST_00004)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00004-VALENCIA_DIST', 'DUENAS HARDWARE', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'DUENAS HARDWARE' AND branch_id = v_branch_id);

  -- Customer: VALENCIA COLOURSMILE PAINT TRADING (CUST_00005)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00005-VALENCIA_DIST', 'VALENCIA COLOURSMILE PAINT TRADING', 'Alkuino Bldg. Sayre Highway, Poblacion, Valencia City', '90 DAYS', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'VALENCIA COLOURSMILE PAINT TRADING' AND branch_id = v_branch_id);

  -- Customer: RG BEST (CUST_00006)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00006-VALENCIA_DIST', 'RG BEST', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'RG BEST' AND branch_id = v_branch_id);

  -- Customer: BOSS J (CUST_00007)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00007-VALENCIA_DIST', 'BOSS J', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'BOSS J' AND branch_id = v_branch_id);

  -- Customer: CABAHUG LANTAPAN (CUST_00008)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00008-VALENCIA_DIST', 'CABAHUG LANTAPAN', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'CABAHUG LANTAPAN' AND branch_id = v_branch_id);

  -- Customer: JR. CAMANONG (CUST_00009)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00009-VALENCIA_DIST', 'JR. CAMANONG', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'JR. CAMANONG' AND branch_id = v_branch_id);

  -- Customer: PAINTERS CHOICE (CUST_00010)
  INSERT INTO public.customers (customer_id, name, address, terms, contact_number, branch_id)
  SELECT 'CUST_00010-VALENCIA_DIST', 'PAINTERS CHOICE', '', '', '', v_branch_id
  WHERE NOT EXISTS (SELECT 1 FROM public.customers WHERE name = 'PAINTERS CHOICE' AND branch_id = v_branch_id);

  -- ==================================================================
  -- SECTION 3: MASTER INVENTORY ITEMS
  -- ==================================================================
  -- Row 10: NIPPON EXTREME QDU WARM YELLOW 4L (XTRMEQDWARMYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 'GAL/S', 18.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 11: USA EPOXY REDUCER 4L (USAEPR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY REDUCER 4L', 'Thinner', 'USAEPR-4L', 'GAL', 0.0, 500.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 12: UNO PAINT THINNER BOT (UNOPT-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('UNO PAINT THINNER BOT', 'Thinner', 'UNOPT-BOT', 'PC/S', 0.0, 48.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 13: UNO PAINT THINNER BOX (UNOPT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('UNO PAINT THINNER BOX', 'Thinner', 'UNOPT', 'BOX', 0.0, 1176.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 14: UNO LACQUER THINNER BOX (UNOLT-BOX)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('UNO LACQUER THINNER BOX', 'Thinner', 'UNOLT-BOX', 'BOX', 0.0, 1152.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 15: UNO LACQUER THINNER BOT (UNOLT-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('UNO LACQUER THINNER BOT', 'Thinner', 'UNOLT-BOT', 'BOT', 0.0, 45.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 16: UNO LACQUER THINNER 4L (UNOLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('UNO LACQUER THINNER 4L', 'Thinner', 'UNOLT-4L', 'GAL/S', 0.0, 341.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 17: TEXAS QDE WHITE 4L (TXQDW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TEXAS QDE WHITE 4L', 'Paint', 'TXQDW-4L', 'GAL', 20.0, 419.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 18: TEXAS QDE BLACK 4L (TXQDBL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TEXAS QDE BLACK 4L', 'Paint', 'TXQDBL-4L', 'GAL', -12.0, 409.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 19: TEXAS FLAT LATEX WHITE 4L (TXFLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TEXAS FLAT LATEX WHITE 4L', 'Paint', 'TXFLW-4L', 'GAL', 0.0, 264.44, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 20: PAINT ROLLER TRAY (TRAY)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 'PC/S', 20.0, 32.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 21: TIMEOUT URETHANE THINNER 4L (TOUT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT URETHANE THINNER 4L', 'Thinner', 'TOUT-4L', 'GAL', -52.0, 698.88, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 22: TIMEOUT BODY FILLER WITH HARDENER 4L (TOBF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Miscellaneous', 'TOBF-4L', 'GAL', 16.0, 611.34, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 23: TIMEOUT BODY FILLER WITH HARDENER 1L (TOBF-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Miscellaneous', 'TOBF-1L', 'LITER', 108.0, 167.67, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 24: TIMEOUT ACRYLIC WHITE 4L (TOACW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC WHITE 4L', 'Paint', 'TOACW-4L', 'GAL', 0.0, 922.78, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 25: TIMEOUT ACRYLIC TOPCOAT CLEAR 4L (TOACCLR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC TOPCOAT CLEAR 4L', 'Clearcoat', 'TOACCLR-4L', 'GAL/S', 0.0, 824.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 26: TIMEOUT ACRYLIC THINNER 4L (TOAT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Thinner', 'TOAT-4L', 'GAL', 0.0, 636.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 27: TIMEOUT ACRYLIC THALO GREEN 4L (TOACTHGR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO GREEN 4L', 'Paint', 'TOACTHGR-4L', 'GAL/S', 0.0, 1050.06, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 28: TIMEOUT ACRYLIC THALO BLUE 4L (TOACTB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOACTB-4L', 'GAL', 0.0, 1140.34, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 29: TIMEOUT ACRYLIC RED GOLD 4L (TOACREDGLD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC RED GOLD 4L', 'Paint', 'TOACREDGLD-4L', 'GAL/S', 0.0, 1168.46, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 30: TIMEOUT ACRYLIC PRIMER WHITE 4L (TOACPW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC PRIMER WHITE 4L', 'Primer', 'TOACPW-4L', 'GAL', 0.0, 876.9, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 31: NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L (SOD145)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 'GAL', 40.0, 415.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 32: NAX SOB757 HIGH GRADE URETHANE THINNER 4L (SOB757)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Thinner', 'SOB757', 'GAL', -300.0, 620.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 33: NAX SOB745 BLENDING THINNER 4L (SOB745)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Thinner', 'SOB745', 'GAL', 0.0, 691.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 34: NAX MULTIPURPOSE URETHANE THINNER 4L (SOB642)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Thinner', 'SOB642', 'GAL', 0.0, 800.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 35: NIPPON SEALERMAX 5170 4L (SEALRMAX5170-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON SEALERMAX 5170 4L', 'Primer', 'SEALRMAX5170-4L', 'GAL/S', 0.0, 913.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 36: ROBERLO TACK CLOTH (ROBTCKCLTH)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ROBERLO TACK CLOTH', 'Miscellaneous', 'ROBTCKCLTH', 'PC/S', -50.0, 33.6, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 37: ROBERLO RUBBING COMPOUND 1KG (ROBRC-1KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Miscellaneous', 'ROBRC-1KG', 'KG', 6.0, 582.67, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 38: ROBFILTER PAINT STRAINER 125M (ROBPNTSTRNR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 'PC/S', 0.0, 6.65, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 39: Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L (QSHG710-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'Paint', 'QSHG710-5L', 'GAL', 0.0, 810.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 40: Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L (QSHG710-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L', 'Paint', 'QSHG710-1L', 'LITER', 0.0, 176.94, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 41: Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L (QSHG710-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 'PAIL', 0.0, 2550.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 42: PYLOX LAZER WHITE 02 (PYLZWH-02)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', 'CAN', 0.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 43: PYLOX LAZER VIOLET 20 (PYLZVIO-20)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PYLZVIO-20', 'CAN', 7.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 44: PYLOX LAZER SKY BLUE 22 (PYLZSKBL-22)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PYLZSKBL-22', 'CAN', 19.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 45: PYLOX LAZER SILVER 42 (PYLZSIL-42)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PYLZSIL-42', 'CAN', 7.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 46: PYLOX LAZER PRIMER GRAY 145 (PYLZPRGR-145)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Primer', 'PYLZPRGR-145', 'CAN', 0.0, 81.19, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 47: PYLOX LAZER MATT WHITE 03 (PYLZMTW-03)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PYLZMTW-03', 'CAN', 22.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 48: PYLOX LAZER MATT BLACK 47 (PYLZMTBLK-47)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER MATT BLACK 47', 'Paint', 'PYLZMTBLK-47', 'CAN', 12.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 49: PYLOX LAZER LIGHT GREEN 33 (PYLZLTGR-33)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PYLZLTGR-33', 'CAN', 19.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 50: PYLOX LAZER HEAT RESISTANT SILVER 709 (PYLZHTRSTSIL-709)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PYLZHTRSTSIL-709', 'CAN', 0.0, 146.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 51: PYLOX LAZER GOLD 705 (PYLZGLD-705)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PYLZGLD-705', 'CAN', 12.0, 95.04, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 52: PYLOX LAZER GLOSS BLACK 48 (PYLZGLBLK-48)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PYLZGLBLK-48', 'CAN', 19.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 53: PYLOX LAZER FLOURESCENT YELLOW 600 (PYLZFLOUYEL-600)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT YELLOW 600', 'Paint', 'PYLZFLOUYEL-600', 'CAN', 12.0, 123.42, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 54: PYLOX LAZER FLOURESCENT VIOLET 604 (PYLZFLOUVIO-604)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PYLZFLOUVIO-604', 'CAN', 12.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 55: PYLOX LAZER FLOURESCENT RED 602 (PYLZFLOURED-602)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT RED 602', 'Paint', 'PYLZFLOURED-602', 'CAN', 0.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 56: PYLOX LAZER FLOURESCENT ORANGE 601 (PYLZFLOURANGE-601)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PYLZFLOURANGE-601', 'CAN', 12.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 57: PYLOX LAZER FLOURESCENT PINK 603 (PYLZFLOUPNK-603)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PYLZFLOUPNK-603', 'CAN', 12.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 58: PYLOX LAZER FLOURESCENT GREEN 605 (PYLZFLOUGRN-605)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT GREEN 605', 'Paint', 'PYLZFLOUGRN-605', 'CAN', 0.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 59: PYLOX LAZER FLOURESCENT BLUE 606 (PYLZFLOUBLU-606)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT BLUE 606', 'Paint', 'PYLZFLOUBLU-606', 'CAN', 0.0, 127.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 60: PYLOX LAZER DEEP RED 17 (PYLZDR-17)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PYLZDR-17', 'CAN', 7.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 61: PYLOX LAZER DISTINGUISHED SILVER 701 (PYLZDISIL-701)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PYLZDISIL-701', 'CAN', 0.0, 97.92, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 62: PYLOX LAZER CLEAR 01 (PYLZCLR-01)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER CLEAR 01', 'Clearcoat', 'PYLZCLR-01', 'CAN', 19.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 63: PYLOX LAZER CANDYTONE RED 801 (PYLZCANRED-801)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PYLZCANRED-801', 'CAN', 0.0, 82.28, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 64: PYLOX LAZER ART YELLOW 06 (PYLZAY-06)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 'CAN', 19.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 65: PYLOX LAZER ANTI-RUST BROWN PRIMER 12 (PYLZANTPR-12)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Primer', 'PYLZANTPR-12', 'CAN', 0.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 66: JAPAN PUTTY KNIFE #6 BLUE (PUTTYKNI #6)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #6 BLUE', 'Miscellaneous', 'PUTTYKNI #6', 'PC/S', 0.0, 13.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 67: JAPAN PUTTY KNIFE #4 BLUE (PUTTYKNI #4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #4 BLUE', 'Miscellaneous', 'PUTTYKNI #4', 'PC/S', 0.0, 9.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 68: DRAGONFLY PAINT ROLLER #7 W/H (PTRL-7)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'Paint', 'PTRL-7', 'PC/S', 0.0, 60.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 69: NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L (PRI3634)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Miscellaneous', 'PRI3634', 'LITER', -29.0, 360.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 70: NAX PP BUMPER PRIMER GRAY 1L (PRI1680)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Primer', 'PRI1680', 'LITER', 100.0, 605.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 71: NAX PREMILA NB100 B/C BINDER 4L (PNB100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 'GAL', 20.0, 2158.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 72: PLATONE QDE WHITE 4L (PLQDW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE WHITE 4L', 'Paint', 'PLQDW-4L', 'GAL', 6.0, 750.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 73: PLATONE QDE WHITE 1L (PLQDW-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE WHITE 1L', 'Paint', 'PLQDW-1L', 'LITER', 0.0, 200.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 74: PLATONE QDE ROYAL BLUE 4L (PLQDRB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE ROYAL BLUE 4L', 'Paint', 'PLQDRB-4L', 'GAL', 0.0, 805.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 75: PLATONE QDE LEMON YELLOW 4L (PLQDLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 'GAL', 0.0, 965.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 76: PLATONE QDE JADE GREEN 4L (PLQDJG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE JADE GREEN 4L', 'Paint', 'PLQDJG-4L', 'GAL', 0.0, 844.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 77: PLATONE QDE INTERNATIONAL RED 4L (PLQDIR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 'GAL', 4.0, 891.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 78: PLATONE QDE CHOCOLATE BROWN 4L (PLQDCB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 'GAL', 0.0, 770.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 79: PLATONE QDE BLACK 4L (PLQDB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE BLACK 4L', 'Paint', 'PLQDB-4L', 'GAL', 0.0, 763.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 80: PLATONE QDE BLACK 1L (PLQDB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLATONE QDE BLACK 1L', 'Paint', 'PLQDB-1L', 'LITER', 0.0, 215.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 81: NIPPON EXTREME QDU SILVER 4L (NXU7391-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 'GAL', 22.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 82: NIPPON EXTREME QDU GREEN 4L (NXU4406-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 'GAL', 3.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 83: NIPPON EXTREME QDU RED 4L (NXU4113-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 'GAL', 13.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 84: NIPPON EXTREME QDU WHITE 4L (NXU4075-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', 'GAL', 14.0, 1560.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 85: NIPPON EXTREME QDU BLACK 4L (NXU1965-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 'GAL', -17.0, 1560.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 86: NIPPON EXTREME QDU BLUE 4L (NXU1587-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 'GAL', 9.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 87: NIPPON EXTREME QDU YELLOW 4L (NXU1338-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 'GAL', 5.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 88: NIPPON EXTREME QDU ORANGE 4L (NXU1224-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'Paint', 'NXU1224-4L', 'GAL', 2.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 89: NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L (NXE4090)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Miscellaneous', 'NXE4090', 'GAL', 0.0, 1310.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 90: NAX EXTREME EPOXY ENAMEL BLACK W/HARDENER 4L (NXE1988)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLACK W/HARDENER 4L', 'Miscellaneous', 'NXE1988', 'GAL', 0.0, 1110.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 91: NAX EXTREME EPOXY ENAMEL YELLOW WITH HARDENER 4L (NXE1313)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL YELLOW WITH HARDENER 4L', 'Miscellaneous', 'NXE1313', 'GAL', 0.0, 1305.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 92: NIPPON SANDING SEALER 4L (NSS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON SANDING SEALER 4L', 'Primer', 'NSS-4L', 'GAL', 7.0, 611.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 93: NIPPELAC ACE BRIGHT WHITE 4L (NPA4021)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 'GAL', 8.0, 1245.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 94: NIPPELAC ACE JET BLACK 4L (NPA1983)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 'GAL', 0.0, 1245.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 95: NIPPELAC ACE THALO GREEN 4L (NPA1487)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 'GAL', 0.0, 1494.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 96: NIPPELAC ACE LEMON YELLOW 4L (NPA1372)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 'GAL', 0.0, 1494.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 97: NIPPELAC ACE PERMANENT MAROON 4L (NPA1177)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE PERMANENT MAROON 4L', 'Paint', 'NPA1177', 'GAL', 0.0, 1979.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 98: NIPPELAC ACE RED TRIPLE 8 4L (NPA1131)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPELAC ACE RED TRIPLE 8 4L', 'Paint', 'NPA1131', 'GAL', 0.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 99: NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L (NP9700)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NP9700', 'LITER', -12.0, 1145.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 100: NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L (NP9200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NP9200', 'LITER', -102.0, 925.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 101: NIPPON LACQUER THINNER (FAST DRY) 4L (NLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON LACQUER THINNER (FAST DRY) 4L', 'Thinner', 'NLT-4L', 'GAL', 18.0, 485.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 102: NIPPON FLATWALL ENAMEL WHITE 4L (NFWE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'Paint', 'NFWE-4L', 'GAL', 0.0, 585.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 103: NIPPON FLEXI-SEAL 146 GRAY 5KG (NF146G-5KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NF146G-5KG', '5KG', 0.0, 1278.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 104: NIPPON FLEXI-SEAL 146 GRAY 20KG (NF146G-20KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 20KG', 'Paint', 'NF146G-20KG', '20KG', 0.0, 4855.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 105: NIPPON FLEXI-SEAL 145 WHITE 5KG (NF145W-5KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', '5KG', 0.0, 1278.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 106: NIPPON FLEXI-SEAL 145 WHITE 20KG (NF145W-20KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 20KG', 'Paint', 'NF145W-20KG', '20KG', 0.0, 4855.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 107: NIPPON DEAD FLAT LACQUER 4L (NDFL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DEAD FLAT LACQUER 4L', 'Paint', 'NDFL-4L', 'GAL', 0.0, 643.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 108: NIPPON CELAR GLOSS LACQUER 4L (NCGL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON CELAR GLOSS LACQUER 4L', 'Paint', 'NCGL-4L', 'GAL', 0.0, 627.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 109: NAX PREMILA NB200 HARDENER (NB200-HARD)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA NB200 HARDENER', 'Miscellaneous', 'NB200-HARD', 'LITER', 0.0, 685.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 110: NAX PREMILA NB200 BINDER (NB200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA NB200 BINDER', 'Paint', 'NB200', 'GAL', 0.0, 2000.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 111: NAX 34 ALPHA HARDENER (NAX34)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX 34 ALPHA HARDENER', 'Miscellaneous', 'NAX34', 'CAN', 0.0, 95.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 112: NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L (NAX301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX301', 'LITER', 41.0, 830.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 113: NAX NAT-2930 TTC QDU SASH BLACK 1L (NAX2930)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-2930 TTC QDU SASH BLACK 1L', 'Paint', 'NAX2930', 'LITER', 0.0, 308.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 114: NAX NAX21 URETHANE HARDENER (NAX21)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAX21 URETHANE HARDENER', 'Miscellaneous', 'NAX21', 'CAN', 48.0, 165.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 115: NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L (NAX141)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX141', 'LITER', 366.0, 430.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 116: NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L (NAX108)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX108', 'LITER', -279.0, 545.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 117: NAX 107 SUPERIO 2K CLEAR WITH HARDENER 1L (NAX107)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX 107 SUPERIO 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX107', 'LITER', 0.0, 626.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 118: NAX NAT-1062 QDU 040 SUPER WHITE 1L (NAX1062)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 'LITER', 2.0, 581.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 119: NAX NAT-10100 NH-585 PEARL WHITE MICA 1L (NAX10100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', 'LITER', -16.0, 806.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 120: NAX NAT-992 TTC BLACK NO.8 1L (NAT992)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'Paint', 'NAT992', 'LITER', 0.0, 515.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 121: NAX NAT-990 TTC BLACK 4L (NAT990-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 4L', 'Paint', 'NAT990-4L', 'GAL', 4.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 122: NAX NAT-990 TTC BLACK 1L (NAT990-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 1L', 'Paint', 'NAT990-1L', 'LITER', 0.0, 514.6, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 123: NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L (NAT745)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 'LITER', 12.0, 996.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 124: NAX NAT-740 TTC ULTRA FINE SILVER 1L (NAT740)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 'LITER', 6.0, 557.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 125: NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L (NAT736)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 'LITER', 12.0, 747.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 126: NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L (NAT733)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 'LITER', 12.0, 515.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 127: NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L (NAT729)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 'LITER', 12.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 128: NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L (NAT728)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'Paint', 'NAT728', 'LITER', -3.0, 1286.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 129: NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L (NAT727)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 'LITER', 12.0, 1162.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 130: NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L (NAT725)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 'LITER', 12.0, 723.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 131: NAX NAT-720 TTC SPARKLE WHITE SILVER 1L (NAT720)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 'LITER', 12.0, 747.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 132: NAX NAT-719 TTC COARSE SILVER 4L (NAT719-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 'GAL', 4.0, 2573.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 133: NAX NAT-719 TTC COARSE SILVER 1L (NAT719-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'Paint', 'NAT719-1L', 'LITER', 12.0, 706.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 134: NAX NAT-716 TTC SPARKLE SILVER 1L (NAT716)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 'LITER', 12.0, 515.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 135: NAX NAT-715 TTC FINE SILVER 1L (NAT715-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 'LITER', -22.0, 515.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 136: NAX NAT-712 TTC MEDIUM FINE SILVER 4L (NAT712-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 4L', 'Paint', 'NAT712-4L', 'GAL', 0.0, 2490.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 137: NAX NAT-712 TTC MEDIUM FINE SILVER 1L (NAT712-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 'LITER', -36.0, 706.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 138: NAX NAT707 HI-SPARKLE SILVER 1L (NAT707-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 'LITER', 6.0, 580.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 139: NAX NAT706 MEDIUM COARSE SILVER 1L (NAT706-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 'LITER', 12.0, 430.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 140: NAX NAT705 SUPER FINE SILVER 1L (NAT705-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 'LITER', 12.0, 430.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 141: NAX NAT-595 TTC CYANINE BLUE 1L (NAT595)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 'LITER', 6.0, 581.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 142: NAX NAT-557 TTC BLUE NO.9 1L (NAT557)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 'LITER', 6.0, 540.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 143: NAX NAT-556 TTC BLUE NO.8 1L (NAT556)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 'LITER', 6.0, 747.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 144: NAX NAT-555 TTC BLUE NO.7 1L (NAT555)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 'LITER', 12.0, 565.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 145: NAX NAT-550 TTC SUPER BLUE 1L (NAT550)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 'LITER', 12.0, 515.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 146: NAX NAT-530 TTC FINE BLUE 1L (NAT530)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 'LITER', 6.0, 1245.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 147: NAX NAT-490 TTC EVERGREEN 1L (NAT490)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 'LITER', 6.0, 664.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 148: NAX NAT-410 TTC CYANINE GREEN 1L (NAT410)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 'LITER', 2.0, 847.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 149: NAX NAT-3974 QDU FLAT BLACK 1L (NAT3974)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', 'LITER', 2.0, 557.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 150: NAX NAT-390 TTC IRON YELLOW 1L (NAT390)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 'LITER', 2.0, 482.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 151: NAX NAT-380 TTC SUPER YELLOW 1L (NAT380)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 'LITER', 6.0, 1295.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 152: NAX NAT-321 TTC HOSTAPERM YELLOW 1L (NAT321)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Miscellaneous', 'NAT321', 'LITER', 2.0, 1079.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 153: NAX NAT-320 TTC GOLD YELLOW 1L (NAT320)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 'LITER', 2.0, 540.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 154: NAX NAT-305 TTC GREEN YELLOW 1L (NAT305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 'LITER', 12.0, 1494.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 155: NAX NAT-210 TTC SUPER ORANGE 1L (NAT210)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 'LITER', 6.0, 1826.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 156: NAX NAT-196 TTC PURPLISH RED 1L (NAT196)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 'LITER', 6.0, 1577.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 157: NAX NAT-192 TTC BRIGHT RED 1L (NAT192)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 'LITER', 2.0, 706.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 158: NAX NAT-190 TTC IRON RED 1L (NAT190)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 'LITER', 6.0, 465.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 159: NAX NAT-180 TTC STRAWBERRY RED 1L (NAT180)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 'LITER', 6.0, 1030.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 160: NAX NAT158 CINQUASIA VIOLET 1L (NAT158-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158-1L', 'LITER', 8.0, 1345.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 161: NAX NAT-149 TTC DARK MAROON 1L (NAT149)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 'LITER', 2.0, 1544.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 162: NAX NAT-147 TTC THRENE RED 1L (NAT147)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'Paint', 'NAT147', 'LITER', 0.0, 1337.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 163: NAX NAT-143 TTC FLAME RED 1L (NAT143)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 'LITER', 6.0, 1411.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 164: NAX NAT-1305 TTC 211 MICA BASE 1L (NAT1305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 'LITER', 6.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 165: NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L (NAT1304)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 'LITER', 0.0, 2200.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 166: NAX NAT-1303 TTC OMEGA PEARL 1L (NAT1303)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 'LITER', 4.0, 2200.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 167: NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L (NAT1301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 'LITER', 2.0, 2200.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 168: NAX NAT-1300 TTC CRYSTALLINE SILVER 1L (NAT1300)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 'LITER', 2.0, 2200.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 169: NAX NAT-1180 TTC OYSTER WHITE MICA 1L (NAT1180)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 'LITER', 6.0, 1660.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 170: NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L (NAT1175)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 'LITER', 6.0, 930.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 171: NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L (NAT1173)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 'LITER', 6.0, 1719.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 172: NAX NAT-1172 TTC BRIGHT GREEN MICA 1L (NAT1172)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 'LITER', 6.0, 1079.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 173: NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L (NAT1171)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 'LITER', 12.0, 1055.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 174: NAX NAT-1167 TTC PALE GREEN MICA 1L (NAT1167)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 'LITER', 6.0, 1079.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 175: NAX NAT-1166 TTC EARTH BROWN MICA 1L (NAT1166)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 'LITER', 6.0, 1470.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 176: NAX NAT-1165 TTC HI-LITE RED 1L (NAT1165)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 'LITER', 1.0, 972.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 177: NAX NAT-1164 TTC BRIGHT GOLD MICA 1L (NAT1164)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 'LITER', 0.0, 830.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 178: NAX NAT-1163 TTC FINE GREEN MICA 1L (NAT1163)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 'LITER', 2.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 179: NAX NAT-1161 TTC LAVENDER MICA 1L (NAT1161)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 'LITER', 1.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 180: NAX NAT-1160 TTC RED COPPER MICA 1L (NAT1160)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 'LITER', 6.0, 830.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 181: NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L (NAT1159)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'Paint', 'NAT1159', 'LITER', 11.0, 930.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 182: NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L (NAT1158)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 'LITER', 0.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 183: NAX NAT-1157 TTC BRIGHT COPPER MICA 1L (NAT1157)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 'LITER', 2.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 184: NAX NAT-1153 TTC SUPER RED MICA 1L (NAT1153)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 'LITER', 6.0, 913.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 185: NAX NAT-1114 TTC GREEN MICA 1L (NAT1114)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 'LITER', 3.0, 676.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 186: NAX NAT-1113 TTC FINE BLUE MICA 1L (NAT1113)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 'LITER', 1.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 187: NAX NAT-1110 TTC BRIGHT WHITE 4L (NAT1110-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 'GAL', 0.0, 2490.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 188: NAX NAT-1110 TTC BRIGHT WHITE 1L (NAT1110-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 'LITER', 12.0, 806.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 189: NAX NAT-1107 TTC FINE RED MICA 1L (NAT1107)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 'LITER', 1.0, 889.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 190: NAX NAT-1106 TTC PEARL BLUE MICA 1L (NAT1106)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 'LITER', 6.0, 996.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 191: NAX NAT-103 TTC OPAL 1L (NAT103)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 'LITER', 2.0, 1353.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 192: NAX NAT-100 TTC WHITE 4L (NAT100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-100 TTC WHITE 4L', 'Paint', 'NAT100-4L', 'GAL', 5.0, 1810.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 193: NAX NAT-1OO TTC WHITE 1L (NAT100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX NAT-1OO TTC WHITE 1L', 'Paint', 'NAT100-1L', 'LITER', 4.0, 498.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 194: NIPPON ACRYLIC SKIMCOAT 5KG (NAS-5KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'Paint', 'NAS-5KG', '5KG', 0.0, 382.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 195: NIPPON ACRYLIC GLOSS THINNER 4L (NAS535)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Thinner', 'NAS535', 'GAL/S', 0.0, 750.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 196: NIPPON ACRYLIC SKIMCOAT 30KG (NAS-30KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 30KG', 'Paint', 'NAS-30KG', '30KG', 0.0, 1671.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 197: NAX PREMILA MT904 SHADOWN GREEN 1L (MT904)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 'LITER', 2.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 198: NAX PREMILA MT903 SUN GREEN 1L (MT903)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 'LITER', 2.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 199: NAX PREMILA MT902 GRASS GREEN 1L (PHASED OUT) (MT902)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT902 GRASS GREEN 1L (PHASED OUT)', 'Paint', 'MT902', 'LITER', 2.0, 1455.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 200: NAX PREMILA MT901 CYANINE GREEN 1L (PHASED OUT) (MT901)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT901 CYANINE GREEN 1L (PHASED OUT)', 'Paint', 'MT901', 'LITER', 0.0, 1455.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 201: NAX PREMILA MT807 VACANCE BLUE 1L (MT807)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 'LITER', 2.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 202: NAX PREMILA MT806 HERMES BLUE 1L (MT806)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 'LITER', 2.0, 1826.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 203: NAX PREMILA MT805 CUSTOM BLUE 1L (MT805)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 'LITER', 1.0, 1826.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 204: NAX PREMILA MT804 ORIENT BLUE 1L (MT804)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 'LITER', 0.0, 1826.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 205: NAX PREMILA MT803 FRESH BLUE 1L (MT803)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 'LITER', 2.0, 1826.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 206: NAX PREMILA MT801 CYANINE BLUE 1L (MT801)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 'LITER', 2.0, 1743.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 207: NAX PREMILA MT705 FLORA VIOLET 1L (MT705)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 'LITER', 0.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 208: NAX PREMILA MT704 FINE VIOLET 1L (MT704)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 'LITER', 0.0, 2905.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 209: NAX PREMILA MT702 CINQUASIA VIOLET 1L (PHASED OUT) (MT702)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT702 CINQUASIA VIOLET 1L (PHASED OUT)', 'Paint', 'MT702', 'LITER', 0.0, 1594.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 210: NAX PREMILA MT701 FAST VIOLET 1L (MT701)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 'LITER', 0.0, 1992.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 211: NAX PREMILA MT607 AUTUMN RED 1L (MT607)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 'LITER', 2.0, 2158.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 212: NAX PREMILA MT606 GIRAFFE YELLOW 1L (MT606)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 'LITER', 0.0, 1909.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 213: NAX PREMILA MT604 EXTRA MAROON 1L (MT604)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 214: NAX PREMILA MT603 CINQUASIA BROWN 1L (MT603)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 215: NAX PREMILA MT602 PEGASUS MAROON 1L (MT602)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 'LITER', 2.0, 2490.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 216: NAX PREMILA MT601 IRON RED 1L (MT601)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 217: NAX PREMILA MT508 INDIAN RED 1L (MT508)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 'LITER', 2.0, 2573.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 218: NAX PREMILA MT507 RUBY RED 1L (MT507)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 'LITER', 2.0, 2905.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 219: NAX PREMILA MT506 CINQUASIA RED 1L (MT506)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 220: NAX PREMILA MT505 SPARK RED 1L (MT505)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 'LITER', 2.0, 2365.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 221: NAX PREMILA MT503 THRENE RED G 1L (MT503)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 'LITER', 1.0, 2117.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 222: NAX PREMILA MT501 STRONG RED 1L (MT501)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 223: NAX PREMILA MT405 SUN ORANGE 1L (MT405)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 'LITER', 2.0, 3611.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 224: NAX PREMILA MT401 MAXIM ORANGE 1L (MT401)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 'LITER', 2.0, 2656.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 225: NAX PREMILA MT307 EXTRA YELLOW 1L (MT307)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 'LITER', 2.0, 2988.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 226: NAX PREMILA MT305 NATURAL YELLOW 1L (MT305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 'LITER', 2.0, 1951.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 227: NAX PREMILA MT304 GAILY YELLOW 1L (MT304)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 'LITER', 2.0, 3486.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 228: NAX PREMILA MT303 FINE YELLOW 1L (MT303)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 229: NAX PREMILA MT302 JEWEL YELLOW 1L (MT302)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 'LITER', 2.0, 2158.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 230: NAX PREMILA MT301 MAPICO YELLOW 1L (MT301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 'LITER', 2.0, 2573.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 231: NAX PREMILA MT203 DEEP BLACK 1L (MT203)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', 'LITER', -2.0, 1909.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 232: NAX PREMILA MT202 TINTING BLACK 4L (MT202-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK 4L', 'Paint', 'MT202-4L', 'GAL', 0.0, 3581.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 233: NAX PREMILA MT202 TINTING BLACK NP 1L (MT202-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 'LITER', 2.0, 1204.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 234: NAX PREMILA MT201 BLUE BLACK 1L (MT201)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 'LITER', 2.0, 1162.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 235: NAX PREMILA MT175 GRAPHITE 1L (MT175)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 'LITER', 3.0, 1992.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 236: NAX PREMILA MT172 OPAL COLOR 1L (MT172)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 'LITER', 1.0, 3154.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 237: NAX PREMILA MT170 OPAL COLOR LS 1L (MT170)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 238: NAX PREMILA MT136 METALLIC ORANGE 1L (MT136)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 'LITER', 2.0, 4980.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 239: NAX PREMILA MT134 METALLIC GOLD 1L (MT134)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 'LITER', 2.0, 3320.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 240: NAX PREMILA MT103 WHITE LS 1L (MT103)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 'LITER', 1.0, 1245.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 241: NAX PREMILA MT100 WHITE HS 4L (MT100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 'GAL', 0.0, 4980.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 242: NAX PREMILA MT100 WHITE HS 1L (MT100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'Paint', 'MT100-1L', 'LITER', 0.0, 1328.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 243: NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L (MT096)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', 'LITER', 3.0, 5810.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 244: NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L (MT093)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 245: NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L (MT086)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 246: NAX PREMILA MT085 MICA BASE 4G GREEN 1L (MT085)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 247: NAX PREMILA MT083 MICA BASE 4R RED 1L (MT083)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 248: NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L (MT081)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 249: NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L (MT080)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 250: NAX PREMILA MT079 MICA BASE 2V VIOLET 1L (MT079)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 251: NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L (MT078)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 252: NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L (MT076)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 253: NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L (MT075)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 254: NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L (MT072)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 255: NAX PREMILA MT071 MICA BASE 5B BLUE 1L (MT071)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 256: NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L (MT06M)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 'LITER', 2.0, 3569.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 257: NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L (MT06H)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 'LITER', 2.0, 3569.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 258: NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L (MT06A)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 'LITER', 6.0, 3569.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 259: NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L (MT068)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'Paint', 'MT068', 'LITER', 2.0, 5976.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 260: NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L (MT067)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 261: NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L (MT066)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 262: NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L (MT065)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 263: NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L (MT061)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 264: NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L (MT051)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 'LITER', 2.0, 3320.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 265: NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L (MT050)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 'LITER', 2.0, 3071.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 266: NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L (MT033)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 'LITER', 8.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 267: NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L (N/A) (MT033-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L (N/A)', 'Paint', 'MT033-4L', 'GAL', 0.0, 5821.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 268: NAX PREMILA MT030 WHITE MET. SNOW FINE 1L (MT030)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 'LITER', 2.0, 1909.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 269: NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L (MT028)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 'LITER', 2.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 270: NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L (MT025)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 'LITER', 6.0, 1909.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 271: NAX PREMILA MT023 HIGH SPARKLE FINE 1L (MT023)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 'LITER', 2.0, 2075.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 272: NAX PREMILA MT023 HIGH SPARKLE FINE 4L (N/A) (MT023-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 4L (N/A)', 'Paint', 'MT023-4L', 'GAL', 0.0, 5820.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 273: NAX PREMILA MT012 MET. BASE FINE 1L (MT012)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 'LITER', 2.0, 1909.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 274: NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L (MT008)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 'LITER', 2.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 275: NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L (MT006)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 'LITER', 6.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 276: NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L (MT004)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 'LITER', 5.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 277: NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L (MT003)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 'LITER', 5.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 278: NAX PREMILA MT002 CRYSTAL SILVER FINE 4L (N/A) (MT002-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 4L (N/A)', 'Paint', 'MT002-4L', 'GAL', 0.0, 6058.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 279: NAX PREMILA MT002 CRYSTAL SILVER FINE 1L (MT002-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 'LITER', 2.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 280: NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L (MT001)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 'LITER', 2.0, 2241.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 281: OLD NEWS (MSC)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('OLD NEWS', 'Paint', 'MSC', 'KG', 161.7, 41.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 282: NIPPON MULTI-PURPOSE JOINT COMPOUND 5L (MPJOINTCMPND-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Miscellaneous', 'MPJOINTCMPND-5L', 'GAL/S', 0.0, 378.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 283: METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L (MEG3901-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Primer', 'MEG3901-4L', 'GAL', 12.0, 950.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 284: METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L (MEG3901-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L', 'Primer', 'MEG3901-1L', 'LITER', 0.0, 182.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 285: METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L (MEG3602-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'Primer', 'MEG3602-4L', 'GAL', 0.0, 910.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 286: METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L (MEG3602-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L', 'Primer', 'MEG3602-1L', 'LITER', 0.0, 182.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 287: METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L (MEG3100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L', 'Primer', 'MEG3100-4L', 'GAL', 0.0, 645.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 288: METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L (MEG3100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'Primer', 'MEG3100-1L', 'LITER', 0.0, 182.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 289: METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L (MEG3001-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'Primer', 'MEG3001-4L', 'GAL', 0.0, 910.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 290: METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L (MEG3001-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L', 'Primer', 'MEG3001-1L', 'LITER', 0.0, 182.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 291: NIPPON HS FILLER 1L (HS-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON HS FILLER 1L', 'Paint', 'HS-1L', 'LITER', 12.0, 545.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 292: NAX PREMILA FF151 FLIP FLAT ADJ 1L (FF151)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA FF151 FLIP FLAT ADJ 1L', 'Paint', 'FF151', 'LITER', 4.0, 1000.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 293: NIPPON EXTREME QDU FINE SILVER 4L (EXTRMEFNESLVR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU FINE SILVER 4L', 'Paint', 'EXTRMEFNESLVR-4L', 'GAL/S', 0.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 294: NIPPON EPOXY THINNER 4L (EPOXYTHNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EPOXY THINNER 4L', 'Thinner', 'EPOXYTHNR-4L', 'GAL/S', 0.0, 480.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 295: EAGLE SANDPAPER 800 (EA800)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 800', 'Miscellaneous', 'EA800', 'PC/S', 300.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 296: EAGLE SANDPAPER #80 (EA80)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER #80', 'Miscellaneous', 'EA80', 'PC/S', 100.0, 27.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 297: EAGLE SANDPAPER 600 (EA600)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 600', 'Miscellaneous', 'EA600', 'PC/S', 300.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 298: EAGLE SANDPAPER #60 (EA60)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER #60', 'Miscellaneous', 'EA60', 'PC/S', 200.0, 29.7, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 299: EAGLE SANDPAPER 400 (EA400)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 400', 'Miscellaneous', 'EA400', 'PC/S', 100.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 300: EAGLE SANDPAPER 240 (EA240)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 240', 'Miscellaneous', 'EA240', 'PC/S', 200.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 301: EAGLE SANDPAPER 2000 (EA2000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 2000', 'Miscellaneous', 'EA2000', 'PC/S', 0.0, 27.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 302: EAGLE SANDPAPER 1500 (EA1500)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 1500', 'Miscellaneous', 'EA1500', 'PC/S', 300.0, 25.3, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 303: EAGLE SANDPAPER 1200 (EA1200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 1200', 'Miscellaneous', 'EA1200', 'PC/S', 0.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 304: EAGLE SANDPAPER 120 (EA120)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 120', 'Miscellaneous', 'EA120', 'PC/S', -200.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 305: EAGLE SANDPAPER 1000 (EA1000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 1000', 'Miscellaneous', 'EA1000', 'PC/S', 300.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 306: EAGLE SANDPAPER #100 (EA100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER #100', 'Miscellaneous', 'EA100', 'PC/S', 100.0, 25.3, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 307: DAVIES QDE WHITE 4L (DVQDW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES QDE WHITE 4L', 'Paint', 'DVQDW-4L', 'GAL', 0.0, 779.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 308: DAVIES OIL TINTING COLOR VENETIAN RED 1/4L (DVOTCVNRED-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR VENETIAN RED 1/4L', 'Paint', 'DVOTCVNRED-1/4L', 'CAN', 0.0, 90.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 309: DAVIES OIL TINTING COLOR THALO GREEN 1/4L (DVOTCTHGRN-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR THALO GREEN 1/4L', 'Paint', 'DVOTCTHGRN-1/4L', 'CAN', 0.0, 90.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 310: DAVIES OIL TINTING COLOR THALO BLUE 1/4L (DVOTCTHBLU-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR THALO BLUE 1/4L', 'Paint', 'DVOTCTHBLU-1/4L', 'CAN', 0.0, 90.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 311: DAVIES OIL TINTING COLOR RAW SIENNA 1/4L (DVOTCRWSNA-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR RAW SIENNA 1/4L', 'Paint', 'DVOTCRWSNA-1/4L', 'CAN', 0.0, 79.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 312: DAVIES OIL TINTING COLOR HANZA YELLOW 1/4L (DVOTCHNZYLW-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR HANZA YELLOW 1/4L', 'Paint', 'DVOTCHNZYLW-1/4L', 'CAN', 0.0, 97.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 313: DAVIES OIL TINTING COLOR BURNT SIENNA 1/4L (DVOTCBSNA-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BURNT SIENNA 1/4L', 'Paint', 'DVOTCBSNA-1/4L', 'CAN', 0.0, 87.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 314: DAVIES OIL TINTING COLOR BULLETIN RED 1/4L (DVOTCBLTNRD-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BULLETIN RED 1/4L', 'Paint', 'DVOTCBLTNRD-1/4L', 'CAN', 0.0, 96.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 315: DAVIES OIL TINTING COLOR BLACK 1/4L (DVOTCBLK-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BLACK 1/4L', 'Paint', 'DVOTCBLK-1/4L', 'CAN', 0.0, 80.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 316: DAVIES LTC THALO BLUE 1L (DVLTCTHBLU-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LTC THALO BLUE 1L', 'Paint', 'DVLTCTHBLU-1L', 'LITER', 0.0, 106.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 317: DRAGONFLY PAINT BRUSH 4 (DPB-4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 4', 'Paint', 'DPB-4', 'PC/S', 0.0, 93.33, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 318: DRAGONFLY PAINT BRUSH 3/4 (DPB-3/4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 3/4', 'Paint', 'DPB-3/4', 'PC/S', 0.0, 12.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 319: DRAGONFLY PAINT BRUSH #3 (DPB-3)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #3', 'Paint', 'DPB-3', 'PC/S', 0.0, 52.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 320: DRAGONFLY PAINT BRUSH #2 (DPB-2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #2', 'Paint', 'DPB-2', 'PC/S', 0.0, 26.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 321: DRAGONFLY PAINT BRUSH 1/2 (DPB-1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 1/2', 'Paint', 'DPB-1/2', 'PC/S', 0.0, 9.33, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 322: DRAGONFLY PAINT BRUSH # 1 1/2 (DPB-1 1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH # 1 1/2', 'Paint', 'DPB-1 1/2', 'PC/S', 0.0, 17.6, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 323: DRAGONFLY PAINT BRUSH #1 (DPB-1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1', 'Paint', 'DPB-1', 'PC/S', 0.0, 15.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 324: DOMINO QDE LEMON YELLOW 4L (DOMQDLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO QDE LEMON YELLOW 4L', 'Paint', 'DOMQDLY-4L', 'GAL', 0.0, 580.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 325: DOMINO QDE ALUMINUM 4L (DOMQDAL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO QDE ALUMINUM 4L', 'Paint', 'DOMQDAL-4L', 'GAL', 0.0, 700.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 326: DOMINO BODY FILLER WITH HARDENER 4L (DOMBF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 4L', 'Miscellaneous', 'DOMBF-4L', 'GAL', -67.0, 514.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 327: DOMINO BODY FILLER WITH HARDENER 1L (DOMBF-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 1L', 'Miscellaneous', 'DOMBF-1L', 'LITER', 102.0, 154.56, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 328: DO IT URETHANE THINNER 4L (DOITTH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DO IT URETHANE THINNER 4L', 'Thinner', 'DOITTH-4L', 'GAL', 0.0, 548.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 329: DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML (DOITSHLDALL-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Miscellaneous', 'DOITSHLDALL-BOT', 'BOT', 0.0, 131.25, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 330: DELIVERY CHARGE (DELCHRGE)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DELIVERY CHARGE', 'Paint', 'DELCHRGE', 'Piece', 0.0, 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 331: NIPPON DOU CLASSIC SG 715 WHITE 5L (DCSG715-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'Paint', 'DCSG715-5L', 'GAL', 0.0, 788.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 332: NIPPON DOU CLASSIC SG 715 WHITE 1L (DCSG715-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 1L', 'Paint', 'DCSG715-1L', 'LITER', 0.0, 245.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 333: NIPPON DOU CLASSIC SG WHITE 715 15L (DCSG715-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'Paint', 'DCSG715-15L', 'PAIL', 0.0, 2555.38, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 334: NIPPON DOU CLASSIC FLAT WHITE 701 5L (DCF701-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'Paint', 'DCF701-5L', 'GAL', 0.0, 625.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 335: NIPPON DOU CLASSIC FLAT WHITE 701 1L (DCF701-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'Paint', 'DCF701-1L', 'LITER', 0.0, 154.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 336: NIPPON DOU CLASSIC FLAT WHITE 701 15L (DCF701-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'Paint', 'DCF701-15L', 'PAIL', 0.0, 2199.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 337: CROCO MASKING TAPE 3/4 18MM (1X64) (CRO-MT3/4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Miscellaneous', 'CRO-MT3/4', 'BOX', 17.0, 1451.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 338: CROCO MASKING TAPE 2 48MM (1X24) (CRO-MT2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CROCO MASKING TAPE 2 48MM (1X24)', 'Miscellaneous', 'CRO-MT2', 'BOX', 0.0, 1448.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 339: CROCO MASKING TAPE 1/2 12MM (1X96) (CRO-MT1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Miscellaneous', 'CRO-MT1/2', 'BOX', 11.0, 1451.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 340: CROCO MASKING TAPE 1 24MM (1X48) (CRO-MT1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CROCO MASKING TAPE 1 24MM (1X48)', 'Miscellaneous', 'CRO-MT1', 'BOX', 1.0, 1448.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 341: BOYSEN QDE WHITE 4L (BSQDWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN QDE WHITE 4L', 'Paint', 'BSQDWHT-4L', 'GAL', 0.0, 794.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 342: BOYSEN LATEX GLOSS WHITE 4L (BSLXGLWH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN LATEX GLOSS WHITE 4L', 'Paint', 'BSLXGLWH-4L', 'GAL', 32.0, 763.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 343: BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG (BSKSKMCOAT-BAG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'Paint', 'BSKSKMCOAT-BAG', 'BAG', 6.0, 450.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 344: BOYSEN FLATWALL ENAMEL WHITE 4L (BSFWE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN FLATWALL ENAMEL WHITE 4L', 'Paint', 'BSFWE-4L', 'GAL', 0.0, 740.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 345: BOYSEN ACRYTEX REDUCER 4L (BSAXREDUCR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN ACRYTEX REDUCER 4L', 'Thinner', 'BSAXREDUCR-4L', 'GAL', 0.0, 464.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 346: BOYSEN ACRYTEX PRIMER WHITE 4L (BSAXPRWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN ACRYTEX PRIMER WHITE 4L', 'Primer', 'BSAXPRWHT-4L', 'GAL/S', 0.0, 970.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 347: DRAGONFLY MINI BABY ROLLER #4 W/H (BBR-MINI)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'Paint', 'BBR-MINI', 'PC/S', 0.0, 25.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 348: DO IT URETHANE BLACK 4L (DOITBLACK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 'GAL/S', 12.0, 2100.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 349: DO IT URETHANE WHITE 4L (DOITWHITE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 'GAL/S', 0.0, 1475.33, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 350: XPERTO ACRYLIC THINNER 4L (XPRTOACTHNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('XPERTO ACRYLIC THINNER 4L', 'Thinner', 'XPRTOACTHNR-4L', 'GAL/S', 0.0, 456.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 351: CUMI SUPREME FLOOR SANDING #36 (CUMISPRME-FS36)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #36', 'Paint', 'CUMISPRME-FS36', 'ROLL', 0.0, 7907.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 352: CUMI SUPREME FLOOR SANDING #60 (CUMISPREME-FS60)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #60', 'Paint', 'CUMISPREME-FS60', 'ROLL', 0.0, 6388.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 353: CUMI SUPREME FLOOR SANDING #80 (CUMISPREME-FS80)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #80', 'Paint', 'CUMISPREME-FS80', 'ROLL', 0.0, 7434.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 354: CUMI SUPREME FLOOR SANDING #100 (CUMISPREME-FS100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #100', 'Paint', 'CUMISPREME-FS100', 'ROLL', 0.0, 5575.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 355: GI PAINT REMOVER BOT (GIPNTRMOVR-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GI PAINT REMOVER BOT', 'Paint', 'GIPNTRMOVR-BOT', 'BOT', 24.0, 99.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 356: NIPPON FLATTENING PASTE 1L (NFP-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON FLATTENING PASTE 1L', 'Paint', 'NFP-1L', 'LTR', 0.0, 650.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 357: NIPPON CLEAR GLOSS VARNISH 1L (NPCGV-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 1L', 'Clearcoat', 'NPCGV-1L', 'LTR', 0.0, 427.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 358: NIPPON CLEAR GLOSS VARNISH 4L (NPCGV-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 4L', 'Clearcoat', 'NPCGV-5L', 'GAL', 12.0, 1390.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 359: NIPPON EXTREME QDU MAROON 4L (NXU4168-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU MAROON 4L', 'Paint', 'NXU4168-4L', 'GAL/S', 1.0, 1910.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 360: NIPPON EXTREME QDU CINQUASIA VIOLET 4L (NXU4184-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU CINQUASIA VIOLET 4L', 'Paint', 'NXU4184-4L', 'GAL/S', 3.0, 1710.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 361: NIPPON EXTREME QDU MAGENTA 4L (NXU4197-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EXTREME QDU MAGENTA 4L', 'Paint', 'NXU4197-4L', 'GAL/S', 4.0, 1910.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 362: DAVIES LTC HANZA YELLOW 1L (DVLTCHNYL-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LTC HANZA YELLOW 1L', 'Paint', 'DVLTCHNYL-1L', 'LITER', 0.0, 145.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 363: DAVIES LIQUID TILE SG WHITE 4L (DVLIQSG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE SG WHITE 4L', 'Paint', 'DVLIQSG-4L', 'GAL', 0.0, 1043.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 364: DAVIES LIQUID TILE REDUCER 4L (DVLIQRDCR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE REDUCER 4L', 'Thinner', 'DVLIQRDCR-4L', 'GAL', 0.0, 464.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 365: DAVIES LIQUID TILE PRIMER WHITE 4L (DVLQPR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 4L', 'Primer', 'DVLQPR-4L', 'GAL', 0.0, 985.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 366: DAVIES LIQUID TILE PRIMER WHITE 16L (DVLIQPRWHT-16L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 16L', 'Primer', 'DVLIQPRWHT-16L', 'PAIL', 0.0, 3865.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 367: DAVIES LIQUID TILE GLOSS WHITE 4L (DVLIQWHTE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'Paint', 'DVLIQWHTE-4L', 'GAL', 0.0, 1043.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 368: DAVIES LIQUID TILE FLAT WHITE 4L (DVLIQFLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE FLAT WHITE 4L', 'Paint', 'DVLIQFLT-4L', 'GAL', 0.0, 990.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 369: DAVIES LATEX TINTING COLOR VENETIAN RED 1L (DVLTCVNRD-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR VENETIAN RED 1L', 'Paint', 'DVLTCVNRD-1L', 'LTR/S', 0.0, 111.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 370: DAVIES LATEX TINTING COLOR TOLOUDINE RED 1L (DVLTCTLRED-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR TOLOUDINE RED 1L', 'Paint', 'DVLTCTLRED-1L', 'LTR/S', 0.0, 111.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 371: DAVIES LATEX TINTING COLOR THALO GREEN 1L (DVLTCTHGRN-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR THALO GREEN 1L', 'Paint', 'DVLTCTHGRN-1L', 'LTR/S', 0.0, 106.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 372: DAVIES LATEX TINTING COLOR RAW SIENNA 1L (DVLTCRWSNA-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR RAW SIENNA 1L', 'Paint', 'DVLTCRWSNA-1L', 'LTR/S', 0.0, 118.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 373: DAVIES LATEX TINTING COLOR BLACK 1L (DVLTCBLK-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR BLACK 1L', 'Paint', 'DVLTCBLK-1L', 'LTR/S', 0.0, 87.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 374: DAVIES LACQUER PUTTY WHITE 4L (DVLACPTW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LACQUER PUTTY WHITE 4L', 'Miscellaneous', 'DVLACPTW-4L', 'GAL', 0.0, 756.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 375: DAVIES LACQUER PRIMER WHITE 4L (DVLACPRW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LACQUER PRIMER WHITE 4L', 'Primer', 'DVLACPRW-4L', 'GAL', 0.0, 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 376: TEXAS RUBBERIZED BLACK 4L (TXSRUB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TEXAS RUBBERIZED BLACK 4L', 'Paint', 'TXSRUB-4L', 'GAL/S', -12.0, 433.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 377: BOSTIK EL KAPITAN MARINE EPOXY A&B 4L (ELKAP-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 4L', 'Paint', 'ELKAP-4L', 'GAL/S', 0.0, 1998.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 378: BOSTIK EL KAPITAN MARINE EPOXY A&B 1L (ELKAP-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 1L', 'Paint', 'ELKAP-1L', 'LTR', 0.0, 542.7, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 379: BOSTIK VULCASEAL JR (24X1) (VULCASL-JR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOSTIK VULCASEAL JR (24X1)', 'Paint', 'VULCASL-JR', 'PC/S', 0.0, 58.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 380: BOSTIK RUGBY ORIGINAL 300ML (24X1) (BSTKRGBY-300ML)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOSTIK RUGBY ORIGINAL 300ML (24X1)', 'Paint', 'BSTKRGBY-300ML', 'BOT', 0.0, 61.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 381: CANCELLED INVOICE (CANCELLED)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CANCELLED INVOICE', 'Paint', 'CANCELLED', 'PC/S', 0.0, 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 382: EAGLE SANDPAPER 320 (EA320)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 320', 'Miscellaneous', 'EA320', 'PC/S', 200.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 383: 2B PAINT BRUSH #2 (2BPB-2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT BRUSH #2', 'Paint', '2BPB-2', 'BOX', 1.0, 366.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 384: DO IT URETHANE CATALYST CAN (DOIT-CAT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DO IT URETHANE CATALYST CAN', 'Paint', 'DOIT-CAT', 'CAN', 9.0, 225.82, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 385: 2B BABY ROLLER COTTON WITH HANDLE 4" (2BBBRLR 4")
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B BABY ROLLER COTTON WITH HANDLE 4"', 'Paint', '2BBBRLR 4"', 'PC/S', 1.0, 28.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 386: FLANELLA (FLANEL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('FLANELLA', 'Paint', 'FLANEL', 'MTR', 0.0, 64.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 387: DOMINO AUTO LACQUER WHITE 4L (DOMLCQWHTE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER WHITE 4L', 'Paint', 'DOMLCQWHTE-4L', 'GAL/S', 0.0, 760.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 388: DOMINO AUTO LACQUER BLACK 4L (DOMLCQBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER BLACK 4L', 'Paint', 'DOMLCQBLK-4L', 'GAL/S', 0.0, 760.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 389: DOMINO AUTO LACQUER LEMON YELLOW 4L (DOMLCQLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER LEMON YELLOW 4L', 'Paint', 'DOMLCQLY-4L', 'GAL/S', 0.0, 1016.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 390: DOMINO AUTO LACQUER MOLYBDATE ORANGE 4L (DOMLCQMO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER MOLYBDATE ORANGE 4L', 'Paint', 'DOMLCQMO-4L', 'GAL/S', 0.0, 894.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 391: DOMINO AUTO LACQUER THALO BLUE 4L (DOMLCQTHBL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER THALO BLUE 4L', 'Paint', 'DOMLCQTHBL-4L', 'GAL/S', 0.0, 879.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 392: DOMINO AUTO LACQUER THALO GREEN 4L (DOMLCQTHGR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER THALO GREEN 4L', 'Paint', 'DOMLCQTHGR-4L', 'GAL/S', 0.0, 879.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 393: DOMINO AUTO LACQUER INTERNATIONAL RED 4L (DOMLCQINTRD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER INTERNATIONAL RED 4L', 'Paint', 'DOMLCQINTRD-4L', 'GAL/S', 0.0, 896.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 394: DOMINO AUTO LACQUER CATERPILLAR YELLOW 4L (DOMLCQCATYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER CATERPILLAR YELLOW 4L', 'Paint', 'DOMLCQCATYLW-4L', 'GAL/S', 0.0, 812.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 395: PINNACLE EPOXY ENAMEL THALO BLUE W/H 4L (PINEPENTHBLU-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'PINEPENTHBLU-4L', 'GAL/S', 0.0, 991.44, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 396: PINNACLE EPOXY ENAMEL THALO GREEN W/H 4L (PINEPENTHGR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'PINEPENTHGR-4L', 'GAL/S', 0.0, 991.44, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 397: PINNACLE EPOXY ENAMEL LEMON YELLOW W/H 4L (PINEPENLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'PINEPENLY-4L', 'GAL/S', 0.0, 1056.24, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 398: PINNACLE EPOXY ENAMEL INTERNATIONAL RED W/H 4L (PINEPENINTRD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL INTERNATIONAL RED W/H 4L', 'Paint', 'PINEPENINTRD-4L', 'GAL/S', 0.0, 1056.24, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 399: PINNACLE EPOXY ENAMEL ORANGE W/H 4L (PINEPENORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL ORANGE W/H 4L', 'Paint', 'PINEPENORNGE-4L', 'GAL/S', 0.0, 959.76, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 400: PINNACLE EPOXY ENAMEL CLEAR W/H 4L (PINEPENCLR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL CLEAR W/H 4L', 'Clearcoat', 'PINEPENCLR-4L', 'GAL/S', 0.0, 924.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 401: TIMEOUT ACRYLIC PRIMER GRAY 4L (TOACPG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC PRIMER GRAY 4L', 'Primer', 'TOACPG-4L', 'GAL', 0.0, 876.9, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 402: TIMEOUT ACRYLIC MOLYBDATE ORANGE 4L (TOACMORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC MOLYBDATE ORANGE 4L', 'Paint', 'TOACMORNGE-4L', 'GAL/S', 0.0, 922.78, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 403: TIMEOUT ACRYLIC METALLIC FINE 4L (TOACMETFNE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC METALLIC FINE 4L', 'Paint', 'TOACMETFNE-4L', 'GAL/S', 0.0, 1033.78, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 404: TIMEOUT ACRYLIC METALLIC COARSE 4L (TOACMETCRSE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC METALLIC COARSE 4L', 'Paint', 'TOACMETCRSE-4L', 'GAL/S', 0.0, 1033.78, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 405: TIMEOUT ACRYLIC LEMON YELLOW 4L (TOACLMNYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC LEMON YELLOW 4L', 'Paint', 'TOACLMNYLW-4L', 'GAL/S', 0.0, 942.76, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 406: USA EPOXY ENAMEL WHITE W/H 4L (USAEPENWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'USAEPENWHT-4L', 'GAL/S', 0.0, 985.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 407: PYLOX LAZER GRAY 45 (PYLZGRY-45)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PYLOX LAZER GRAY 45', 'Paint', 'PYLZGRY-45', 'CAN', 0.0, 79.86, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 408: DAVIES GLOSS LATEX WHITE 4L (DVGLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES GLOSS LATEX WHITE 4L', 'Paint', 'DVGLW-4L', 'GAL', 0.0, 757.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 409: TIMELESS RUBBING COMPOUND 630GRMS (TLRUBCMP-CAN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMELESS RUBBING COMPOUND 630GRMS', 'Miscellaneous', 'TLRUBCMP-CAN', 'CAN', 0.0, 373.1, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 410: TIMELESS LIQUID WAX 50ML (TLLQWX-50ML)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMELESS LIQUID WAX 50ML', 'Miscellaneous', 'TLLQWX-50ML', 'SACHET', 50.0, 44.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 411: DOMINO AUTO LACQUER PRIMER WHITE 4L (DOMLCQPRWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER PRIMER WHITE 4L', 'Primer', 'DOMLCQPRWHT-4L', 'GAL/S', 0.0, 726.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 412: DOMINO AUTO LACQUER PUTTY WHITE 4L (DOMLCQPUTYWH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER PUTTY WHITE 4L', 'Miscellaneous', 'DOMLCQPUTYWH-4L', 'GAL/S', 0.0, 778.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 413: DOMINO AUTO LACQUER METALLIC FINE 4L (DOMLCQMETFNE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER METALLIC FINE 4L', 'Paint', 'DOMLCQMETFNE-4L', 'GAL/S', 0.0, 826.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 414: DOMINO AUTO LACQUER METALLIC COARSE 4L (DOMLCQMETCRSE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER METALLIC COARSE 4L', 'Paint', 'DOMLCQMETCRSE-4L', 'GAL/S', 0.0, 826.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 415: DOMINO AUTO LACQUER GOLD TONER 4L (DOMLCQGLDTNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DOMINO AUTO LACQUER GOLD TONER 4L', 'Paint', 'DOMLCQGLDTNR-4L', 'GAL/S', 0.0, 868.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 416: TIMEOUT ACRYLIC INTERNATIONAL RED 4L (TOACINTRD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC INTERNATIONAL RED 4L', 'Paint', 'TOACINTRD-4L', 'GAL/S', 0.0, 1186.96, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 417: TIMEOUT ACRYLIC GOLD TONER 4L (TOACGLDTNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC GOLD TONER 4L', 'Paint', 'TOACGLDTNR-4L', 'GAL/S', 0.0, 1320.16, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 418: TIMEOUT ACRYLIC FIRE RED 4L (TOACFRED-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC FIRE RED 4L', 'Paint', 'TOACFRED-4L', 'GAL/S', 0.0, 1186.96, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 419: TIMEOUT ACRYLIC BLACK 4L (TOACB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMEOUT ACRYLIC BLACK 4L', 'Paint', 'TOACB-4L', 'GAL', 0.0, 831.76, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 420: TIMELESS RUBBING COMPOUND SACHET (TLRUBCMP-SACHET)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TIMELESS RUBBING COMPOUND SACHET', 'Miscellaneous', 'TLRUBCMP-SACHET', 'SACHET', 0.0, 37.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 421: NIPPON EPOXY PRIMER WHITE W/H 4L (NPEPPRWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON EPOXY PRIMER WHITE W/H 4L', 'Primer', 'NPEPPRWHT-4L', 'GAL/S', 0.0, 830.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 422: NIPPON ULTRA 8100T FD 2K CLEAR 1L (NP8100T-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR 1L', 'Clearcoat', 'NP8100T-1L', 'LTR', 60.0, 1355.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 423: NIPPON PREMIUM HS CLEAR W/H 1L (HSCLR-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON PREMIUM HS CLEAR W/H 1L', 'Clearcoat', 'HSCLR-1L', 'LTR', -48.0, 625.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 424: NAX ULTIMA P/S WHITE W/H 4L (NPULTIMA-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX ULTIMA P/S WHITE W/H 4L', 'Paint', 'NPULTIMA-4L', 'GAL/S', 0.0, 1300.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 425: NAX ULTIMA ISUZU TRAVIS WHITE 4L (NPULTIMATRVISWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX ULTIMA ISUZU TRAVIS WHITE 4L', 'Paint', 'NPULTIMATRVISWHT-4L', 'GAL/S', 0.0, 1600.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 426: NAX ULTIMA BASECOAT HARDENER 1L (NPULTIMA-HARD 1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX ULTIMA BASECOAT HARDENER 1L', 'Miscellaneous', 'NPULTIMA-HARD 1L', 'LITER', 0.0, 600.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 427: 2B PAINT ROLLER #7 W/HANDLE (2BPTRL-7)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT ROLLER #7 W/HANDLE', 'Paint', '2BPTRL-7', 'PC/S', 50.0, 58.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 428: CROCO MASKING TAPE 1/4 (CROMT-1/4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/4', 'Miscellaneous', 'CROMT-1/4', 'BOX', 0.0, 1448.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 429: EAGLE SANDPAPER 220 (EA220)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EAGLE SANDPAPER 220', 'Miscellaneous', 'EA220', 'PC/S', 0.0, 20.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 430: 2B PAINT BRUSH #1 (2BPB-1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT BRUSH #1', 'Paint', '2BPB-1', 'BOX', 1.0, 168.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 431: 2B PAINT BRUSH #1 1/2 (2BPB-1 1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT BRUSH #1 1/2', 'Paint', '2BPB-1 1/2', 'BOX', 1.0, 246.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 432: 2B PAINT BRUSH #2 1/2 (2BPB-2 1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT BRUSH #2 1/2', 'Paint', '2BPB-2 1/2', 'BOX', 0.0, 432.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 433: NAX PREMILA FF155 FLIP FLOP CONTROLLER (FF155)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PREMILA FF155 FLIP FLOP CONTROLLER', 'Paint', 'FF155', 'LTR', 0.0, 885.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 434: DAVIES FLAT LATEX WHITE 4L (DVFLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES FLAT LATEX WHITE 4L', 'Paint', 'DVFLW-4L', 'GAL', 0.0, 607.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 435: BOYSEN LTC BLACK 1L (BSLTCBLK-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN LTC BLACK 1L', 'Paint', 'BSLTCBLK-1L', 'CAN', 0.0, 87.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 436: POLYGLOSS PU FLAT BLACK 4L (PGFLTBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'Paint', 'PGFLTBLK-4L', 'GAL', -16.0, 1820.7, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 437: POLYGLOSS PU LIGHT YELLOW 4L (PGLTYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLTYLW-4L', 'GAL', 7.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 438: POLYGLOSS PU YELLOW GOLD 4L (PGYLGLD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYLGLD-4L', 'GAL', 1.0, 2283.1, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 439: POLYGLOSS PU YELLOW OXIDE 4L (PGYLOXDE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW OXIDE 4L', 'Paint', 'PGYLOXDE-4L', 'GAL', 4.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 440: POLYGLOSS PU MOLY ORANGE 4L (PGMLYORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU MOLY ORANGE 4L', 'Paint', 'PGMLYORNGE-4L', 'GAL', -5.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 441: POLYGLOSS PU BON RED 4L (PGBNRED-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU BON RED 4L', 'Paint', 'PGBNRED-4L', 'GAL', 8.0, 1965.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 442: POLYGLOSS PU 888 RED 4L (PG888RED-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU 888 RED 4L', 'Paint', 'PG888RED-4L', 'GAL', 0.0, 2309.45, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 443: POLYGLOSS PU RED GOLD 4L (PGRDGLD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRDGLD-4L', 'GAL', 6.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 444: POLYGLOSS PU PERMANENT MAROON 4L (PGPRMRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PERMANENT MAROON 4L', 'Paint', 'PGPRMRN-4L', 'GAL', 4.0, 2312.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 445: POLYGLOSS PU MAROON TONER 4L (PGMRNTNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU MAROON TONER 4L', 'Paint', 'PGMRNTNR-4L', 'GAL', 4.0, 1987.3, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 446: POLYGLOSS PU THALO BLUE 4L (PGTHBLU-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU THALO BLUE 4L', 'Paint', 'PGTHBLU-4L', 'GAL', -4.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 447: POLYGLOSS PU THALO GREEN 4L (PGTHGRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU THALO GREEN 4L', 'Paint', 'PGTHGRN-4L', 'GAL', -1.0, 1776.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 448: POLYGLOSS PU METALLIC FINE 4L (PGMETFNE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC FINE 4L', 'Paint', 'PGMETFNE-4L', 'GAL', 8.0, 1642.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 449: POLYGLOSS PU BRIGHT ALUMINUM 4L (PGBRTALUM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU BRIGHT ALUMINUM 4L', 'Paint', 'PGBRTALUM-4L', 'GAL', -1.0, 1796.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 450: POLYGLOSS PU METALLIC COARSE 4L (PGMETCRSE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'Paint', 'PGMETCRSE-4L', 'GAL', 7.0, 1642.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 451: POLYGLOSS PU APPLE RED 4L (PGAPLRED-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU APPLE RED 4L', 'Paint', 'PGAPLRED-4L', 'GAL', 6.0, 2291.6, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 452: POLYGLOSS PU SPARKLE IRID 4L (PGSPRKLIRD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU SPARKLE IRID 4L', 'Paint', 'PGSPRKLIRD-4L', 'GAL', 8.0, 1642.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 453: POLYGLOSS PU GLEAMIST WHITE 4L (PGGLEMSTWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGLEMSTWHT-4L', 'GAL', 5.0, 3003.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 454: POLYGLOSS PU GLEAMIST YELLOW 4L (PGGLEMSTYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGLEMSTYLW-4L', 'GAL', 3.0, 3003.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 455: POLYGLOSS PU GLEAMIST ORANGE 4L (PGGLEMSTORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGLEMSTORNGE-4L', 'GAL', 2.0, 3003.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 456: POLYGLOSS PU GLEAMIST COPPER 4L (PGGLEMSTCPR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST COPPER 4L', 'Paint', 'PGGLEMSTCPR-4L', 'GAL', 4.0, 3544.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 457: POLYGLOSS PU GLEAMIST RED 4L (PGGLEMSTRED-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST RED 4L', 'Paint', 'PGGLEMSTRED-4L', 'GAL', 4.0, 3003.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 458: POLYGLOSS PU GLEAMIST MAROON 4L (PGGLEMSTMRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST MAROON 4L', 'Paint', 'PGGLEMSTMRN-4L', 'GAL', 4.0, 3003.05, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 459: POLYGLOSS PU PEARL WHITE 4L (PGPRLWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PEARL WHITE 4L', 'Paint', 'PGPRLWHT-4L', 'GAL', 0.0, 2900.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 460: POLYGLOSS PU PEARL FROSTED YELLOW 4L (PGPRLFRSTDYL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED YELLOW 4L', 'Paint', 'PGPRLFRSTDYL-4L', 'GAL', 4.0, 2900.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 461: POLYGLOSS PU PEARL FROSTED ORANGE 4L (PGPRLFRSTDORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED ORANGE 4L', 'Paint', 'PGPRLFRSTDORNGE-4L', 'GAL', 0.0, 2900.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 462: POLYGLOSS PU PEARL FROSTED RED 4L (PGPRLFRSTDRD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED RED 4L', 'Paint', 'PGPRLFRSTDRD-4L', 'GAL', 4.0, 2900.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 463: POLYGLOSS PU PEARL FROSTED GREEN 4L (PGPRLFRSTDGRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED GREEN 4L', 'Paint', 'PGPRLFRSTDGRN-4L', 'GAL', 4.0, 2900.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 464: POLYGLOSS PU MICA RED FINE 4L (PGMICARDFNE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMICARDFNE-4L', 'GAL', 7.0, 2660.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 465: POLYGLOSS PU MICA RED COARSE 4L (PGMICARDCRSE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED COARSE 4L', 'Paint', 'PGMICARDCRSE-4L', 'GAL', 4.0, 2660.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 466: POLYGLOSS PU WHITE 4L (PGPUWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU WHITE 4L', 'Paint', 'PGPUWHT-4L', 'GAL', -16.0, 1632.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 467: POLYGLOSS PU JET BLACK 4L (PGPUJTBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU JET BLACK 4L', 'Paint', 'PGPUJTBLK-4L', 'GAL', 0.0, 1722.95, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 468: DAVIES EPO PATCH SET 4L (DVEPOPTCH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES EPO PATCH SET 4L', 'Paint', 'DVEPOPTCH-4L', 'SET/S', 0.0, 2655.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 469: DAVIES ALUMINUM SILVER FINISH 4L (DVSLVRALUM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES ALUMINUM SILVER FINISH 4L', 'Paint', 'DVSLVRALUM-4L', 'GAL/S', 0.0, 695.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 470: 2B PAINT BRUSH #3 (2BPB-3)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('2B PAINT BRUSH #3', 'Paint', '2BPB-3', 'BOX', 4.0, 726.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 471: BOYSEN ACRYTEX CAST 4L (BSAXCAST-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN ACRYTEX CAST 4L', 'Paint', 'BSAXCAST-4L', 'GAL', 0.0, 516.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 472: BOYSEN ACRYTEX GLOSS WHITE 4L (BSAXGLWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'Paint', 'BSAXGLWHT-4L', 'GAL', 0.0, 1043.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 473: BOYSEN FLAT LATEX BLACK 4L (BSFLLXBL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN FLAT LATEX BLACK 4L', 'Paint', 'BSFLLXBL-4L', 'GAL', 0.0, 583.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 474: DAVIES LIQUID TILE TINTING VENETIAN RED 1L (DVLIQVENRED-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE TINTING VENETIAN RED 1L', 'Paint', 'DVLIQVENRED-1L', 'LTR', 0.0, 380.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 475: DAVIES LIQUID TILE TINTING BLACK 1L (DVLIQBLK-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LIQUID TILE TINTING BLACK 1L', 'Paint', 'DVLIQBLK-1L', 'LTR', 0.0, 380.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 476: PIONEER NON-SAG MARINE EPOXY A&B (NONSAG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PIONEER NON-SAG MARINE EPOXY A&B', 'Paint', 'NONSAG-4L', 'SET/S', 0.0, 2564.32, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 477: POLYGLOSS PU VIOLET TONER 4L (PGVIOTNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU VIOLET TONER 4L', 'Paint', 'PGVIOTNR-4L', 'GAL/S', 3.0, 2291.6, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 478: POLYGLOSS ZINC-PRIMER BASED GREEN W/CAT 1L (PGZNCPR-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS ZINC-PRIMER BASED GREEN W/CAT 1L', 'Primer', 'PGZNCPR-1L', 'SET/S', 1.0, 520.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 479: RAIN OR SHINE ROS-938 MARGIE 4L (RSM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-938 MARGIE 4L', 'Paint', 'RSM-4L', 'GAL/S', 8.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 480: WEBER SPRAY GUN F-75 GRAVITY TYPE (WBRSPGUN-F75)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WEBER SPRAY GUN F-75 GRAVITY TYPE', 'Paint', 'WBRSPGUN-F75', 'PC/S', -40.0, 576.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 481: GLAZER EPOXY ENAMEL THALO GREEN W/H 4L (GLEPENTHGRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'GLEPENTHGRN-4L', 'GAL/S', 0.0, 1094.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 482: ALPHA CHROMA GLOSS LATEX WHITE 4L (ALPGLLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 4L', 'Paint', 'ALPGLLXWHT-4L', 'GAL/S', 40.0, 654.31, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 483: ALPHA CHROMA SG LATEX WHITE 4L (ALPSGLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 4L', 'Paint', 'ALPSGLXWHT-4L', 'GAL/S', 40.0, 654.31, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 484: ALPHA CHROMA SG LATEX WHITE 16L (ALPSGLXWHT-16L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 16L', 'Paint', 'ALPSGLXWHT-16L', 'PAIL/S', 1.0, 2608.23, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 485: DAVIES FLAT LATEX WHITE 16L (DVFLLXWHT-16L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES FLAT LATEX WHITE 16L', 'Paint', 'DVFLLXWHT-16L', 'PAIL/S', 0.0, 2413.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 486: DAVIES QDE BLACK 4L (DVQDBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES QDE BLACK 4L', 'Paint', 'DVQDBLK-4L', 'GAL/S', 0.0, 592.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 487: ALPHA CHROMA OTC BURNT UMBER 1/4L (ALPOTCBUMBR-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC BURNT UMBER 1/4L', 'Paint', 'ALPOTCBUMBR-1/4L', '1/4L', 10.0, 79.42, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 488: DAVIES LACQUER FLO 4L (DVALFLO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LACQUER FLO 4L', 'Paint', 'DVALFLO-4L', 'GAL/S', 3.0, 732.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 489: ALPHA CHROMA LTC RAW SIENNA 1L (ALPLTCRWSIENA-LTR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1L', 'Paint', 'ALPLTCRWSIENA-LTR', 'LTR', 0.0, 102.89, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 490: ALPHA CHROMA OTC VENETIAN RED 1/4L (ALPOTCVENRD-CAN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC VENETIAN RED 1/4L', 'Paint', 'ALPOTCVENRD-CAN', '1/4L', 12.0, 80.77, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 491: ALPHA CHROMA QDE WHITE 4L (ALPQDWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA QDE WHITE 4L', 'Paint', 'ALPQDWHT-4L', 'GAL/S', -8.0, 726.51, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 492: ALPHA CHROMA QDE BLACK 4L (ALPQDBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA QDE BLACK 4L', 'Paint', 'ALPQDBLK-4L', 'GAL/S', 0.0, 550.53, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 493: WELCOAT REGULAR QDE CALIFORNIA ORANGE 4L (WCQDCALORNGE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CALIFORNIA ORANGE 4L', 'Paint', 'WCQDCALORNGE-4L', 'GAL/S', 0.0, 884.45, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 494: ALPHA CHROMA QDE WHITE 1L (ALPQDWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA QDE WHITE 1L', 'Paint', 'ALPQDWHT-1L', 'LTR', 0.0, 194.94, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 495: GLAZER EPOXY ENAMEL CATERPILLAR YELLOW W/H 4L (GLEPENCATYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL CATERPILLAR YELLOW W/H 4L', 'Paint', 'GLEPENCATYLW-4L', 'GAL/S', 0.0, 1136.65, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 496: DAVIES SG LATEX WHITE 4L (DVSGLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES SG LATEX WHITE 4L', 'Paint', 'DVSGLXWHT-4L', 'GAL/S', 0.0, 701.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 497: OMEGA CUP BRUSH 3INXM10X1.50MM TWISTED WHITE (CUPBRSH)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('OMEGA CUP BRUSH 3INXM10X1.50MM TWISTED WHITE', 'Paint', 'CUPBRSH', 'PC/S', 0.0, 112.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 498: WEBER UNDERCOATING SPRAY GUN 616A (UNDRCOATGUN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WEBER UNDERCOATING SPRAY GUN 616A', 'Paint', 'UNDRCOATGUN', 'SET/S', 0.0, 576.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 499: OMEGA DOUBLE SIDED WOOL BUFFING PAD 8IN (BUFFPAD)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('OMEGA DOUBLE SIDED WOOL BUFFING PAD 8IN', 'Paint', 'BUFFPAD', 'PC/S', 0.0, 580.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 500: DAVIES LACQUER THINNER 4L (DLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES LACQUER THINNER 4L', 'Thinner', 'DLT-4L', 'GAL/S', 0.0, 496.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 501: BOYSEN FLAT LATEX WHITE 4L (BSFLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN FLAT LATEX WHITE 4L', 'Paint', 'BSFLXWHT-4L', 'GAL/S', 0.0, 630.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 502: WELCOAT REGULAR QDE WHITE 4L (WCQDWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 4L', 'Paint', 'WCQDWHT-4L', 'GAL/S', 0.0, 672.36, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 503: WELCOAT REGULAR QDE WHITE 1L (WCQDWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 1L', 'Paint', 'WCQDWHT-1L', 'LITER', 12.0, 181.4, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 504: WELCOAT REGULAR QDE BLACK 4L (WCQDBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WCQDBLK-4L', 'GAL/S', 16.0, 613.7, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 505: WELCOAT REGULAR QDE BLACK 1L (WCQDBLK-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 1L', 'Paint', 'WCQDBLK-1L', 'LITER', 32.0, 151.62, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 506: WELCOAT REGULAR QDE CHOCOLATE BROWN 4L (WCQDCB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 4L', 'Paint', 'WCQDCB-4L', 'GAL/S', 4.0, 559.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 507: WELCOAT REGULAR QDE CHOCOLATE BROWN 1L (WCQDCB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 1L', 'Paint', 'WCQDCB-1L', 'LITER', 12.0, 151.62, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 508: WELCOAT REGULAR FLAT LATEX WHITE 4L (WCFLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 4L', 'Paint', 'WCFLXWHT-4L', 'GAL/S', 12.0, 440.42, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 509: WELCOAT REGULAR FLAT LATEX WHITE 1L (WCFLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 1L', 'Paint', 'WCFLXWHT-1L', 'LITER', 72.0, 119.13, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 510: WELCOAT REGULAR SG LATEX WHITE 1L (WCSGLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 1L', 'Paint', 'WCSGLXWHT-1L', 'LITER', 84.0, 140.79, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 511: WELCOAT REGULAR GLOSS LATEX WHITE 1L (WCGLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 1L', 'Paint', 'WCGLXWHT-1L', 'LITER', 6.0, 140.79, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 512: WELCOAT REGULAR FLATWALL ENAMEL WHITE 4L (WCFWE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 4L', 'Paint', 'WCFWE-4L', 'GAL/S', 9.0, 626.34, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 513: WELCOAT REGULAR FLATWALL ENAMEL WHITE 1L (WCFWE-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 1L', 'Paint', 'WCFWE-1L', 'LITER', 10.0, 169.67, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 514: WELCOAT REGULAR METAL PRIMER RED OXIDE 4L (WCMPRO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 4L', 'Primer', 'WCMPRO-4L', 'GAL/S', 16.0, 413.35, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 515: WELCOAT REGULAR METAL PRIMER RED OXIDE 1L (WCMPRO-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 1L', 'Primer', 'WCMPRO-1L', 'LITER', -60.0, 114.17, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 516: ALPHA CHROMA FLAT LATEX WHITE 4L (ALPFLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 4L', 'Paint', 'ALPFLXWHT-4L', 'GAL/S', 33.0, 568.58, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 517: ALPHA CHROMA FLAT LATEX WHITE 1L (ALPFLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 1L', 'Paint', 'ALPFLXWHT-1L', 'LITER', 0.0, 152.52, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 518: ALPHA CHROMA FLAT LATEX WHITE 16L (ALPFLXWHT-16L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 16L', 'Paint', 'ALPFLXWHT-16L', 'PAIL/S', 5.0, 2265.28, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 519: ALPHA CHROMA SG LATEX WHITE 1L (ALPSGLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 1L', 'Paint', 'ALPSGLXWHT-1L', 'LITER', 0.0, 173.28, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 520: ALPHA CHROMA GLOSS LATEX WHITE 1L (ALPGLXWHT-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 1L', 'Paint', 'ALPGLXWHT-1L', 'LITER', 24.0, 173.28, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 521: ALPHA CHROMA GLOSS LATEX WHITE 16L (ALPGLXWHT-16L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 16L', 'Paint', 'ALPGLXWHT-16L', 'PAIL/S', 4.0, 2608.23, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 522: ALPHA CHROMA LTC BLACK 1L (ALPLTCBLK-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1L', 'Paint', 'ALPLTCBLK-1L', 'LITER', 8.0, 79.42, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 523: ALPHA CHROMA LTC BLACK 1/4L (ALPLTCBLK-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1/4L', 'Paint', 'ALPLTCBLK-1/4L', 'CAN', 0.0, 27.98, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 524: ALPHA CHROMA LTC BURNT SIENNA 1L (ALPLTCBS-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1L', 'Paint', 'ALPLTCBS-1L', 'LITER', 12.0, 105.59, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 525: ALPHA CHROMA LTC BURNT SIENNA 1/4L (ALPLTCBS-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1/4L', 'Paint', 'ALPLTCBS-1/4L', 'CAN', 0.0, 37.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 526: ALPHA CHROMA LTC BURNT UMBER 1L (ALPLTCBU-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1L', 'Paint', 'ALPLTCBU-1L', 'LITER', 0.0, 105.59, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 527: ALPHA CHROMA LTC BURNT UMBER 1/4L (ALPLTCBU-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1/4L', 'Paint', 'ALPLTCBU-1/4L', 'CAN', 0.0, 37.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 528: ALPHA CHROMA LTC HANZA YELLOW 1L (ALPLTCHY-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1L', 'Paint', 'ALPLTCHY-1L', 'LITER', 12.0, 132.67, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 529: ALPHA CHROMA LTC HANZA YELLOW 1/4L (ALPLTCHY-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1/4L', 'Paint', 'ALPLTCHY-1/4L', 'CAN', 11.0, 46.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 530: ALPHA CHROMA LTC THALO BLUE 1L (ALPLTCTB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1L', 'Paint', 'ALPLTCTB-1L', 'LITER', 8.0, 105.59, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 531: ALPHA CHROMA LTC THALO BLUE 1/4L (ALPLTCTB-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1/4L', 'Paint', 'ALPLTCTB-1/4L', 'CAN', 0.0, 37.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 532: ALPHA CHROMA LTC THALO GREEN 1L (ALPLTCTG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1L', 'Paint', 'ALPLTCTG-1L', 'LITER', 0.0, 105.59, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 533: ALPHA CHROMA LTC THALO GREEN 1/4L (ALPLTCTG-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1/4L', 'Paint', 'ALPLTCTG-1/4L', 'CAN', 0.0, 37.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 534: ALPHA CHROMA ACRYTILE CAST 4L (ALPATC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE CAST 4L', 'Paint', 'ALPATC-4L', 'GAL/S', -12.0, 550.53, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 535: ALPHA CHROMA ACRYTILE PRIMER WHITE 4L (ALPATPW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE 4L', 'Primer', 'ALPATPW-4L', 'GAL/S', -18.0, 870.91, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 536: ALPHA CHROMA ACRYTILE FLAT WHITE 4L (ALPATFLWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE FLAT WHITE 4L', 'Paint', 'ALPATFLWHT-4L', 'GAL/S', 4.0, 888.96, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 537: ALPHA CHROMA ACRYTILE SG WHITE 4L (ALPATSGWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE SG WHITE 4L', 'Paint', 'ALPATSGWHT-4L', 'GAL/S', 8.0, 929.58, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 538: ALPHA CHROMA ACRYTILE GLOSS WHITE 4L (ALPATGLWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'Paint', 'ALPATGLWHT-4L', 'GAL/S', 7.0, 929.58, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 539: ALPHA CHROMA ACRYTILE REDUCER 4L (ALPATR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE REDUCER 4L', 'Thinner', 'ALPATR-4L', 'GAL/S', 16.0, 500.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 540: ALPHA CHROMA POLYURETHANE FLOOR SEALER W/CATALYST 4L (ALPPUSLR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR SEALER W/CATALYST 4L', 'Primer', 'ALPPUSLR-4L', 'GAL/S', 4.0, 1064.95, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 541: ALPHA CHROMA POLYURETHANE FLOOR TOPCOAT W/CATALYST 4L (ALPPUTC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR TOPCOAT W/CATALYST 4L', 'Paint', 'ALPPUTC-4L', 'GAL/S', 7.0, 1344.73, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 542: ALPHA CHROMA POLYURETHANE REDUCER 4L (ALPPUR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE REDUCER 4L', 'Thinner', 'ALPPUR-4L', 'GAL/S', 6.0, 694.93, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 543: ALPHA CHROMA TEXTURED COATING LOW PROFILE FLAT WHITE 4L (LOPROF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA TEXTURED COATING LOW PROFILE FLAT WHITE 4L', 'Paint', 'LOPROF-4L', 'GAL/S', 4.0, 654.31, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 544: ALPHA CHROMA TEXTURED COATING HI PROFILE FLAT WHITE 4L (HIPROF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA TEXTURED COATING HI PROFILE FLAT WHITE 4L', 'Paint', 'HIPROF-4L', 'GAL/S', 4.0, 622.73, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 545: ALPHA CHROMA LTC RAW SIENNA 1/4L (ALPLTCRS-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1/4L', 'Paint', 'ALPLTCRS-1/4L', 'CAN', 0.0, 36.1, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 546: ALPHA CHROMA LTC RAW UMBER 1L (ALPLTCRU-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW UMBER 1L', 'Paint', 'ALPLTCRU-1L', 'LITER', 12.0, 105.59, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 547: ALPHA CHROMA LTC TOLUIDINE RED 1L (ALPLTCTR-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC TOLUIDINE RED 1L', 'Paint', 'ALPLTCTR-1L', 'LITER', 0.0, 100.18, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 548: ALPHA CHROMA LTC VENETIAN RED 1L (ALPLTCVR-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1L', 'Paint', 'ALPLTCVR-1L', 'LITER', 12.0, 99.28, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 549: ALPHA CHROMA LTC VENETIAN RED 1/4L (ALPLTCVR-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1/4L', 'Paint', 'ALPLTCVR-1/4L', 'CAN', 0.0, 34.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 550: ALPHA CHROMA OTC BULLETIN RED 1/4L (ALPOTCBR-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC BULLETIN RED 1/4L', 'Paint', 'ALPOTCBR-1/4L', 'CAN', 8.0, 87.54, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 551: ALPHA CHROMA OTC BURNT SIENNA 1/4L (ALPOTCBS-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC BURNT SIENNA 1/4L', 'Paint', 'ALPOTCBS-1/4L', 'CAN', 7.0, 76.71, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 552: ALPHA CHROMA OTC FRENCH YELLOW OCHRE 1/4L (ALPOTCFYO-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC FRENCH YELLOW OCHRE 1/4L', 'Paint', 'ALPOTCFYO-1/4L', 'CAN', 12.0, 77.62, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 553: ALPHA CHROMA OTC HANZA YELLOW 1/4L (ALPOTCHY-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC HANZA YELLOW 1/4L', 'Paint', 'ALPOTCHY-1/4L', 'CAN', 10.0, 91.15, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 554: ALPHA CHROMA OTC LAMP BLACK 1/4L (ALPOTCLB-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC LAMP BLACK 1/4L', 'Paint', 'ALPOTCLB-1/4L', 'CAN', 24.0, 71.3, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 555: ALPHA CHROMA OTC THALO BLUE 1/4L (ALPOTCTB-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC THALO BLUE 1/4L', 'Paint', 'ALPOTCTB-1/4L', 'CAN', 0.0, 80.77, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 556: ALPHA CHROMA OTC THALO GREEN 1/4L (ALPOTCTG-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC THALO GREEN 1/4L', 'Paint', 'ALPOTCTG-1/4L', 'CAN', 0.0, 80.77, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 557: ALPHA CHROMA OTC RAW SIENNA 1/4L (ALPOTCRS-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW SIENNA 1/4L', 'Paint', 'ALPOTCRS-1/4L', 'CAN', 11.0, 77.62, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 558: ALPHA CHROMA OTC RAW UMBER 1/4L (ALPOTCRU-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW UMBER 1/4L', 'Paint', 'ALPOTCRU-1/4L', 'CAN', 11.0, 72.2, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 559: RAIN OR SHINE ROS-933 COOL MINT 4L (RSCM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'RSCM-4L', 'GAL/S', 16.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 560: RAIN OR SHINE ROS-888 LUCKY ORANGE 4L (RSLO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-888 LUCKY ORANGE 4L', 'Paint', 'RSLO-4L', 'GAL/S', 6.0, 1308.63, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 561: RAIN OR SHINE ROS-862 IVORY 4L (RSI-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-862 IVORY 4L', 'Paint', 'RSI-4L', 'GAL/S', 7.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 562: RAIN OR SHINE ROS-829 FRESHMINT 4L (RSFM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-829 FRESHMINT 4L', 'Paint', 'RSFM-4L', 'GAL/S', 20.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 563: RAIN OR SHINE ROS-818 CHINA WHITE 4L (RSCW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-818 CHINA WHITE 4L', 'Paint', 'RSCW-4L', 'GAL/S', 6.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 564: RAIN OR SHINE ROS-739 COCONUT 4L (RSCNT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-739 COCONUT 4L', 'Paint', 'RSCNT-4L', 'GAL/S', 5.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 565: RAIN OR SHINE ROS-723 BLUE OCEAN 4L (RSBO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-723 BLUE OCEAN 4L', 'Paint', 'RSBO-4L', 'GAL/S', 17.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 566: RAIN OR SHINE ROS-701 BAGUIO GREEN 4L (RSBG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-701 BAGUIO GREEN 4L', 'Paint', 'RSBG-4L', 'GAL/S', 1.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 567: RAIN OR SHINE ROS-678 GOLDEN BUTTER 4L (RSGB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-678 GOLDEN BUTTER 4L', 'Paint', 'RSGB-4L', 'GAL/S', 8.0, 690.41, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 568: RAIN OR SHINE ROS-633 CHOCOLATE BROWN 4L (RSCB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-633 CHOCOLATE BROWN 4L', 'Paint', 'RSCB-4L', 'GAL/S', 6.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 569: RAIN OR SHINE ROS-629 TULIPS 4L (RSTLPS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'RSTLPS-4L', 'GAL/S', 7.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 570: RAIN OR SHINE ROS-618 HAPPY DAYS 4L (RSHD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-618 HAPPY DAYS 4L', 'Paint', 'RSHD-4L', 'GAL/S', 1.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 571: RAIN OR SHINE ROS-559 BRIDAL GOWN 4L (RSBGWN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-559 BRIDAL GOWN 4L', 'Paint', 'RSBGWN-4L', 'GAL/S', 7.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 572: RAIN OR SHINE ROS-538 SAFARI BROWN 4L (RSSB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-538 SAFARI BROWN 4L', 'Paint', 'RSSB-4L', 'GAL/S', 9.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 573: RAIN OR SHINE ROS-530 GENTLE TOUCH 4L (RSGT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-530 GENTLE TOUCH 4L', 'Paint', 'RSGT-4L', 'GAL/S', 12.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 574: RAIN OR SHINE ROS-518 TEMPTATION 4L (RST-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-518 TEMPTATION 4L', 'Paint', 'RST-4L', 'GAL/S', 8.0, 735.54, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 575: RAIN OR SHINE ROS-513 CITRUS 4L (RSC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-513 CITRUS 4L', 'Paint', 'RSC-4L', 'GAL/S', 12.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 576: RAIN OR SHINE ROS-381 SERENITY 4L (RSS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-381 SERENITY 4L', 'Paint', 'RSS-4L', 'GAL/S', 8.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 577: RAIN OR SHINE ROS-368 MY WAY 4L (RSMW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-368 MY WAY 4L', 'Paint', 'RSMW-4L', 'GAL/S', 17.0, 690.41, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 578: RAIN OR SHINE ROS-367 CANDY TUFT 4L (RSCT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-367 CANDY TUFT 4L', 'Paint', 'RSCT-4L', 'GAL/S', 9.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 579: RAIN OR SHINE ROS-313 IRVINE PEACH 4L (RSIP-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-313 IRVINE PEACH 4L', 'Paint', 'RSIP-4L', 'GAL/S', 8.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 580: RAIN OR SHINE ROS-298 OH SO RED 4L (RSOSR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-298 OH SO RED 4L', 'Paint', 'RSOSR-4L', 'GAL/S', 6.0, 812.25, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 581: RAIN OR SHINE ROS-223 NICOLE PINK 4L (RSNP-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-223 NICOLE PINK 4L', 'Paint', 'RSNP-4L', 'GAL/S', 4.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 582: RAIN OR SHINE ROS-175 ROMANCE 4L (RSR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-175 ROMANCE 4L', 'Paint', 'RSR-4L', 'GAL/S', 8.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 583: RAIN OR SHINE ROS-171 TOUCH OF GRAY 4L (RSTOG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-171 TOUCH OF GRAY 4L', 'Paint', 'RSTOG-4L', 'GAL/S', 10.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 584: RAIN OR SHINE ROS-115 STONE GRAY 4L (RSSG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-115 STONE GRAY 4L', 'Paint', 'RSSG-4L', 'GAL/S', 13.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 585: RAIN OR SHINE ROS-109 TULLE WHITE 4L (RSTW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-109 TULLE WHITE 4L', 'Paint', 'RSTW-4L', 'GAL/S', 7.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 586: RAIN OR SHINE ROS-101 TERRA COTTA 4L (RSTC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-101 TERRA COTTA 4L', 'Paint', 'RSTC-4L', 'GAL/S', 8.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 587: RAIN OR SHINE ROS-100 WHITE 4L (RSW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE ROS-100 WHITE 4L', 'Paint', 'RSW-4L', 'GAL/S', 11.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 588: RAIN OR SHINE PREPA WHITE 4L (PREPA-WHITE)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'Paint', 'PREPA-WHITE', 'GAL', 12.0, 518.94, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 589: ALPHA CHROMA LTC BLACK 1L (DOUBLE ENTRY) (ALPLTCB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1L (DOUBLE ENTRY)', 'Paint', 'ALPLTCB-1L', 'LTR/S', 0.0, 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 590: GLAZER AUTO ENAMEL 5615 WHITE 4L (GLAEWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5615 WHITE 4L', 'Paint', 'GLAEWHT-4L', 'GAL/S', 12.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 591: GLAZER AUTO ENAMEL 5695 METALLIC FINE 4L (GLAEMF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5695 METALLIC FINE 4L', 'Paint', 'GLAEMF-4L', 'GAL/S', 0.0, 772.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 592: GLAZER AUTO ENAMEL 5696 METALLIC COURSE 4L (GLAEMC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5696 METALLIC COURSE 4L', 'Paint', 'GLAEMC-4L', 'GAL/S', 0.0, 772.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 593: GLAZER AUTO ENAMEL 5665 THALO BLUE 4L (GLAETB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5665 THALO BLUE 4L', 'Paint', 'GLAETB-4L', 'GAL/S', 2.0, 772.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 594: GLAZER AUTO ENAMEL 5655 THALO GREEN 4L (GLAETG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5655 THALO GREEN 4L', 'Paint', 'GLAETG-4L', 'GAL/S', 3.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 595: GLAZER AUTO ENAMEL 5632 MOLY ORANGE 4L (GLAEMO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5632 MOLY ORANGE 4L', 'Paint', 'GLAEMO-4L', 'GAL/S', 0.0, 837.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 596: GLAZER AUTO ENAMEL 5642 INTERNATIONAL RED 4L (GLAEIR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5642 INTERNATIONAL RED 4L', 'Paint', 'GLAEIR-4L', 'GAL/S', 0.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 597: GLAZER AUTO ENAMEL 5645 FIRE RED 4L (GLAEFR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5645 FIRE RED 4L', 'Paint', 'GLAEFR-4L', 'GAL/S', 4.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 598: GLAZER AUTO ENAMEL 5623 LEMON YELLOW 4L (GLAELY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5623 LEMON YELLOW 4L', 'Paint', 'GLAELY-4L', 'GAL/S', 0.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 599: GLAZER AUTO ENAMEL 5625 CATERPILLAR YELLOW 4L (GLAECY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5625 CATERPILLAR YELLOW 4L', 'Paint', 'GLAECY-4L', 'GAL/S', 0.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 600: GLAZER AUTO ENAMEL 5690 BLACK 4L (GLAEBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5690 BLACK 4L', 'Paint', 'GLAEBLK-4L', 'GAL/S', 7.0, 708.1, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 601: GLAZER AUTO ENAMEL 5699 FLAT BLACK 4L (GLAEFB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5699 FLAT BLACK 4L', 'Paint', 'GLAEFB-4L', 'GAL/S', 4.0, 772.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 602: GLAZER AUTO ENAMEL 5648 MAROON 4L (GLAEMRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5648 MAROON 4L', 'Paint', 'GLAEMRN-4L', 'GAL/S', 0.0, 793.48, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 603: BOYSEN EPOXY ENAMEL WHITE W/H 4L (BSEPENWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('BOYSEN EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'BSEPENWHT-4L', 'GAL/S', 0.0, 1274.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 604: USA EPOXY PRIMER RED OXIDE W/H 4L (USAEPRO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 4L', 'Primer', 'USAEPRO-4L', 'GAL/S', 0.0, 590.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 605: USA EPOXY ENAMEL THALO BLUE W/H 4L (USAEPENTB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'USAEPENTB-4L', 'GAL/S', 0.0, 898.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 606: CUMI SANDMASTER FLOOR SANDING #36 (50MTR) (SNDMSTER-36)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('CUMI SANDMASTER FLOOR SANDING #36 (50MTR)', 'Paint', 'SNDMSTER-36', 'ROLL', 0.0, 9590.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 607: ROBERLO SILTEX 800 PREMIUM HS STONECHIP BLACK 1L (ROBSLTX)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ROBERLO SILTEX 800 PREMIUM HS STONECHIP BLACK 1L', 'Paint', 'ROBSLTX', 'LITER', 0.0, 455.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 608: WELCOAT REGULAR SG LATEX WHITE 4L (WCSGLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 4L', 'Paint', 'WCSGLXWHT-4L', 'GAL/S', 14.0, 521.65, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 609: WELCOAT REGULAR GLOSS LATEX WHITE 4L (WCGLXWHT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 4L', 'Paint', 'WCGLXWHT-4L', 'GAL/S', 20.0, 521.65, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 610: ADD ON 12% (ADD)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ADD ON 12%', 'Paint', 'ADD', 'Piece', 0.0, 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 611: NIPPON ULTRA 8300F CRYSTAL 2K CLEAR W/H 1L (NP8300-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NIPPON ULTRA 8300F CRYSTAL 2K CLEAR W/H 1L', 'Clearcoat', 'NP8300-1L', 'LTR/S', 0.0, 1505.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 612: NAX PP BUMPER PRIMER CLEAR 1L (PRI122)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER CLEAR 1L', 'Clearcoat', 'PRI122', 'LTR/S', 0.0, 665.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 613: POLYGLOSS PU TOPCOAT CLEAR W/H 1L (PGPUTC-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU TOPCOAT CLEAR W/H 1L', 'Clearcoat', 'PGPUTC-1L', 'LTR/S', -24.0, 430.1, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 614: POLYGLOSS PU SPRAY FILLER LIGHT GRAY W/H 1L (PGPUSF-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU SPRAY FILLER LIGHT GRAY W/H 1L', 'Paint', 'PGPUSF-1L', 'LTR/S', 35.0, 380.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 615: POLYGLOSS PU COLOR CATALYST CAN (PGCAT-CAN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS PU COLOR CATALYST CAN', 'Paint', 'PGCAT-CAN', 'CAN', 0.0, 216.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 616: POLYGLOSS URETHANE THINNER 4L (PGPUTH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('POLYGLOSS URETHANE THINNER 4L', 'Thinner', 'PGPUTH-4L', 'GAL/S', -60.0, 569.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 617: RAIN OR SHINE RS-393 FOXY 4L (RSF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-393 FOXY 4L', 'Paint', 'RSF-4L', 'GAL/S', 8.0, 749.08, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 618: RAIN OR SHINE RS-809 MILK 4L (RSMLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-809 MILK 4L', 'Paint', 'RSMLK-4L', 'GAL/S', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 619: RAIN OR SHINE RS-309 LAVENDER 4L (RSL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-309 LAVENDER 4L', 'Paint', 'RSL-4L', 'GAL/S', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 620: RAIN OR SHINE RS-111 BLACK 4L (RSB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-111 BLACK 4L', 'Paint', 'RSB-4L', 'GAL/S', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 621: RAIN OR SHINE RS-363 ANGELINA 4L (RSA-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-363 ANGELINA 4L', 'Paint', 'RSA-4L', 'GAL/S', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 622: RAIN OR SHINE RS-833 ALMOST BLACK 4L (RSAB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-833 ALMOST BLACK 4L', 'Paint', 'RSAB-4L', 'GAL/S', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 623: RAIN OR SHINE RS-1000 XTRA GLOSS 4L (RSXG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('RAIN OR SHINE RS-1000 XTRA GLOSS 4L', 'Paint', 'RSXG-4L', 'GAL/S', 7.0, 609.19, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 624: TREND FLAT LATEX WHITE 4L (TFLXW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TREND FLAT LATEX WHITE 4L', 'Paint', 'TFLXW-4L', 'GAL/S', 32.0, 270.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 625: TREND SG LATEX WHITE 4L (TSGLXW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TREND SG LATEX WHITE 4L', 'Paint', 'TSGLXW-4L', 'GAL/S', 32.0, 405.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 626: TREND GLOSS LATEX WHITE 4L (TGLXW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('TREND GLOSS LATEX WHITE 4L', 'Paint', 'TGLXW-4L', 'GAL/S', 32.0, 450.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 627: USA EPOXY PRIMER WHITE W/H 1L (USAEPW-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER WHITE W/H 1L', 'Primer', 'USAEPW-1L', 'LTR/S', 24.0, 183.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 628: USA EPOXY PRIMER GRAY W/H 1L (USAEPG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER GRAY W/H 1L', 'Primer', 'USAEPG-1L', 'LTR/S', 12.0, 175.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 629: USA EPOXY PRIMER RED OXIDE W/H 1L (USAEPRO-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 1L', 'Primer', 'USAEPRO-1L', 'LTR/S', 12.0, 166.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 631: ALPHA CHROMA POLYURETHANE TOPCOAT W/H 1L (ALPPUTC-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE TOPCOAT W/H 1L', 'Paint', 'ALPPUTC-1L', 'LTR/S', 0.0, 361.9, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 632: ARKHON SKIM COAT 4L (ASKM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ARKHON SKIM COAT 4L', 'Paint', 'ASKM-4L', 'GAL/S', 0.0, 347.46, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 633: WELCOAT REGULAR QDE MAROON 4L (WCQDM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE MAROON 4L', 'Paint', 'WCQDM-4L', 'GAL/S', 0.0, 694.93, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 634: DAVIES QDE SILVER FINISH ALUMINUM 4L (DVQDAS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES QDE SILVER FINISH ALUMINUM 4L', 'Paint', 'DVQDAS-4L', 'GAL/S', 0.0, 757.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 635: SUN AND RAIN LOVELY DAYS 4L (SRLD-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('SUN AND RAIN LOVELY DAYS 4L', 'Paint', 'SRLD-4L', 'GAL/S', 0.0, 698.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 636: SUN AND RAIN BLACK 4L (SRBLK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('SUN AND RAIN BLACK 4L', 'Paint', 'SRBLK-4L', 'GAL/S', 0.0, 698.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 637: PLYOX LAZER HI-HEAT BLACK (HIHEAT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('PLYOX LAZER HI-HEAT BLACK', 'Paint', 'HIHEAT', 'CAN', 0.0, 150.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 638: EMPTY CAN LITER (CAN-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('EMPTY CAN LITER', 'Paint', 'CAN-1L', 'CAN', 0.0, 4.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 639: GLAZER EPOXY ENAMEL THALO BLUE W/H 4L (GLEENTB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'GLEENTB-4L', 'GAL', 7.0, 1094.8, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 640: WEBER EPOXY ENAMEL BLACK W/H 4L (WBREEB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WEBER EPOXY ENAMEL BLACK W/H 4L', 'Paint', 'WBREEB-4L', 'GAL', 0.0, 1260.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 641: USA EPOXY PRIMER GRAY W/H 4L (USAEPG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER GRAY W/H 4L', 'Primer', 'USAEPG-4L', 'GAL', 40.0, 780.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 642: USA EPOXY PRIMER WHITE W/H 4L (USAEPW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY PRIMER WHITE W/H 4L', 'Primer', 'USAEPW-4L', 'GAL', 0.0, 753.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 643: DAVIES QDE CRYSTAL GREEN 4L (DVQDCG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('DAVIES QDE CRYSTAL GREEN 4L', 'Paint', 'DVQDCG-4L', 'GAL', 0.0, 851.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 644: APLUS LACQUER THINNER 4L (APLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('APLUS LACQUER THINNER 4L', 'Thinner', 'APLT-4L', 'GAL', 0.0, 517.27, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 645: ALPHA CHROMA ROOF AZURE BLUE 4L (ARAB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ROOF AZURE BLUE 4L', 'Paint', 'ARAB-4L', 'GAL', 0.0, 654.31, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 646: ALPHA CHROMA ROOF BAGUIO GREEN 4L (ARBG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ROOF BAGUIO GREEN 4L', 'Paint', 'ARBG-4L', 'GAL', 0.0, 631.75, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 647: ALPHA CHROMA ROOF SPANISH RED 4L (ARSR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ROOF SPANISH RED 4L', 'Paint', 'ARSR-4L', 'GAL', 0.0, 564.06, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 648: ALPHA CHROMA ROOF TERRA COTTA 4L (ARTC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('ALPHA CHROMA ROOF TERRA COTTA 4L', 'Paint', 'ARTC-4L', 'GAL', 0.0, 582.11, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 649: USA EPOXY ENAMEL THALO GREEN W/H 4L (USAEPENTG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('USA EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'USAEPENTG-4L', 'GAL', 0.0, 940.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 650: WELCOAT REGULAR QDE APPLE GREEN 4L (WCQDAG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE APPLE GREEN 4L', 'Paint', 'WCQDAG-4L', 'GAL', -8.0, 731.03, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 651: WELCOAT REGULAR BABY PINK 4L (WCQDBP-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR BABY PINK 4L', 'Paint', 'WCQDBP-4L', 'GAL', -8.0, 857.38, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 652: WELCOAT REGULAR QDE CRYSTAL BLUE 4L (WCQDCRB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL BLUE 4L', 'Paint', 'WCQDCRB-4L', 'GAL', -8.0, 685.9, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 653: WELCOAT REGULAR QDE CRYSTAL GREEN 4L (WCQDCG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL GREEN 4L', 'Paint', 'WCQDCG-4L', 'GAL', -8.0, 694.93, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 654: WELCOAT REGULAR QDE MANDARIN RED 4L (WCQDMR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE MANDARIN RED 4L', 'Paint', 'WCQDMR-4L', 'GAL', -8.0, 920.55, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 655: WELCOAT REGULAR QDE SKY BLUE 4L (WCQDSB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT REGULAR QDE SKY BLUE 4L', 'Paint', 'WCQDSB-4L', 'GAL', -8.0, 685.9, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 656: WELCOAT PREMIUM OTC THALO BLUE CAN (WPOTCTB-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, dealers_price, branch_id)
  VALUES ('WELCOAT PREMIUM OTC THALO BLUE CAN', 'Paint', 'WPOTCTB-1/4L', 'CAN', 11.0, 80.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      dealers_price = EXCLUDED.dealers_price,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  RAISE NOTICE 'Successfully migrated Valencia Distribution master data: 646 items, 3 suppliers, 10 customers.';
END $MIGRATION$;