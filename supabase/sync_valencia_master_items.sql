-- ====================================================================
-- SYNCHRONIZE VALENCIA COLOURSMILE FULL MASTER DATABASE (509 ITEMS)
-- Source: Google Sheet (Copy of VALENCIA COLOURSMILE DATABASE, gid=0)
-- Expected Total Stock Value: PHP 1,231,168.88
-- Total Master Items: 509
-- ====================================================================
DO $SYNC$
DECLARE
  v_branch_id UUID;
BEGIN
  -- Find Valencia ColourSmile branch ID
  SELECT id INTO v_branch_id FROM public.branches 
  WHERE name ILIKE '%Valencia ColourSmile%' OR (name ILIKE '%Valencia%' AND name NOT ILIKE '%Distribution%') 
  LIMIT 1;

  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Valencia ColourSmile branch not found!';
  END IF;

  -- Row 10: RAIN OR SHINE CHOCOLATE BROWN 4L (ROS-633)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHOCOLATE BROWN 4L', 'Paint', 'ROS-633', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 11: RAIN OR SHINE CHOCOLATE BROWN 1L (ROSCB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHOCOLATE BROWN 1L', 'Paint', 'ROSCB-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 12: RAIN OR SHINE BAGUIO GREEN 4L (ROS-701)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'Paint', 'ROS-701', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 13: POLYGLOSS URETHANE THINNER 4L (POLYGTHIN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS URETHANE THINNER 4L', 'Thinner', 'POLYGTHIN-4L', 'GALON', 0.0, 675.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 14: POLYGLOSS PU PHTHALO BLUE 4L (PGTB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PHTHALO BLUE 4L', 'Paint', 'PGTB-4L', 'GALON', 0.0, 1883.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 15: POLYGLOSS PU MICA RED FINE 4L (PGMF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMF-4L', 'GALON', 0.0, 2822.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 16: POLYGLOSS PU METALLIC COARSE 4L (PGMC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'Paint', 'PGMC-4L', 'GALON', 0.0, 1743.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 17: POLYGLOSS PU JET BLACK 4L (PGJB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU JET BLACK 4L', 'Paint', 'PGJB-4L', 'GALON', 0.0, 1828.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 18: POLYGLOSS PU FLAT BLACK 4L (PGFB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'Paint', 'PGFB-4L', 'GALON', -1.0, 1930.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 19: POLYGLOSS ANTI-CORROSSION (PGANTI-C-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS ANTI-CORROSSION', 'Paint', 'PGANTI-C-1L', 'LITER', 3.0, 440.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 20: PLATONE QDE WHITE 4L (PLQDW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 4L', 'Paint', 'PLQDW-4L', 'GAL', -1.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 21: PLATONE QDE BLACK 1L (PLQDB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 1L', 'Paint', 'PLQDB-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 22: NIPPON SEALERMAX 5170 4L (SEALERMAX5170-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON SEALERMAX 5170 4L', 'Paint', 'SEALERMAX5170-4L', 'GAL/S', 0.0, 960.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 23: NIPPON ROLLER PAINT #7 (NPR7)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROLLER PAINT #7', 'Paint', 'NPR7', 'PC/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 24: NAX SOB757 HIGH GRADE URETHANE THINNER 4L (SOB757)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Thinner', 'SOB757', 'GAL', 22.2675, 570.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 25: BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY) (BSAXGLWHTE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)', 'Paint', 'BSAXGLWHTE-4L', 'GALON', 0.0, 1080.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 26: BOYSEN ACRYTEX GLOSS WHITE 4L (B-1710)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'Paint', 'B-1710', 'GALON', 0.0, 1096.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 27: URETHANE MIXING POLYGLOSS, DO IT 1L (UTMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'Paint', 'UTMIX-1L', 'LITER', 27.0, 850.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 28: RAIN OR SHINE- HAPPY DAYS 4L (ROS- HAPPY DAYS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'Paint', 'ROS- HAPPY DAYS-4L', 'GALON', 0.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 29: POLYGLOSS-BRIGHT ALUMINUM 4L (POLY- BT-ALUM-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'Paint', 'POLY- BT-ALUM-4L', 'GALON', 0.0, 1950.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 30: ALPHA CHROMA ACRYTILE REDUCER (ACRY- REDUCER-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE REDUCER', 'Paint', 'ACRY- REDUCER-4L', 'GALON', 0.0, 550.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 31: WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L (ROS-SR-100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-100', '4L', 2.0, 672.4, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 32: WELCOAT REGULAR SEMI-GLOSS LATEX WHITE 4L (WRSGW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR SEMI-GLOSS LATEX WHITE 4L', 'Paint', 'WRSGW-4L', 'GALON', 0.0, 558.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 33: WELCOAT REGULAR QDE WHITE 4L (WQD1000-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 4L', 'Paint', 'WQD1000-4L', 'GALON', 0.0, 695.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 34: WELCOAT REGULAR QDE BLACK 4L (WQD1150-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WQD1150-4L', 'GALON', 1.0, 570.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 35: QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L (QDEMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'Paint', 'QDEMIX-1L', 'LITER', 9.75, 200.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 36: WELCOAT ACRY-TILE TINTING COLOR PHTHALO GREEN PWAC-9042 (PWAC-9042-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO GREEN PWAC-9042', 'Paint', 'PWAC-9042-1L', 'LITER', 3.0, 402.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 37: WELCOAT ACRY-TILE TINTING COLOR PHTHALO BLUE PWAC-7242 (PWAC-7242-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO BLUE PWAC-7242', 'Paint', 'PWAC-7242-1/4L', 'CAN', 12.0, 111.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 38: WELCOAT ACRY-TILE TINTING COLOR PERMANENT RED PWAC-2142 (PWAC-2142-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PERMANENT RED PWAC-2142', 'Paint', 'PWAC-2142-1L', 'LITER', 2.0, 461.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 39: WELCOAT ACRY-TILE TINTING COLOR HANSA YELLOW PWAC-5042 (PWAC-5042-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR HANSA YELLOW PWAC-5042', 'Paint', 'PWAC-5042-1/4L', 'CAN', 12.0, 141.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 40: WASTE COTTON POD (WCPOD)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WASTE COTTON POD', 'Miscellaneous', 'WCPOD', 'KL', 23.5, 70.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 41: VULCASEAL (VSEAL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('VULCASEAL', 'Paint', 'VSEAL', 'PCS', 3.0, 62.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 42: VIBRANT RUBY ROS-823 RAIN OR SHINE 4L (ROS-823)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('VIBRANT RUBY ROS-823 RAIN OR SHINE 4L', 'Paint', 'ROS-823', '4L', 2.0, 1015.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 43: VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES (AC-11-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES', 'Paint', 'AC-11-1L', '1L', 4.0, 108.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 44: UNO PAINT THINNER BOT (UNOPT-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('UNO PAINT THINNER BOT', 'Thinner', 'UNOPT-BOT', 'PC/S', 0.0, 52.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 45: UNO LACQUER THINNER BOT (UNOLT-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER BOT', 'Thinner', 'UNOLT-BOT', 'BOT', 0.0, 50.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 46: UNO LACQUER THINNER 4L (UNOLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER 4L', 'Thinner', 'UNOLT-4L', 'GAL/S', 1.0, 360.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 47: TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES (AC-10-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'Paint', 'AC-10-1L', '1L', 0.0, 108.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 48: TIMEOUT URETHANE THINNER 4L (TOUT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT URETHANE THINNER 4L', 'Thinner', 'TOUT-4L', 'GAL', 0.0, 510.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 49: TIMEOUT BODY FILLER WITH HARDENER 4L (TOBF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Miscellaneous', 'TOBF-4L', 'GAL', 22.0, 585.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 50: TIMEOUT BODY FILLER WITH HARDENER 1L (TOBF-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Miscellaneous', 'TOBF-1L', 'LTR', 8.0, 160.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 51: TIMEOUT ACRYLIC THINNER 4L (TOAT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Thinner', 'TOAT-4L', 'GAL', 0.0, 500.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 52: TIMEOUT ACRYLIC THALO BLUE 4L (TOTHALOBLU-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOTHALOBLU-4L', 'GAL', 3.0, 1060.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 53: TIMELESS PREMIUM LIQUID WAX 5OML (TLWAX)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'Miscellaneous', 'TLWAX', 'PC/S', 27.0, 50.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 54: TILE RED ROS-302 RAIN OR SHINE 4L (ROS-302)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TILE RED ROS-302 RAIN OR SHINE 4L', 'Paint', 'ROS-302', '4L', 0.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 55: THALO GREEN ACRY-COLOR AC-30 1L DAVIES (AC-30-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('THALO GREEN ACRY-COLOR AC-30 1L DAVIES', 'Paint', 'AC-30-1L', '1L', 6.0, 103.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 56: THALO BLUE ACRY-COLOR AC-20 1L DAVIES (AC-20-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'Paint', 'AC-20-1L', '1L', 0.0, 103.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 57: TEXAS RUBBERIZED (TEXAS)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('TEXAS RUBBERIZED', 'Paint', 'TEXAS', 'GAL', 0.0, 500.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 58: SUPRA GLOSS (TURTLE WAX) (MTX)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SUPRA GLOSS (TURTLE WAX)', 'Miscellaneous', 'MTX', 'LTR', 11.0, 700.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 59: SPRAY GUN F-75G WEBER (WEBER)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SPRAY GUN F-75G WEBER', 'Paint', 'WEBER', 'SET', 0.0, 750.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 60: SEMI GLOSS WHITE ACRYLIC LATEX B-715 BOYSEN 4L (B-715)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SEMI GLOSS WHITE ACRYLIC LATEX B-715 BOYSEN 4L', 'Paint', 'B-715', '4L', 0.0, 728.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 61: SAND PAPER #80 (EA80)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SAND PAPER #80', 'Miscellaneous', 'EA80', 'PC/S', 136.0, 28.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 62: SAND PAPER #100 (EA100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SAND PAPER #100', 'Miscellaneous', 'EA100', 'PC/S', 103.0, 28.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 63: SAMAR BEIGE SUN ROOF ROS-SR-183 RAIN OR SHINE 4L (ROS-SR-183)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('SAMAR BEIGE SUN ROOF ROS-SR-183 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-183', '4L', 2.0, 577.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 64: RUGBY (RUGBY)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RUGBY', 'Paint', 'RUGBY', 'PCS', 15.0, 66.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 65: ROBFILTER PAINT STRAINER 125M (ROBPNTSTRNR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 'PC/S', 8.0, 11.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 66: ROBERLO TACK CLOTH (ROBTCKCLTH)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ROBERLO TACK CLOTH', 'Miscellaneous', 'ROBTCKCLTH', 'PCS', 8.0, 40.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 67: ROBERLO RUBBING COMPOUND 1KG (ROBRC-1KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Miscellaneous', 'ROBRC-1KG', 'KG', 3.3, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 68: REDUCER ACRYTEX B-1750 BOYSEN 4L (B-1750)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('REDUCER ACRYTEX B-1750 BOYSEN 4L', 'Paint', 'B-1750', '4L', 0.0, 479.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 69: RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT (PWTCO-4333)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-4333', '1/4L', 1.0, 72.02, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 70: RAW UMBER ACRY-COLOR PWTAC-4317 1L WELCOAT PREMIUM (PWTAC-4317-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAW UMBER ACRY-COLOR PWTAC-4317 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-4317-1L', '1L', 6.0, 104.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 71: RAW SIENNA ACRY-COLOR AC-90 1L DAVIES (AC-90-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAW SIENNA ACRY-COLOR AC-90 1L DAVIES', 'Paint', 'AC-90-1L', '1L', 2.0, 115.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 72: RAIN OR SHINE XTRA GLOSS 4L (ROS-1000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE XTRA GLOSS 4L', 'Paint', 'ROS-1000', 'GALON', 0.0, 656.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 73: RAIN OR SHINE TULLE WHITE (ROS-109)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE TULLE WHITE', 'Paint', 'ROS-109', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 74: RAIN OR SHINE TOUCH OF GRAY (ROS-171)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE TOUCH OF GRAY', 'Paint', 'ROS-171', 'GALON', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 75: RAIN OR SHINE STONE GRAY 4L (ROS-SG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE STONE GRAY 4L', 'Paint', 'ROS-SG-4L', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 76: RAIN OR SHINE ROS-933 COOL MINT 4L (ROS-933-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'ROS-933-4L', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 77: RAIN OR SHINE ROS-629 TULIPS 4L (ROS-629-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'ROS-629-4L', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 78: RAIN OR SHINE PREPA WHITE 4L (ROS-7000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'Paint', 'ROS-7000', 'GALON', 0.0, 546.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 79: RAIN OR SHINE OCEAN BLUE 4L (ROS-OB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE OCEAN BLUE 4L', 'Paint', 'ROS-OB-4L', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 80: RAIN OR SHINE NICOLE PINK 4L (ROS-223)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE NICOLE PINK 4L', 'Paint', 'ROS-223', 'GALON', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 81: RAIN OR SHINE MY WAY 4L (ROS-368)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MY WAY 4L', 'Paint', 'ROS-368', 'GALON', 0.0, 727.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 82: RAIN OR SHINE MIX GREEN 4L (ROSGRN-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MIX GREEN 4L', 'Paint', 'ROSGRN-4L', 'GALON', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 83: RAIN OR SHINE MIX GARY 4L (ROSG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MIX GARY 4L', 'Paint', 'ROSG-4L', 'GALON', 0.0, 950.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 84: RAIN OR SHINE LUCKY ORANGE 4L (ROS-888)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE LUCKY ORANGE 4L', 'Paint', 'ROS-888', 'GALON', 0.0, 1391.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 85: RAIN OR SHINE IVORY 4L (ROS-862)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE IVORY 4L', 'Paint', 'ROS-862', 'GALON', 1.0, 655.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 86: RAIN OR SHINE GRAY LATEX 4L (ROSGRAY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE GRAY LATEX 4L', 'Paint', 'ROSGRAY-4L', 'GALON', 0.0, 800.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 87: RAIN OR SHINE CHINA WHITE 4L (ROS-818)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHINA WHITE 4L', 'Paint', 'ROS-818', 'GALON', 0.0, 665.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 88: Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L (QSHG710-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'Paint', 'QSHG710-5L', 'GAL', 11.0, 851.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 89: Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L (QSHG710-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L', 'Paint', 'QSHG710-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 90: Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L (QSHG710-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 'PAIL', 4.0, 2442.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 91: PYLOX LAZER WHITE 02 (PYLZWH-02)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', 'CAN', -1.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 92: PYLOX LAZER VIOLET 20 (PLYZVIO-20)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PLYZVIO-20', 'CAN', 10.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 93: PYLOX LAZER SKY BLUE 22 (PLYZSKBL-22)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PLYZSKBL-22', 'CAN', 4.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 94: PYLOX LAZER SILVER 42 (PLYZSIL-42)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PLYZSIL-42', 'CAN', 2.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 95: PYLOX LAZER PRIMER GRAY 145 (PLYZPRGR-145)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Primer', 'PLYZPRGR-145', 'CAN', 1.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 96: PYLOX LAZER MATT WHITE 03 (PLYZMTW-03)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PLYZMTW-03', 'CAN', 3.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 97: PYLOX LAZER LIGHT GREEN 33 (PLYZLTGR-33)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PLYZLTGR-33', 'CAN', 4.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 98: PYLOX LAZER HEAT RESISTANT SILVER 709 (PLYZHTRSIL-709)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PLYZHTRSIL-709', 'CAN', 4.0, 162.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 99: PYLOX LAZER GOLD 705 (PLYZGLD-705)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PLYZGLD-705', 'CAN', 1.0, 117.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 100: PYLOX LAZER GLOSS BLACK 48 (PLYZGBLK-48)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PLYZGBLK-48', 'CAN', 2.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 101: PYLOX LAZER FLOURESCENT VIOLET 604 (PLYZFLOUVIO-604)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PLYZFLOUVIO-604', 'CAN', 8.0, 135.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 102: PYLOX LAZER FLOURESCENT PINK 603 (PLYZFLOURPNK-603)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PLYZFLOURPNK-603', 'CAN', 3.0, 135.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 103: PYLOX LAZER FLOURESCENT ORANGE 601 (PLYZFLOURANGE-601)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PLYZFLOURANGE-601', 'CAN', 8.0, 135.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 104: PYLOX LAZER DISTINGUISHED SILVER 701 (PLYZDISIL-701)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PLYZDISIL-701', 'CAN', 10.0, 117.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 105: PYLOX LAZER DEEP RED 17 (PLYZDR-17)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PLYZDR-17', 'CAN', 4.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 106: PYLOX LAZER CLEAR 01 (PLYZCLR-01)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CLEAR 01', 'Clearcoat', 'PLYZCLR-01', 'CAN', 3.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 107: PYLOX LAZER CANDYTONE RED 801 (PLYZCANRED-801)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PLYZCANRED-801', 'CAN', 11.0, 110.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 108: PYLOX LAZER ART YELLOW 06 (PYLZAY-06)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 'CAN', 8.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 109: PYLOX LAZER ANTI-RUST BROWN PRIMER 12 (PYLZANTPR-12)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Primer', 'PYLZANTPR-12', 'CAN', 2.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 110: PYLOX HEAT RESISTANT BLACK (PLYZHI-TBLCK)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX HEAT RESISTANT BLACK', 'Paint', 'PLYZHI-TBLCK', 'BOT', 9.0, 150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 111: POLYGLOSS TOP COAT W/H (PGTOPC-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS TOP COAT W/H', 'Paint', 'PGTOPC-1L', 'LITER', 6.0, 470.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 112: POLYGLOSS PU YELLOW GOLD 4L (PGYG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYG-4L', 'GALON', 1.0, 2423.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 113: POLYGLOSS PU WHITE 4L (PGW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU WHITE 4L', 'Paint', 'PGW-4L', 'GALON', -1.0, 1730.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 114: POLYGLOSS PU VIOLET TUNNER 4L (PGVT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU VIOLET TUNNER 4L', 'Paint', 'PGVT-4L', 'GALON', 0.0, 2431.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 115: POLYGLOSS PU RED GOLD 4L (PGRG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRG-4L', 'GALON', 1.0, 1883.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 116: POLYGLOSS PU PHTHALO GREEN 4L (PGTG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PHTHALO GREEN 4L', 'Paint', 'PGTG-4L', 'GALON', 0.0, 1883.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 117: POLYGLOSS PU METALLIC FINE 4L (PGMF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC FINE 4L', 'Paint', 'PGMF-4L', 'GALON', 0.0, 1743.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 118: POLYGLOSS PU LIGHT YELLOW 4L (PGLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLY-4L', 'GALON', 0.0, 1883.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 119: POLYGLOSS PU GLEAMIST YELLOW 4L (PGGY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGY-4L', 'GALON', 0.0, 3188.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 120: POLYGLOSS PU GLEAMIST WHITE 4L (PGGW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGW-4L', 'GALON', 0.0, 3188.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 121: POLYGLOSS PU GLEAMIST ORANGE 4L (PGGO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGO-4L', 'GALON', 0.0, 3188.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 122: POLYGLOSS PU APPLE RED 4L (PGAR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU APPLE RED 4L', 'Paint', 'PGAR-4L', 'GALON', 0.0, 2431.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 123: POLYGLOSS PU 888 RED 4L (PG888-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU 888 RED 4L', 'Paint', 'PG888-4L', 'GALON', 0.0, 2450.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 124: PLATONE QDE YELLOW 4L (PLQDEY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE YELLOW 4L', 'Paint', 'PLQDEY-4L', 'GAL', 0.0, 836.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 125: PLATONE QDE WHITE 1L (PLQDW-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 1L', 'Paint', 'PLQDW-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 126: PLATONE QDE ROYAL BLUE 4L (PLQDRB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE ROYAL BLUE 4L', 'Paint', 'PLQDRB-4L', 'GAL', 0.0, 698.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 127: PLATONE QDE LEMON YELLOW 4L (PLQDLY-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 'GAL', 0.0, 836.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 128: PLATONE QDE JADE GREEN 4L (PLQDJG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE JADE GREEN 4L', 'Paint', 'PLQDJG-4L', 'GAL', 1.0, 732.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 129: PLATONE QDE INTERNATIONAL RED 4L (PLQDIR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 'GAL', 3.0, 773.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 130: PLATONE QDE GREEN 4L (PLQDG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE GREEN 4L', 'Paint', 'PLQDG-4L', 'GALON', 1.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 131: PLATONE QDE CHOCOLATE BROWN 4L (PLQDCB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 'GAL', 2.0, 668.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 132: PLATONE QDE BLACK 4L (PLQDB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 4L', 'Paint', 'PLQDB-4L', 'GAL', -1.0, 661.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 133: PLASTIC EMPTY BOTTLE (BOTTLE)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PLASTIC EMPTY BOTTLE', 'Paint', 'BOTTLE', 'PC/S', 0.0, 6.25, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 134: PISTACHIO ELASTOMERIC WATER FROOFING PAINT ROS-238 RAIN OR SHINE 4L (ROS-238)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PISTACHIO ELASTOMERIC WATER FROOFING PAINT ROS-238 RAIN OR SHINE 4L', 'Paint', 'ROS-238', '4L', 1.0, 681.4, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 135: PINACLE EPOXY ENAMEL THALO BLUE 4L (PINEPETHBLUE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PINACLE EPOXY ENAMEL THALO BLUE 4L', 'Paint', 'PINEPETHBLUE-4L', 'GALON', 0.0, 1160.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 136: PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT (PWTCO-9033)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-9033', '1/4L', 0.0, 80.59, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 137: PERMANENT VIOLET ACRY-COLOR PWTAC-8717 1L WELCOAT PREMIUM (PWTAC-8717-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PERMANENT VIOLET ACRY-COLOR PWTAC-8717 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-8717-1L', '1L', 0.0, 181.76, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 138: PERMANENT ORANGE ACRY-COLOR PWTAC-3117 1L WELCOAT PREMIUM (PWTAC-3117-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PERMANENT ORANGE ACRY-COLOR PWTAC-3117 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-3117-1L', '1L', 5.0, 143.18, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 139: PAINT ROLLER TRAY (TRAY)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 'PC/S', 3.0, 40.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 140: PAINT BRUSH 2B #1 (2B-PB#1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PAINT BRUSH 2B #1', 'Paint', '2B-PB#1', 'PC/S', 13.0, 18.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 141: ORANGE ELASTO FLOOR ROS-EF-3000 RAIN OR SHINE 4L (ROS-EF-3000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ORANGE ELASTO FLOOR ROS-EF-3000 RAIN OR SHINE 4L', 'Paint', 'ROS-EF-3000', '4L', 0.0, 1200.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 142: OLD NEWS (MSC)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('OLD NEWS', 'Paint', 'MSC', 'KG', 25.0, 45.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 143: NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L (NP8100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'Clearcoat', 'NP8100', 'LITER', 22.37, 1200.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 144: NIPPON SKIMCOAT PAIL (SKIMCOAT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON SKIMCOAT PAIL', 'Paint', 'SKIMCOAT', 'PAIL', 0.0, 1755.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 145: NIPPON PREMIUM HS CLEAR W/HARDENER 1L ()
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON PREMIUM HS CLEAR W/HARDENER 1L', 'Clearcoat', '', 'LITER', 22.0, 585.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 146: NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG (PUT3050-4KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'Miscellaneous', 'PUT3050-4KG', 'GAL', 0.0, 565.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 147: NIPPON MULTI-PURPOSE JOINT COMPOUND 5L (MPJOINTCMPND-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Miscellaneous', 'MPJOINTCMPND-5L', 'GAL/S', 4.0, 400.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 148: NIPPON METAL PRIMER RED OXIDE LITER (NMPREDOX-LTR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'Primer', 'NMPREDOX-LTR', 'LTR', 0.0, 147.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 149: NIPPON METAL PRIMER RED OXIDE GAL (NMPREDOX-GAL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'Primer', 'NMPREDOX-GAL', 'GAL', 9.0, 515.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 150: NIPPON LACQUER THINNER 4L (NLT-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON LACQUER THINNER 4L', 'Thinner', 'NLT-4L', 'GAL', 6.88, 435.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 151: NIPPON LACQUER SANDING SEALER 4L (NLSS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON LACQUER SANDING SEALER 4L', 'Paint', 'NLSS-4L', 'GALON', 0.0, 611.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 152: NIPPON HS FILLER 1L (HS-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON HS FILLER 1L', 'Miscellaneous', 'HS-1L', 'LITER', 10.0, 550.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 153: NIPPON FLEXI-SEAL 146 GRAY 5KG (NFI46G-5KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NFI46G-5KG', '5KG', 0.0, 1342.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 154: NIPPON FLATWALL ENAMEL WHITE 4L (NFWE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'Paint', 'NFWE-4L', 'GAL', 0.0, 615.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 155: NIPPON FLATTENING AGENT PASTE 1L (OTH10AD-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATTENING AGENT PASTE 1L', 'Paint', 'OTH10AD-1L', 'LITER', 8.0, 620.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 156: NIPPON FF151 FLOP CONTROL (FF151)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON FF151 FLOP CONTROL', 'Paint', 'FF151', 'LTR', 1.0, 1160.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 157: NIPPON EXTREME QDU YELLOW 4L (NXU1338-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 'GAL', 3.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 158: NIPPON EXTREME QDU WHITE 4L (NXU4075-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', 'GAL', 0.0, 1550.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 159: NIPPON EXTREME QDU WARM YELLOW 4L (XTRMEQDWARMYLW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 'GAL/S', 4.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 160: NIPPON EXTREME QDU SILVER 4L (NXU7391-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 'GAL', 0.0, 1485.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 161: NIPPON EXTREME QDU RED 4L (NXU4113-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 'GAL', -1.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 162: NIPPON EXTREME QDU ORANGE 4L (NXU1224-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'Paint', 'NXU1224-4L', 'GAL', 0.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 163: NIPPON EXTREME QDU GREEN 4L (NXU4406-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 'GAL', 0.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 164: NIPPON EXTREME QDU FINE SILVER 4L (EXTRMEFNESLVR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU FINE SILVER 4L', 'Paint', 'EXTRMEFNESLVR-4L', 'GAL/S', 0.0, 1485.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 165: NIPPON EXTREME QDU BLUE 4L (NXU1587-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 'GAL', 0.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 166: NIPPON EXTREME QDU BLACK 4L (NXU1965-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 'GAL', 3.0, 1485.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 167: NIPPON EXTREME MAROON 4L (NXUMAROON-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME MAROON 4L', 'Paint', 'NXUMAROON-4L', 'GAL', 0.0, 1771.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 168: NIPPON EXTREME MAGENTA 4L (NXUMAGENTA-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME MAGENTA 4L', 'Paint', 'NXUMAGENTA-4L', 'GAL', 5.0, 1870.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 169: NIPPON EXTREME CINQUASA VIOLET 4L (NXUCINQVIO-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME CINQUASA VIOLET 4L', 'Paint', 'NXUCINQVIO-4L', 'GAL', 5.0, 1630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 170: NIPPON EPOXY THINNER 4L (EPOXYTHNR-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON EPOXY THINNER 4L', 'Thinner', 'EPOXYTHNR-4L', 'GAL/S', 0.0, 550.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 171: NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L (DCTBSG-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L', 'Paint', 'DCTBSG-5L', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 172: NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L (DCTBSG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L', 'Paint', 'DCTBSG-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 173: NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L (DCTBSG-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L', 'Paint', 'DCTBSG-15L', 'PAIL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 174: NIPPON DOU CLASSIC SG WHITE 715 1L (DCSG715-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 1L', 'Paint', 'DCSG715-1L', 'LITER', 0.0, 186.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 175: NIPPON DOU CLASSIC SG WHITE 715 15L (DCSG715-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'Paint', 'DCSG715-15L', 'PAIL', 0.0, 2680.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 176: NIPPON DOU CLASSIC SG SMOKING GRAY 2045T 5L (2045T-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG SMOKING GRAY 2045T 5L', 'Paint', '2045T-5L', 'GAL/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 177: NIPPON DOU CLASSIC SG GRAY SUIT 2027P 5L (2027P-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG GRAY SUIT 2027P 5L', 'Paint', '2027P-5L', 'GAL/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 178: NIPPON DOU CLASSIC SG ABACADABRA 2034P 5L (2034P-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG ABACADABRA 2034P 5L', 'Paint', '2034P-5L', 'GAL/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 179: NIPPON DOU CLASSIC SG 715 WHITE 5L (DCSG715-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'Paint', 'DCSG715-5L', 'GAL', 0.0, 828.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 180: NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L (DCPBSG-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L', 'Paint', 'DCPBSG-5L', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 181: NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L (DCPBSG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 182: NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 15L (DCPBSG-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 15L', 'Paint', 'DCPBSG-15L', 'PAIL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 183: NIPPON DOU CLASSIC FLAT WHITE 701 5L (DCF701-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'Paint', 'DCF701-5L', 'GAL', 0.0, 630.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 184: NIPPON DOU CLASSIC FLAT WHITE 701 1L (DCF701-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'Paint', 'DCF701-1L', 'LITER', 2.0, 165.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 185: NIPPON DOU CLASSIC FLAT WHITE 701 15L (DCF701-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'Paint', 'DCF701-15L', 'PAIL', 4.0, 2130.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 186: NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L (DCDBSG-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L', 'Paint', 'DCDBSG-5L', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 187: NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 1L (DCDBSG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 1L', 'Paint', 'DCDBSG-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 188: NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L (DCDBSG-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L', 'Paint', 'DCDBSG-15L', 'PAIL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 189: NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L (DCABSG-5L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L', 'Paint', 'DCABSG-5L', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 190: NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 1L (DCABSG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 1L', 'Paint', 'DCABSG-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 191: NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L (DCABSG-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L', 'Paint', 'DCABSG-15L', 'PAIL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 192: NIPPON CLEAR GLOSS VARNISH LITER (NCGVARNISH-LTR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'Clearcoat', 'NCGVARNISH-LTR', 'LTR', 1.0, 449.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 193: NIPPON CLEAR GLOSS VARNISH GAL (NCGVARNISH-GAL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH GAL', 'Clearcoat', 'NCGVARNISH-GAL', 'GAL', 4.0, 1460.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 194: NIPPON CLEAR GLOSS LACQUER 4L (NCGL-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS LACQUER 4L', 'Clearcoat', 'NCGL-4L', 'GAL', 4.0, 660.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 195: NIPPON ACRYLIC SKIMCOAT 5KG (NAS-5G)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'Paint', 'NAS-5G', '5KG', 7.0, 402.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 196: NIPPON ACRYLIC GLOSS THINNER 4L (NAS535)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Thinner', 'NAS535', 'GAL/S', 13.0, 450.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 197: NIPPON 2K BINDER 1L (PNB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON 2K BINDER 1L', 'Paint', 'PNB-1L', 'LITER', 0.0, 900.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 198: NIPPELAC ACE THALO GREEN 4L (NPA1487)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 'GAL', 6.0, 1215.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 199: NIPPELAC ACE RED TRIPPLE 8 4L (NPA1131)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE RED TRIPPLE 8 4L', 'Paint', 'NPA1131', 'GAL', 8.0, 1850.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 200: NIPPELAC ACE PERMANENT MAROON 4L (NPA1177)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE PERMANENT MAROON 4L', 'Paint', 'NPA1177', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 201: NIPPELAC ACE LEMON YELLOW 4L (NPA1372)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 'GAL', 4.0, 1120.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 202: NIPPELAC ACE JET BLACK 4L (NPA1983)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 'GAL', 2.0, 1050.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 203: NIPPELAC ACE BRIGHT WHITE 4L (NPA4021)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 'GAL', 12.0, 1000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 204: NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L (SOD145)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 'GAL', 2.5075, 445.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 205: NAX SOB745 BLENDING THINNER 4L (SOB745)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Thinner', 'SOB745', 'GAL', 5.15, 786.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 206: NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L (NP9700)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NP9700', 'LITER', 8.0, 1030.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 207: NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L (NP9200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NP9200', 'LITER', 10.0, 871.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 208: NAX PREMILA NB200 BINDER (NB200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB200 BINDER', 'Paint', 'NB200', 'GAL', 1.0, 2100.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 209: NAX PREMILA NB100 B/C BINDER 4L (PNB100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 'GAL', 2.0, 2100.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 210: NAX PREMILA MT904 SHADOWN GREEN 1L (MT904)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 'LTR/S', 2.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 211: NAX PREMILA MT903 SUN GREEN 1L (MT903)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 'LTR/S', 2.0, 1561.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 212: NAX PREMILA MT902 GRASS GREEN 1L (MT902)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT902 GRASS GREEN 1L', 'Paint', 'MT902', 'LTR/S', 3.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 213: NAX PREMILA MT901 CYANINE GREEN 1L (MT901)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT901 CYANINE GREEN 1L', 'Paint', 'MT901', 'LTR/S', 0.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 214: NAX PREMILA MT807 VACANCE BLUE 1L (MT807)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 'LTR/S', 3.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 215: NAX PREMILA MT806 HERMES BLUE 1L (MT806)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 'LTR/S', 2.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 216: NAX PREMILA MT805 CUSTOM BLUE 1L (MT805)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 'LTR/S', 1.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 217: NAX PREMILA MT804 ORIENT BLUE 1L (MT804)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 'LTR/S', 1.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 218: NAX PREMILA MT803 FRESH BLUE 1L (MT803)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 'LTR/S', 1.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 219: NAX PREMILA MT801 CYANINE BLUE 1L (MT801)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 'LTR/S', 3.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 220: NAX PREMILA MT705 FLORA VIOLET 1L (MT705)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 'LTR/S', 4.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 221: NAX PREMILA MT704 FINE VIOLET 1L (MT704)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 'LTR/S', 4.0, 1593.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 222: NAX PREMILA MT702 CINQUASIA VIOLET 1L (MT702)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT702 CINQUASIA VIOLET 1L', 'Paint', 'MT702', 'LTR/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 223: NAX PREMILA MT701 FAST VIOLET 1L (MT701)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 'LTR/S', 0.0, 1744.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 224: NAX PREMILA MT607 AUTUMN RED 1L (MT607)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 'LTR/S', 1.0, 2048.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 225: NAX PREMILA MT606 GIRAFFE YELLOW 1L (MT606)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 'LTR/S', 2.0, 1608.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 226: NAX PREMILA MT604 EXTRA MAROON 1L (MT604)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 'LTR/S', 1.0, 2048.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 227: NAX PREMILA MT603 CINQUASIA BROWN 1L (MT603)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 'LTR/S', 3.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 228: NAX PREMILA MT602 PEGASUS MAROON 1L (MT602)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 'LTR/S', 2.0, 2302.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 229: NAX PREMILA MT601 IRON RED 1L (MT601)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 'LTR/S', 3.0, 1849.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 230: NAX PREMILA MT508 INDIAN RED 1L (MT508)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 'LTR/S', 2.0, 2349.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 231: NAX PREMILA MT507 RUBY RED 1L (MT507)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 'LTR/S', 2.0, 2867.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 232: NAX PREMILA MT506 CINQUASIA RED 1L (MT506)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 'LTR/S', 2.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 233: NAX PREMILA MT505 SPARK RED 1L (MT505)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 'LTR/S', 3.0, 2900.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 234: NAX PREMILA MT503 THRENE RED G 1L (MT503)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 'LTR/S', 0.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 235: NAX PREMILA MT501 STRONG RED 1L (MT501)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 'LTR/S', 4.0, 2048.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 236: NAX PREMILA MT405 SUN ORANGE 1L (MT405)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 'LTR/S', 1.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 237: NAX PREMILA MT401 MAXIM ORANGE 1L (MT401)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 'LTR/S', 2.0, 2426.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 238: NAX PREMILA MT307 EXTRA YELLOW 1L (MT307)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 'LTR/S', 2.0, 2958.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 239: NAX PREMILA MT305 NATURAL YELLOW 1L (MT305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 'LTR/S', 2.0, 1744.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 240: NAX PREMILA MT304 GAILY YELLOW 1L (MT304)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 'LTR/S', 2.0, 3600.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 241: NAX PREMILA MT303 FINE YELLOW 1L (MT303)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 'LTR/S', 1.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 242: NAX PREMILA MT302 JEWEL YELLOW 1L (MT302)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 'LTR/S', 2.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 243: NAX PREMILA MT301 MAPICO YELLOW 1L (MT301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 'LTR/S', 3.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 244: NAX PREMILA MT203 DEEP BLACK 1L (MT203)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', 'LTR/S', 0.0, 1668.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 245: NAX PREMILA MT202 TINTING BLACK NP 1L (MT202-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 'LTR/S', 2.0, 1090.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 246: NAX PREMILA MT201 BLUE BLACK 1L (MT201)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 'LTR/S', 4.0, 1090.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 247: NAX PREMILA MT175 GRAPHITE 1L (MT175)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 'LTR/S', 2.0, 1896.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 248: NAX PREMILA MT172 OPAL COLOR 1L (MT172)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 'LTR/S', 3.0, 2996.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 249: NAX PREMILA MT170 OPAL COLOR LS 1L (MT170)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 'LTR/S', 2.0, 1376.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 250: NAX PREMILA MT136 METALLIC ORANGE 1L (MT136)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 'LTR/S', 0.0, 5050.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 251: NAX PREMILA MT134 METALLIC GOLD 1L (MT134)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 'LTR/S', 3.0, 3600.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 252: NAX PREMILA MT103 WHITE LS 1L (MT103)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 'LTR/S', 2.0, 1090.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 253: NAX PREMILA MT100 WHITE HS 4L (MT100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 'GAL/S', 1.0, 4160.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 254: NAX PREMILA MT100 WHITE HS 1L (MT100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'Paint', 'MT100-1L', 'LTR/S', 2.0, 1090.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 255: NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L (MT096)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', 'LTR/S', 0.0, 6000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 256: NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L (MT093)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 257: NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L (MT086)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 258: NAX PREMILA MT085 MICA BASE 4G GREEN 1L (MT085)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 259: NAX PREMILA MT083 MICA BASE 4R RED 1L (MT083)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 260: NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L (MT081)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 261: NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L (MT080)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 'LTR/S', 4.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 262: NAX PREMILA MT079 MICA BASE 2V VIOLET 1L (MT079)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 263: NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L (MT078)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 'LTR/S', 1.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 264: NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L (MT076)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 265: NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L (MT075)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 266: NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L (MT072)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 267: NAX PREMILA MT071 MICA BASE 5B BLUE 1L (MT071)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 'LTR/S', 1.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 268: NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L (MT06H)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 'LTR/S', 0.0, 3650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 269: NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L (MT06A)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 'LTR/S', 1.0, 3650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 270: NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L (MT068)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'Paint', 'MT068', 'LTR/S', 2.0, 6000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 271: NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L (MT067)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 272: NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L (MT066)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 'LTR/S', 4.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 273: NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L (MT065)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 'LTR/S', 3.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 274: NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L (MT061)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 'LTR/S', 2.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 275: NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L (MT051)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 'LTR/S', 1.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 276: NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L (MT050)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 'LTR/S', 1.0, 3000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 277: NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L (MT033-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L', 'Paint', 'MT033-4L', 'GAL/S', 0.0, 6430.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 278: NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L (MT033)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 'LTR/S', 2.0, 1995.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 279: NAX PREMILA MT030 WHITE MET. SNOW FINE 1L (MT030)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 'LTR/S', 1.0, 1745.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 280: NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L (MT028)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 'LTR/S', 4.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 281: NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L (MT025)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 'LTR/S', 0.0, 1745.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 282: NAX PREMILA MT023 HIGH SPARKLE FINE 4L (MT023-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 4L', 'Paint', 'MT023-4L', 'GAL/S', 0.0, 6430.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 283: NAX PREMILA MT023 HIGH SPARKLE FINE 1L (MT023)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 'LTR/S', 1.0, 1994.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 284: NAX PREMILA MT012 MET. BASE FINE 1L (MT012)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 'LTR/S', 1.0, 1745.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 285: NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L (MT008)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 'LTR/S', 3.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 286: NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L (MT006)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 'LTR/S', 1.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 287: NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L (MT004)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 'LTR/S', 1.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 288: NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L (MT003)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 'LTR/S', 0.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 289: NAX PREMILA MT002 CRYSTAL SILVER FINE 4L (MT002-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 4L', 'Paint', 'MT002-4L', 'GAL/S', 0.0, 6563.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 290: NAX PREMILA MT002 CRYSTAL SILVER FINE 1L (MT002-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 'LTR/S', 3.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 291: NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L (MT001)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 'LTR/S', 3.0, 2150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 292: NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L (MT06M)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 'LTR/S', 3.0, 3650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 293: NAX PREMILA 2K NB200 HARDENER (NB200-HAR)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA 2K NB200 HARDENER', 'Miscellaneous', 'NB200-HAR', 'LTR', 0.0, 1030.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 294: NAX NAX21 URETHANE HAEDENER (NAX21)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAX21 URETHANE HAEDENER', 'Paint', 'NAX21', 'CANS', 34.0, 190.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 295: NAX NAT-992 TTC BLACK NO.8 1L (NAT992)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'Paint', 'NAT992', 'LITER', 6.0, 410.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 296: NAX NAT-990 TTC BLACK 4L (NAT990-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 4L', 'Paint', 'NAT990-4L', 'GAL', 3.0, 1518.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 297: NAX NAT-990 TTC BLACK 1L (NAT990-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 1L', 'Paint', 'NAT990-1L', 'LITER', 4.0, 409.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 298: NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L (NAT745)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 'LITER', 7.0, 830.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 299: NAX NAT-740 TTC ULTRA FINE SILVER 1L (NAT740)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 'LITER', 2.0, 470.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 300: NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L (NAT736)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 'LITER', 0.0, 685.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 301: NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L (NAT733)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 'LITER', 9.0, 436.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 302: NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L (NAT729)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 'LITER', 6.0, 760.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 303: NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L (NAT728)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'Paint', 'NAT728', 'LITER', 1.0, 995.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 304: NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L (NAT727)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 'LITER', 6.0, 1085.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 305: NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L (NAT725)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 'LITER', 6.0, 652.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 306: NAX NAT-720 TTC SPARKLE WHITE SILVER 1L (NAT720)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 'LITER', 6.0, 621.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 307: NAX NAT-719 TTC COARSE SILVER 4L (NAT719-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 'GAL', 1.0, 2325.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 308: NAX NAT-719 TTC COARSE SILVER 1L (NAT719-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'Paint', 'NAT719-1L', 'LITER', 8.0, 595.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 309: NAX NAT-716 TTC SPARKLE SILVER 1L (NAT716)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 'LITER', 6.0, 422.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 310: NAX NAT-715 TTC FINE SILVER 1L (NAT715-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 'LITER', -1.0, 422.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 311: NAX NAT-712 TTC MEDIUM FINE SILVER 4L (NAT712-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 4L', 'Paint', 'NAT712-4L', 'GAL', 0.0, 2180.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 312: NAX NAT-712 TTC MEDIUM FINE SILVER 1L (NAT712-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 'LITER', 0.0, 581.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 313: NAX NAT707 HI-SPARKLE SILVER 1L (NAT707-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 'LITER', 5.0, 581.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 314: NAX NAT706 MEDIUM COARSE SILVER 1L (NAT706-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 'LITER', 6.0, 422.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 315: NAX NAT705 SUPER FINE SILVER 1L (NAT705-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 'LITER', 3.0, 422.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 316: NAX NAT-595 TTC CYANINE BLUE 1L (NAT595)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 'LITER', 5.0, 498.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 317: NAX NAT-557 TTC BLUE NO.9 1L (NAT557)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 'LITER', 6.0, 450.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 318: NAX NAT-556 TTC BLUE NO.8 1L (NAT556)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 'LITER', 1.0, 620.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 319: NAX NAT-555 TTC BLUE NO.7 1L (NAT555)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 'LITER', 6.0, 517.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 320: NAX NAT-550 TTC SUPER BLUE 1L (NAT550)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 'LITER', 2.0, 435.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 321: NAX NAT-530 TTC FINE BLUE 1L (NAT530)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 'LITER', 2.0, 1090.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 322: NAX NAT-490 TTC EVERGREEN 1L (NAT490)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 'LITER', 5.0, 500.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 323: NAX NAT-410 TTC CYANINE GREEN 1L (NAT410)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 'LITER', 6.0, 683.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 324: NAX NAT-3974 QDU FLAT BLACK 1L (NAT3974)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', 'LITER', 0.0, 451.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 325: NAX NAT-390 TTC IRON YELLOW 1L (NAT390)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 'LITER', 9.0, 367.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 326: NAX NAT-380 TTC SUPER YELLOW 1L (NAT380)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 'LITER', 4.0, 1035.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 327: NAX NAT-321 TTC HOSTAPERM YELLOW 1L (NAT321)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Paint', 'NAT321', 'LITER', 10.0, 897.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 328: NAX NAT-320 TTC GOLD YELLOW 1L (NAT320)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 'LITER', 5.0, 425.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 329: NAX NAT-305 TTC GREEN YELLOW 1L (NAT305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 'LITER', 4.0, 1380.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 330: NAX NAT-2930 TTC QDU SASH BLACK 1L (NAX2930)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-2930 TTC QDU SASH BLACK 1L', 'Paint', 'NAX2930', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 331: NAX NAT-210 TTC SUPER ORANGE 1L (NAT210)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 'LITER', 6.0, 1511.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 332: NAX NAT-1OO TTC WHITE 1L (NAT100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1OO TTC WHITE 1L', 'Paint', 'NAT100-1L', 'LITER', 1.0, 425.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 333: NAX NAT-196 TTC PURPLISH RED 1L (NAT196)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 'LITER', 14.0, 1125.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 334: NAX NAT-192 TTC BRIGHT RED 1L (NAT192)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 'LITER', 3.0, 540.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 335: NAX NAT-190 TTC IRON RED 1L (NAT190)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 'LITER', 5.0, 395.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 336: NAX NAT-180 TTC STRAWBERRY RED 1L (NAT180)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 'LITER', 6.0, 895.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 337: NAX NAT158 CINQUASIA VIOLET 1L (NAT158)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158', 'LITER', 2.0, 1310.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 338: NAX NAT-149 TTC DARK MAROON 1L (NAT149)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 'LITER', 10.0, 1110.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 339: NAX NAT-147 TTC THRENE RED 1L (NAT147)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'Paint', 'NAT147', 'LITER', 7.0, 1120.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 340: NAX NAT-143 TTC FLAME RED 1L (NAT143)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 'LITER', 12.0, 1315.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 341: NAX NAT-1305 TTC 211 MICA BASE 1L (NAT1305)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 'LITER', 6.0, 1542.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 342: NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L (NAT1304)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 'LITER', 2.0, 1956.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 343: NAX NAT-1303 TTC OMEGA PEARL 1L (NAT1303)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 'LITER', 6.0, 1956.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 344: NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L (NAT1301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 'LITER', 5.0, 1956.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 345: NAX NAT-1300 TTC CRYSTALLINE SILVER 1L (NAT1300)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 'LITER', 5.0, 1956.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 346: NAX NAT-1180 TTC OYSTER WHITE MICA 1L (NAT1180)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 'LITER', 6.0, 1543.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 347: NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L (NAT1175)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 'LITER', 5.0, 798.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 348: NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L (NAT1173)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 'LITER', 6.0, 1599.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 349: NAX NAT-1172 TTC BRIGHT GREEN MICA 1L (NAT1172)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 'LITER', 6.0, 910.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 350: NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L (NAT1171)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 'LITER', 6.0, 840.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 351: NAX NAT-1167 TTC PALE GREEN MICA 1L (NAT1167)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 'LITER', 6.0, 840.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 352: NAX NAT-1166 TTC EARTH BROWN MICA 1L (NAT1166)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 'LITER', 6.0, 886.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 353: NAX NAT-1165 TTC HI-LITE RED 1L (NAT1165)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 'LITER', 0.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 354: NAX NAT-1164 TTC BRIGHT GOLD MICA 1L (NAT1164)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 'LITER', 0.0, 640.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 355: NAX NAT-1163 TTC FINE GREEN MICA 1L (NAT1163)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 'LITER', 5.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 356: NAX NAT-1161 TTC LAVENDER MICA 1L (NAT1161)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 'LITER', 0.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 357: NAX NAT-1160 TTC RED COPPER MICA 1L (NAT1160)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 'LITER', 6.0, 694.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 358: NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L (NAT1159)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'Paint', 'NAT1159', 'LITER', 0.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 359: NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L (NAT1158)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 'LITER', 3.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 360: NAX NAT-1157 TTC BRIGHT COPPER MICA 1L (NAT1157)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 'LITER', 0.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 361: NAX NAT-1153 TTC SUPER RED MICA 1L (NAT1153)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 'LITER', 2.0, 780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 362: NAX NAT-1114 TTC GREEN MICA 1L (NAT1114)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 'LITER', 4.0, 661.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 363: NAX NAT-1113 TTC FINE BLUE MICA 1L (NAT1113)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 'LITER', 2.0, 661.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 364: NAX NAT-1110 TTC BRIGHT WHITE 4L (NAT1110-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 'GAL', 2.0, 2400.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 365: NAX NAT-1110 TTC BRIGHT WHITE 1L (NAT1110-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 'LITER', 6.0, 635.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 366: NAX NAT-1107 TTC FINE RED MICA 1L (NAT1107)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 'LITER', 6.0, 779.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 367: NAX NAT-1106 TTC PEARL BLUE MICA 1L (NAT1106)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 'LITER', 1.0, 863.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 368: NAX NAT-1062 QDU 040 SUPER WHITE 1L (NAX1062)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 'LITER', 2.0, 442.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 369: NAX NAT-103 TTC OPAL 1L (NAT103)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 'LITER', 6.0, 1215.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 370: NAX NAT-10100 NH-585 PEARL WHITE MICA 1L (NAX10100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', 'LITER', 2.0, 675.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 371: NAX NAT-100 TTC WHITE 4L (NAT100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-100 TTC WHITE 4L', 'Paint', 'NAT100-4L', 'GAL', 0.0, 1905.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 372: NAX MULTIPURPOSE URETHANE THINNER 4L (SOB642)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Thinner', 'SOB642', 'GAL', 0.0, 591.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 373: NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L (NXE4090)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Miscellaneous', 'NXE4090', 'GAL', 7.0, 1320.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 374: NAX EXTREME EPOXY ENAMEL BLUE W/HARDENER 4L (NXE1513)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLUE W/HARDENER 4L', 'Miscellaneous', 'NXE1513', 'GALON', 0.0, 1320.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 375: NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L (NXE1988)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'Miscellaneous', 'NXE1988', 'GAL', 3.75, 1050.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 376: NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L (PRI3634)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Miscellaneous', 'PRI3634', 'LITER', 14.13, 363.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 377: NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L (NAX301)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX301', 'LITER', 0.25, 784.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 378: NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L (NAX141)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX141', 'LITER', 25.5, 344.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 379: NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L (NAX108)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Clearcoat', 'NAX108', 'LITER', 17.05, 460.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 380: METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L (MEG3001-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'Primer', 'MEG3001-4L', 'GAL', 0.0, 710.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 381: METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L (MEG3001-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L', 'Primer', 'MEG3001-1L', 'LITER', 0.0, 193.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 382: METALGUARD EPOXY PRIMER WHITE W/H REPACK (MEG3001R-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE W/H REPACK', 'Primer', 'MEG3001R-1L', 'LITER', 0.0, 260.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 383: METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L (MEG3100-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L', 'Primer', 'MEG3100-4L', 'GAL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 384: METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L (MEG3100-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'Primer', 'MEG3100-1L', 'LITER', 23.0, 193.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 385: METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L (MEG3602-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'Primer', 'MEG3602-4L', 'GAL', 0.0, 685.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 386: METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L (MEG3602-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L', 'Primer', 'MEG3602-1L', 'LITER', 0.0, 193.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 387: METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L (MEG3901-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Primer', 'MEG3901-4L', 'GAL', 2.0, 710.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 388: METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L (MEG3901-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L', 'Primer', 'MEG3901-1L', 'LITER', 0.0, 193.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 389: METALGUARD EPOXY PRIMER BLACK W/H REPACK (MEG3901R-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'Primer', 'MEG3901R-1L', 'LITER', 0.0, 250.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 390: MAYON LACQUER THINNER 3.75L (MYNALTHNR-3.75L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('MAYON LACQUER THINNER 3.75L', 'Thinner', 'MYNALTHNR-3.75L', 'GAL/S', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 391: MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK (MEEKBOS-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'Paint', 'MEEKBOS-1L', '1L SET', 8.0, 538.2, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 392: LIME ROS-138 RAIN OR SHINE 4L (ROS-138)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LIME ROS-138 RAIN OR SHINE 4L', 'Paint', 'ROS-138', '4L', 0.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 393: LIGHT BEIGE ROS-353 RAIN OR SHINE 4L (ROS-353)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LIGHT BEIGE ROS-353 RAIN OR SHINE 4L', 'Paint', 'ROS-353', '4L', 4.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 394: LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM (PWTCO-1133)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM', 'Paint', 'PWTCO-1133', '1/4L', 0.0, 60.87, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 395: JAPAN PUTTY KNIFE #6 (PUTTYKNI #6)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #6', 'Miscellaneous', 'PUTTYKNI #6', 'PC/S', 14.0, 15.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 396: JAPAN PUTTY KNIFE #4 (PUTTYKNI #4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #4', 'Miscellaneous', 'PUTTYKNI #4', 'PC/S', 0.0, 12.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 397: HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM (PWTCO-5033)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM', 'Paint', 'PWTCO-5033', '1/4L', -5.0, 90.88, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 398: HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES (AC-40-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'Paint', 'AC-40-1L', '1L', 3.0, 141.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 399: GREEN ELASTOMERIC WATER FROOFING PAINT ROS-SR-911 SUN ROOF RAIN 4L (ROS-SR-911)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GREEN ELASTOMERIC WATER FROOFING PAINT ROS-SR-911 SUN ROOF RAIN 4L', 'Paint', 'ROS-SR-911', '4L', 0.0, 577.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 400: GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L (ROS-678)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L', 'Paint', 'ROS-678', '4L', 5.0, 645.3, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 401: GOLD RUSH ROS-529 RAIN OR SHINE 4L (ROS-529)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GOLD RUSH ROS-529 RAIN OR SHINE 4L', 'Paint', 'ROS-529', '4L', 2.0, 767.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 402: GLAZER AUTOMOTIVE ENAMEL YELLOW GREEN 1L (GLAZERYG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL YELLOW GREEN 1L', 'Paint', 'GLAZERYG-1L', 'LITER', 0.0, 350.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 403: GLAZER AUTOMOTIVE ENAMEL WHITE 4L (GLAUEWHITE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE 4L', 'Paint', 'GLAUEWHITE-4L', 'GALON', 0.0, 855.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 404: GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L (GLAZERW-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L', 'Paint', 'GLAZERW-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 405: GLAZER AUTOMOTIVE ENAMEL LEMON YELLOW 4L (GLAZERYG-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL LEMON YELLOW 4L', 'Paint', 'GLAZERYG-4L', 'GALON', 0.0, 855.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 406: GLAZER AUTOMOTIVE ENAMEL BLACK 4L (GLAZERB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'Paint', 'GLAZERB-4L', 'GALON', 0.0, 761.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 407: GI PAINT REMOVER BOTTLE (GIPREMOVER-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GI PAINT REMOVER BOTTLE', 'Paint', 'GIPREMOVER-BOT', 'BOT', 16.0, 68.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 408: FRANELLA CLOTH 1YARD (FRANELLA)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('FRANELLA CLOTH 1YARD', 'Paint', 'FRANELLA', '1YRD', 67.0, 68.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 409: FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L (B-701-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L', 'Paint', 'B-701-4L', '4L', 3.0, 640.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 410: EUROMAX SPRAY GUN F75 (SPRYGUN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EUROMAX SPRAY GUN F75', 'Paint', 'SPRYGUN', 'PC/S', 0.0, 880.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 411: EPOXY ENAMEL MIX BLUE 1L (EPOXYELB-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EPOXY ENAMEL MIX BLUE 1L', 'Paint', 'EPOXYELB-1L', 'LITER', 0.0, 400.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 412: EMPTY GLASS FOR MIXING PAINT 1/4L (EMPTYGLASS)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EMPTY GLASS FOR MIXING PAINT 1/4L', 'Paint', 'EMPTYGLASS', '1/4L', 0.0, 3.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 413: EMPTY CAN LITER SIZE (CAN-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EMPTY CAN LITER SIZE', 'Paint', 'CAN-1L', 'CAN', 0.0, 3.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 414: EL KAPITAN A & B 4L (MEEKBOS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EL KAPITAN A & B 4L', 'Paint', 'MEEKBOS-4L', 'SET', 3.0, 2098.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 415: ECO BAG MEDIUM (ECOBAG-M)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ECO BAG MEDIUM', 'Paint', 'ECOBAG-M', 'PCS', 0.0, 5.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 416: EAGLE SANDPAPER #1500 (EA1500)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1500', 'Miscellaneous', 'EA1500', 'PC/S', 200.0, 28.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 417: EAGLE SANDPAPER #800 (EA800)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #800', 'Miscellaneous', 'EA800', 'PC/S', 65.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 418: EAGLE SANDPAPER #600 (EA600)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #600', 'Miscellaneous', 'EA600', 'PCS', 80.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 419: EAGLE SANDPAPER #60 (EA60)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #60', 'Miscellaneous', 'EA60', 'PC/S', 196.0, 28.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 420: EAGLE SANDPAPER #400 (EA400)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #400', 'Miscellaneous', 'EA400', 'PC/S', 54.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 421: EAGLE SANDPAPER #240 (EA240)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #240', 'Miscellaneous', 'EA240', 'PC/S', 175.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 422: EAGLE SANDPAPER #2000 (EA2000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #2000', 'Miscellaneous', 'EA2000', 'PC/S', 151.0, 28.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 423: EAGLE SANDPAPER #1200 (EA1200)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1200', 'Miscellaneous', 'EA1200', 'PC/S', 4.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 424: EAGLE SANDPAPER #120 (EA120)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #120', 'Miscellaneous', 'EA120', 'PC/S', 158.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 425: EAGLE SANDPAPER #1000 (EA1000)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1000', 'Miscellaneous', 'EA1000', 'PC/S', 388.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 426: EAGLE SAND PAPER #320 (EA320)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EAGLE SAND PAPER #320', 'Miscellaneous', 'EA320', 'PCS', 346.0, 18.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 427: DRAGONFLY PAINT ROLLER #7 W/H (PTRL-7)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'Paint', 'PTRL-7', 'PC/S', 0.0, 65.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 428: DRAGONFLY PAINT BRUSH #4 (DPB-4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #4', 'Paint', 'DPB-4', 'PC/S', 2.0, 99.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 429: DRAGONFLY PAINT BRUSH #3 (DPB-3)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #3', 'Paint', 'DPB-3', 'PC/S', 0.0, 65.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 430: DRAGONFLY PAINT BRUSH #2 (DPB-2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #2', 'Paint', 'DPB-2', 'PC/S', 0.0, 35.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 431: DRAGONFLY PAINT BRUSH #1 1/2 (DPB-1 1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'Paint', 'DPB-1 1/2', 'PC/S', -1.0, 25.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 432: DRAGONFLY PAINT BRUSH #1 (DPB-1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1', 'Paint', 'DPB-1', 'PC/S', 0.0, 18.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 433: DRAGONFLY MINI BABY ROLLER #4 W/H (BBR-MINI)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'Paint', 'BBR-MINI', 'PC/S', 0.0, 35.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 434: DOMINO BODY FILTER WITH HARDENER 4L (DOMBF-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'Miscellaneous', 'DOMBF-4L', 'GAL', 3.0, 495.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 435: DOMINO BODY FILTER WITH HARDENER 1L (DOMBF-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'Miscellaneous', 'DOMBF-1L', 'LITER', -1.0, 150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 436: DO IT URETHANE WHITE 4L (DOITWHITE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 'GAL/S', 3.0, 1780.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 437: GLAZER AUTO ENAMEL MIX 4L (AEMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'Paint', 'AEMIX-4L', 'GAL', 0.0, 1400.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 438: DO IT URETHANE THINNER 4L (DOITH-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE THINNER 4L', 'Thinner', 'DOITH-4L', 'GAL/S', 0.0, 590.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 439: DO IT URETHANE BLACK 4L (DOITBLACK-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 'GAL/S', 0.0, 2205.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 440: DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML (DOITSHLDALL-BOT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Miscellaneous', 'DOITSHLDALL-BOT', 'BOT', 9.0, 160.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 441: DO IT HARDENER 2K TOP COAT (HDOIT)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT HARDENER 2K TOP COAT', 'Miscellaneous', 'HDOIT', 'CAN', 0.0, 240.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 442: DO IT BLACK MIX MICA 1L (QDUDTBLACKM-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT BLACK MIX MICA 1L', 'Paint', 'QDUDTBLACKM-1L', 'LITER', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 443: DEEP BASED MUTI PURPOSE COATING NIPPON PAINT (NP PB 1534D)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DEEP BASED MUTI PURPOSE COATING NIPPON PAINT', 'Paint', 'NP PB 1534D', 'PAIL', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 444: DAVIES QDE WHITE 4L (DV400-WHITE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE WHITE 4L', 'Paint', 'DV400-WHITE-4L', 'GALON', 0.0, 820.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 445: DAVIES OTC THALO GREEN 1/4L (TC-33-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES OTC THALO GREEN 1/4L', 'Paint', 'TC-33-1/4L', '1/4L', 1.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 446: DAVIES OTC THALO BLUE 1/4L (TC-21-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES OTC THALO BLUE 1/4L', 'Paint', 'TC-21-1/4L', '1/4L', 0.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 447: DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L (TC-60-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L', 'Paint', 'TC-60-1/4L', '1/4L', 4.0, 95.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 448: DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L (TCLT-11-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L', 'Paint', 'TCLT-11-1L', 'LITER', 3.0, 399.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 449: DAVIES LIQUID-TILE TINTING COLOR BLACK 1L (TCLT-60-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID-TILE TINTING COLOR BLACK 1L', 'Paint', 'TCLT-60-1L', 'LITER', 2.0, 399.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 450: DAVIES LIQUID TILE GLOSS WHITE 4L (DV-5-525-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'Paint', 'DV-5-525-4L', 'GALON', 12.0, 1095.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 451: CUMI SUPREME FLOOR SANDING 80 (CUMIFS-80)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 80', 'Paint', 'CUMIFS-80', 'FT', 56.0, 42.4, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 452: CUMI SUPREME FLOOR SANDING 60 (CUMIFS-60)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 60', 'Paint', 'CUMIFS-60', 'FT', 18.0, 44.73, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 453: CUMI SUPREME FLOOR SANDING 36 (CUMIFS-36)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 36', 'Paint', 'CUMIFS-36', 'FT', 129.0, 55.36, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 454: CUMI SUPREME FLOOR SANDING 100 (CUMIFS-100)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 100', 'Paint', 'CUMIFS-100', 'FT', 94.0, 39.03, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 455: CROCO MASKING TAPE 3/4 18MM (1X64) (CRO-MT3/4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 'PC/S', 54.0, 23.59, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 456: CROCO MASKING TAPE 1/2 12MM (1X96) (CRO-MT1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Paint', 'CRO-MT1/2', 'PC/S', 37.0, 15.73, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 457: CROCO MASKING TAPE #2 (CRO-MT2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE #2', 'Paint', 'CRO-MT2', 'PCS', 13.0, 63.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 458: CROCO MASKING TAPE #1 (CRO-MT1)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE #1', 'Paint', 'CRO-MT1', 'PCS', 5.0, 32.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 459: COTTA ELASTOMERIC WATER FROOFING PAINT R0S-SR-337 SUN ROOF RAIN 4L (ROS-SR-337)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('COTTA ELASTOMERIC WATER FROOFING PAINT R0S-SR-337 SUN ROOF RAIN 4L', 'Paint', 'ROS-SR-337', '4L', 2.0, 523.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 460: COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L (ROS-739)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L', 'Paint', 'ROS-739', '4L', 0.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 461: CANDY TUFF ROS-367 RAIN OR SHINE 4L (ROS-367)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'Paint', 'ROS-367', '4L', 0.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 462: BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT (PWTAC-4617-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT', 'Paint', 'PWTAC-4617-1L', '1L', 6.0, 104.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 463: BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES (TC-93-1/4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES', 'Paint', 'TC-93-1/4L', '1/4L', 0.0, 53.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 464: BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT (PWTCO-6133)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-6133', '1/4L', 1.0, 80.59, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 465: BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT (PWTAC-6517-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT', 'Paint', 'PWTAC-6517-1L', '1L', 6.0, 104.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 466: BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT (PWTCO-2133)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-2133', '1/4L', 0.0, 87.45, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 467: BUFFING PAD (BPAD)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BUFFING PAD', 'Paint', 'BPAD', 'PC/S', 2.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 468: BOYSEN QDE WHITE GAL (BSQDEW-GAL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN QDE WHITE GAL', 'Paint', 'BSQDEW-GAL', 'GAL', 0.0, 834.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 469: BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L (B-710)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'Paint', 'B-710', 'GALON', 2.0, 765.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 470: BOYSEN PERMACOAT FLAT LATEX BLACK 4L (B-791)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN PERMACOAT FLAT LATEX BLACK 4L', 'Paint', 'B-791', 'GALON', 1.0, 615.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 471: BOYSEN LTC LAMP BLACK 1L (B1490-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN LTC LAMP BLACK 1L', 'Paint', 'B1490-1L', 'LITER', 6.0, 92.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 472: BOYSEN FWE WHITE GAL (BSFWEW-GAL)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN FWE WHITE GAL', 'Paint', 'BSFWEW-GAL', 'GAL', 7.0, 777.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 473: BOYSEN ACRYTEX CAST 4L (B-1711)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX CAST 4L', 'Paint', 'B-1711', 'GALON', 2.0, 545.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 474: BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG (BSKSMCOAT-BAG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'Paint', 'BSKSMCOAT-BAG', 'BAG', 16.0, 495.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 475: BLACK ELASTO FLOOR ROS-EF-1130 RAIN OR SHINE 4L (ROS-EF-1130)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BLACK ELASTO FLOOR ROS-EF-1130 RAIN OR SHINE 4L', 'Paint', 'ROS-EF-1130', '4L', 3.0, 925.5, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 476: BLACK ACRY-COLOR AC-60 1L DAVIES (AC-60-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BLACK ACRY-COLOR AC-60 1L DAVIES', 'Paint', 'AC-60-1L', '1L', 0.0, 85.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 477: BITTER SWEET SUN ROOF ROS-SR-777 RAIN OR SHINE 4L (ROS-SR-777)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BITTER SWEET SUN ROOF ROS-SR-777 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-777', '4L', 1.0, 595.7, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 478: BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L (ROS-SR-182)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-182', '4L', 2.0, 577.6, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 479: ANTIQUE WHITE ROS-270 RAIN OR SHINE 4L (ROS-270)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ANTIQUE WHITE ROS-270 RAIN OR SHINE 4L', 'Paint', 'ROS-270', '4L', 0.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 480: AMBER ROSE ROS-350 RAIN OR SHINE 4L (ROS-350)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('AMBER ROSE ROS-350 RAIN OR SHINE 4L', 'Paint', 'ROS-350', '4L', 3.0, 661.1, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 481: ALPHA CHROMA ACRYTILE GLOSS WHITE 4L (ALPHAGLOSS-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'Paint', 'ALPHAGLOSS-4L', 'GALON', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 482: ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L (B-1705)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'Primer', 'B-1705', '4L', 0.0, 979.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 483: 2B PAINT ROLLER #7 (2B-#7)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('2B PAINT ROLLER #7', 'Paint', '2B-#7', 'PC/S', -3.0, 62.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 484: 2B PAINT ROLLER #4 (2B-#4)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('2B PAINT ROLLER #4', 'Paint', '2B-#4', 'PC/S', 9.0, 35.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 485: 2B PAINT BRUSH #3 (2B-PB#3)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #3', 'Paint', '2B-PB#3', 'PC/S', 2.0, 65.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 486: 2B PAINT BRUSH #2 (2B-PB-2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #2', 'Paint', '2B-PB-2', 'PC/S', 9.0, 31.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 487: NIPPON FLEXI-SEAL 145 WHITE 5KG (NF145W-5KG)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', '5KG', 0.0, 1342.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 488: PREMILA MIXING 1L (PREMILAMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PREMILA MIXING 1L', 'Paint', 'PREMILAMIX-1L', 'LITER', 24.87, 2440.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 489: NAX PP BUMPER PRIMER GRAY 1L (PRI1680)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Primer', 'PRI1680', 'LITER', 0.375, 496.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 490: QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L (QDEMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L', 'Paint', 'QDEMIX-4L', 'GALON', 0.0, 800.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 491: ACRYLIC NP, TIMEOUT 1L (ACRYLICMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ACRYLIC NP, TIMEOUT 1L', 'Paint', 'ACRYLICMIX-1L', 'LITER', 9.5, 310.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 492: LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L (LATEXMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'Paint', 'LATEXMIX-4L', 'GALON', -1.0, 900.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 493: LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L (LATEXMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'Paint', 'LATEXMIX-1L', 'LITER', 12.0, 240.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 494: NAX QDU MIX 4L (NAXQDUMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX QDU MIX 4L', 'Paint', 'NAXQDUMIX-4L', 'GALON', 0.0, 3600.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 495: NAX QDU MIX 1L (NAXQDUMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('NAX QDU MIX 1L', 'Paint', 'NAXQDUMIX-1L', 'LITER', -2.12, 900.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 496: EXTREME QDU MIXING 4L (EXTREMEMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EXTREME QDU MIXING 4L', 'Paint', 'EXTREMEMIX-4L', 'GALON', 0.0, 2000.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 497: EXTREME QDU MIXING 1L (EXTREMEMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('EXTREME QDU MIXING 1L', 'Paint', 'EXTREMEMIX-1L', 'LITER', -2.63, 500.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 498: RAIN OR SHINE WHITE 4L (RSW-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE WHITE 4L', 'Paint', 'RSW-4L', 'GALON', 2.0, 735.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 499: 2B PAINT BRUSH 1 1/2 (2B-PB-1 1/2)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH 1 1/2', 'Paint', '2B-PB-1 1/2', 'PC/S', 9.0, 25.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 500: URETHANE MIXING POLYGLOSS, DO IT 4L (UTMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'Paint', 'UTMIX-4L', 'GALON', 0.0, 3200.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 501: RAIN OR SHINE-TEMPTATION 4L (ROS-TEMP-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'Paint', 'ROS-TEMP-4L', 'GALON', 0.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 502: RAIN OR SHINE- UH SO RED 4L (ROS- UH SO RED -4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE- UH SO RED 4L', 'Paint', 'ROS- UH SO RED -4L', 'GALON', 0.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 503: ROS-BRIDAL GOWN-4L (ROS-BRIDE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ROS-BRIDAL GOWN-4L', 'Paint', 'ROS-BRIDE-4L', 'GALON', 0.0, 650.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 504: ROS-SAFARI BROWN_4L (ROS-SAFARE-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ROS-SAFARI BROWN_4L', 'Paint', 'ROS-SAFARE-4L', 'GALON', 0.0, 730.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 505: RAIN OR SHINE-BLUE OCEAN-4L (ROS-BLUE -OC-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'Paint', 'ROS-BLUE -OC-4L', 'GALON', 0.0, 850.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 506: POLYGLOSS-ZINCROMATE PRIMER GREEN-1L (PZPG-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'Primer', 'PZPG-1L', 'LITER', 2.0, 520.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 507: GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L (GAETB-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L', 'Paint', 'GAETB-4L', 'GALON', 1.0, 855.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 508: DO IT URETHANE HARDENER (DOITUH)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE HARDENER', 'Miscellaneous', 'DOITUH', 'CAN', 0.0, 240.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 509: LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L (LATEXMIX-15L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'Paint', 'LATEXMIX-15L', 'PAIL', 0.0, 3200.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 510: ALPHA CROMA LTC THALO BLUE (ALCROLTC -THALO BLUE-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CROMA LTC THALO BLUE', 'Paint', 'ALCROLTC -THALO BLUE-1L', 'LITER', 0.0, 130.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 511: ACRYLIC NP, TIMEOUT 4L (ACRYLICMIX-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ACRYLIC NP, TIMEOUT 4L', 'Paint', 'ACRYLICMIX-4L', 'GALON', 0.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 512: ALPHA CHROMA ACRYTILE PRIMER WHITE (ACRYPRIMER-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'Primer', 'ACRYPRIMER-4L', 'GALON', 0.0, 950.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 513: GLAZER AUTO ENAMEL MIX 1L (AEMIX-1L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL MIX 1L', 'Paint', 'AEMIX-1L', 'LITER', -1.5, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 514: PYLOX MATT BLACK#47 (PLYZMTB-47)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('PYLOX MATT BLACK#47', 'Paint', 'PLYZMTB-47', 'CAN', 6.0, 90.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 515: ALPHA CHROMA OTC RAW SEINA 1CAN (ALPHAC-RS-CAN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW SEINA 1CAN', 'Paint', 'ALPHAC-RS-CAN', 'CAN', 0.0, 80.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 516: ALPHA CHROMA OTC HANSA YELLOW CAN (ALPHAC-HY-CAN)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC HANSA YELLOW CAN', 'Paint', 'ALPHAC-HY-CAN', 'CAN', 0.0, 60.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 517: BOYSEN B-800 FLATWALL ENAMEL 4L (B-800-4L)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('BOYSEN B-800 FLATWALL ENAMEL 4L', 'Paint', 'B-800-4L', 'GAL', -1.0, 0.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  -- Row 518: WELCOAT METAL PRIMER RED OXIDE 1L (WPRE-4010)
  INSERT INTO public.inventory (product_name, category, sku, unit, quantity, cost, price, branch_id)
  VALUES ('WELCOAT METAL PRIMER RED OXIDE 1L', 'Primer', 'WPRE-4010', 'LITER', -2.0, 150.0, 0.0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE
  SET sku = EXCLUDED.sku,
      category = EXCLUDED.category,
      unit = EXCLUDED.unit,
      quantity = EXCLUDED.quantity,
      cost = EXCLUDED.cost,
      price = CASE WHEN EXCLUDED.price > 0 THEN EXCLUDED.price ELSE public.inventory.price END;

  RAISE NOTICE 'Successfully synchronized all 509 items for Valencia ColourSmile.';
END $SYNC$;