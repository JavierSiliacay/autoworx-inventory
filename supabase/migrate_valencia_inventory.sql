-- Migration for Valencia Inventory
DO $MIGRATION$
DECLARE 
  v_branch_id UUID;
BEGIN
  SELECT id INTO v_branch_id FROM public.branches WHERE name ILIKE '%Valencia ColourSmile%' LIMIT 1;
  IF v_branch_id IS NULL THEN
    RAISE EXCEPTION 'Branch Valencia ColourSmile not found!';
  END IF;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHOCOLATE BROWN 4L', 'Paint', 'ROS-633', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHOCOLATE BROWN 1L', 'Paint', 'ROSCB-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE BAGUIO GREEN 4L', 'Paint', 'ROS-701', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS URETHANE THINNER 4L', 'Paint', 'POLYGTHIN-4L', 0, 675, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PHTHALO BLUE 4L', 'Paint', 'PGTB-4L', 0, 1883, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMF-4L', 0, 1743, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'Paint', 'PGMC-4L', 0, 1743, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU JET BLACK 4L', 'Paint', 'PGJB-4L', 0, 1828, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'Paint', 'PGFB-4L', 0, 1930, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS ANTI-CORROSSION', 'Paint', 'PGANTI-C-1L', 3, 440, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 4L', 'Paint', 'PLQDW-4L', 0, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 1L', 'Paint', 'PLQDB-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON SEALERMAX 5170 4L', 'Paint', 'SEALERMAX5170-4L', 0, 960, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROLLER PAINT #7', 'Paint', 'NPR7', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Paint', 'SOB757', -1.5125, 570, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L (DOUBLE ENTRY)', 'Paint', 'BSAXGLWHTE-4L', 0, 1080, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'Paint', 'B-1710', 0, 1096, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('URETHANE MIXING POLYGLOSS, DO IT 1L', 'Paint', 'UTMIX-1L', 29.25, 850, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE- HAPPY DAYS 4L', 'Paint', 'ROS- HAPPY DAYS-4L', 0, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS-BRIGHT ALUMINUM 4L', 'Paint', 'POLY- BT-ALUM-4L', 0, 1950, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE REDUCER', 'Paint', 'ACRY- REDUCER-4L', 0, 550, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE SUN ROOF ROS-SR-100 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-100', 2, 672.4, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR SEMI-GLOSS LATEX WHITE 4L', 'Paint', 'WRSGW-4L', 0, 558, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 4L', 'Paint', 'WQD1000-4L', 0, 695, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WQD1150-4L', 1, 570, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDE MIXING NP, DAVIES, BOYSEN, ALPHA CHROMA, WC 1L', 'Paint', 'QDEMIX-1L', 10.75, 200, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO GREEN PWAC-9042', 'Paint', 'PWAC-9042-1L', 3, 402, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PHTHALO BLUE PWAC-7242', 'Paint', 'PWAC-7242-1/4L', 12, 111, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR PERMANENT RED PWAC-2142', 'Paint', 'PWAC-2142-1L', 2, 461, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT ACRY-TILE TINTING COLOR HANSA YELLOW PWAC-5042', 'Paint', 'PWAC-5042-1/4L', 12, 141, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WASTE COTTON POD', 'Paint', 'WCPOD', 24.5, 70, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('VULCASEAL', 'Paint', 'VSEAL', 3, 62, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('VIBRANT RUBY ROS-823 RAIN OR SHINE 4L', 'Paint', 'ROS-823', 2, 1015, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('VENETIAN RED ACRY-COLOR COLOR AC-11 1L DAVIES', 'Paint', 'AC-11-1L', 4, 108, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO PAINT THINNER BOT', 'Paint', 'UNOPT-BOT', 0, 52, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER BOT', 'Paint', 'UNOLT-BOT', 4, 50, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER 4L', 'Paint', 'UNOLT-4L', 1, 360, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TOLUIDINE RED ACRY-COLOR AC-10 1L DAVIES', 'Paint', 'AC-10-1L', 0, 108, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT URETHANE THINNER 4L', 'Paint', 'TOUT-4L', 0, 510, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Paint', 'TOBF-4L', 11, 585, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Paint', 'TOBF-1L', 10, 160, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Paint', 'TOAT-4L', 0, 500, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOTHALOBLU-4L', 3, 1060, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMELESS PREMIUM LIQUID WAX 5OML', 'Paint', 'TLWAX', 33, 50, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TILE RED ROS-302 RAIN OR SHINE 4L', 'Paint', 'ROS-302', 0, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('THALO GREEN ACRY-COLOR AC-30 1L DAVIES', 'Paint', 'AC-30-1L', 6, 103, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('THALO BLUE ACRY-COLOR AC-20 1L DAVIES', 'Paint', 'AC-20-1L', 0, 103, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS RUBBERIZED', 'Paint', 'TEXAS', 0, 500, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUPRA GLOSS (TURTLE WAX)', 'Paint', 'MTX', 11, 700, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SPRAY GUN F-75G WEBER', 'Paint', 'WEBER', 0, 750, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SEMI GLOSS WHITE ACRYLIC LATEX B-715 BOYSEN 4L', 'Paint', 'B-715', 0, 728, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SAND PAPER #80', 'Paint', 'EA80', 136, 28, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SAND PAPER #100', 'Paint', 'EA100', 104, 28, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SAMAR BEIGE SUN ROOF ROS-SR-183 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-183', 2, 577.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RUGBY', 'Paint', 'RUGBY', 15, 66, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 8, 11, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERLO TACK CLOTH', 'Paint', 'ROBTCKCLTH', 0, 40, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Paint', 'ROBRC-1KG', 3.5, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('REDUCER ACRYTEX B-1750 BOYSEN 4L', 'Paint', 'B-1750', 0, 479, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAW UMBER TINTING COLOR PWTCO-4333 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-4333', 1, 72.0195, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAW UMBER ACRY-COLOR PWTAC-4317 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-4317-1L', 6, 104.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAW SIENNA ACRY-COLOR AC-90 1L DAVIES', 'Paint', 'AC-90-1L', 2, 115, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE XTRA GLOSS 4L', 'Paint', 'ROS-1000', 0, 656, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE TULLE WHITE', 'Paint', 'ROS-109', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE TOUCH OF GRAY', 'Paint', 'ROS-171', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE STONE GRAY 4L', 'Paint', 'ROS-SG-4L', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'ROS-933-4L', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'ROS-629-4L', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'Paint', 'ROS-7000', 0, 546, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE OCEAN BLUE 4L', 'Paint', 'ROS-OB-4L', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE NICOLE PINK 4L', 'Paint', 'ROS-223', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MY WAY 4L', 'Paint', 'ROS-368', 0, 727, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MIX GREEN 4L', 'Paint', 'ROSGRN-4L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE MIX GARY 4L', 'Paint', 'ROSG-4L', 0, 950, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE LUCKY ORANGE 4L', 'Paint', 'ROS-888', 0, 1391, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE IVORY 4L', 'Paint', 'ROS-862', 1, 655, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE GRAY LATEX 4L', 'Paint', 'ROSGRAY-4L', 0, 800, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE CHINA WHITE 4L', 'Paint', 'ROS-818', 0, 665, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'Paint', 'QSHG710-5L', 12, 851, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L', 'Paint', 'QSHG710-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 4, 2442, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', -1, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PLYZVIO-20', 10, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PLYZSKBL-22', 4, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PLYZSIL-42', 2, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Paint', 'PLYZPRGR-145', 1, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PLYZMTW-03', -7, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PLYZLTGR-33', 4, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PLYZHTRSIL-709', 4, 162, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PLYZGLD-705', 1, 117, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PLYZGBLK-48', 3, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PLYZFLOUVIO-604', 8, 135, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PLYZFLOURPNK-603', 3, 135, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PLYZFLOURANGE-601', 8, 135, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PLYZDISIL-701', 10, 117, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PLYZDR-17', 4, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CLEAR 01', 'Paint', 'PLYZCLR-01', 3, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PLYZCANRED-801', 11, 110, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 8, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Paint', 'PYLZANTPR-12', 2, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX HEAT RESISTANT BLACK', 'Paint', 'PLYZHI-TBLCK', 10, 150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS TOP COAT W/H', 'Paint', 'PGTOPC-1L', 6, 470, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYG-4L', 1, 2423, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU WHITE 4L', 'Paint', 'PGW-4L', 0, 1730, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU VIOLET TUNNER 4L', 'Paint', 'PGVT-4L', 0, 2431, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRG-4L', 1, 1883, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PHTHALO GREEN 4L', 'Paint', 'PGTG-4L', 1, 1883, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLY-4L', 0, 1883, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGY-4L', 0, 3188, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGW-4L', 0, 3188, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGO-4L', 0, 3188, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU APPLE RED 4L', 'Paint', 'PGAR-4L', 0, 2431, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU 888 RED 4L', 'Paint', 'PG888-4L', 0, 2450, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE YELLOW 4L', 'Paint', 'PLQDEY-4L', 0, 836, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 1L', 'Paint', 'PLQDW-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE ROYAL BLUE 4L', 'Paint', 'PLQDRB-4L', 0, 698, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 0, 836, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE JADE GREEN 4L', 'Paint', 'PLQDJG-4L', 1, 732, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 3, 773, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE GREEN 4L', 'Paint', 'PLQDG-4L', 1, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 2, 668, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 4L', 'Paint', 'PLQDB-4L', 2, 661, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLASTIC EMPTY BOTTLE', 'Paint', 'BOTTLE', 0, 6.25, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PISTACHIO ELASTOMERIC WATER FROOFING PAINT ROS-238 RAIN OR SHINE 4L', 'Paint', 'ROS-238', 1, 681.4, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINACLE EPOXY ENAMEL THALO BLUE 4L', 'Paint', 'PINEPETHBLUE-4L', 0, 1160, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PHTHALO GREEN TINTING COLOR PWTCO-9033 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-9033', 0, 80.5933, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PERMANENT VIOLET ACRY-COLOR PWTAC-8717 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-8717-1L', 0, 181.764, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PERMANENT ORANGE ACRY-COLOR PWTAC-3117 1L WELCOAT PREMIUM', 'Paint', 'PWTAC-3117-1L', 5, 143.182, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 6, 40, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PAINT BRUSH 2B #1', 'Paint', '2B-PB#1', 16, 18, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ORANGE ELASTO FLOOR ROS-EF-3000 RAIN OR SHINE 4L', 'Paint', 'ROS-EF-3000', 0, 1200, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OLD NEWS', 'Paint', 'MSC', 40, 45, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR W/HARDENER 1L', 'Paint', 'NP8100', 24.37, 1200, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON SKIMCOAT PAIL', 'Paint', 'SKIMCOAT', 0, 1755, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PREMIUM HS CLEAR W/HARDENER 1L', 'Paint', ' ', 0, 585, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'Paint', 'PUT3050-4KG', 0, 565, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Paint', 'MPJOINTCMPND-5L', 4, 400, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE LITER', 'Paint', 'NMPREDOX-LTR', 0, 147, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE GAL', 'Paint', 'NMPREDOX-GAL', 9, 515, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON LACQUER THINNER 4L', 'Paint', 'NLT-4L', 7, 435, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON LACQUER SANDING SEALER 4L', 'Paint', 'NLSS-4L', 0, 611, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON HS FILLER 1L', 'Paint', 'HS-1L', 10, 550, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NFI46G-5KG', 0, 1342, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'Paint', 'NFWE-4L', 2, 615, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATTENING AGENT PASTE 1L', 'Paint', 'OTH10AD-1L', 8, 620, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FF151 FLOP CONTROL', 'Paint', 'FF151', 1, 1160, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 3, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', -1, 1550, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 4, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 1, 1485, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 0, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'Paint', 'NXU1224-4L', 0, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 0, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU FINE SILVER 4L', 'Paint', 'EXTRMEFNESLVR-4L', 0, 1485, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 0, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 3, 1485, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME MAROON 4L', 'Paint', 'NXUMAROON-4L', 0, 1771, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME MAGENTA 4L', 'Paint', 'NXUMAGENTA-4L', 5, 1870, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME CINQUASA VIOLET 4L', 'Paint', 'NXUCINQVIO-4L', 5, 1630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EPOXY THINNER 4L', 'Paint', 'EPOXYTHNR-4L', 0, 550, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L', 'Paint', 'DCTBSG-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L', 'Paint', 'DCTBSG-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L', 'Paint', 'DCTBSG-15L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 1L', 'Paint', 'DCSG715-1L', 0, 186, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'Paint', 'DCSG715-15L', 0, 2680, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG SMOKING GRAY 2045T 5L', 'Paint', '2045T-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG GRAY SUIT 2027P 5L', 'Paint', '2027P-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG ABACADABRA 2034P 5L', 'Paint', '2034P-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'Paint', 'DCSG715-5L', 0, 828, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L', 'Paint', 'DCPBSG-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 15L', 'Paint', 'DCPBSG-15L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'Paint', 'DCF701-5L', 0, 630, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'Paint', 'DCF701-1L', 2, 165, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'Paint', 'DCF701-15L', 4, 2130, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L', 'Paint', 'DCDBSG-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 1L', 'Paint', 'DCDBSG-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L', 'Paint', 'DCDBSG-15L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L', 'Paint', 'DCABSG-5L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 1L', 'Paint', 'DCABSG-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L', 'Paint', 'DCABSG-15L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH LITER', 'Paint', 'NCGVARNISH-LTR', 1, 449, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH GAL', 'Paint', 'NCGVARNISH-GAL', 4, 1460, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS LACQUER 4L', 'Paint', 'NCGL-4L', 4, 660, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'Paint', 'NAS-5G', 7, 402, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Paint', 'NAS535', 13, 450, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON 2K BINDER 1L', 'Paint', 'PNB-1L', 0, 900, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 6, 1215, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE RED TRIPPLE 8 4L', 'Paint', 'NPA1131', 8, 1850, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE PERMANENT MAROON 4L', 'Paint', 'NPA1177', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 4, 1120, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 2, 1050, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 12, 1000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 2.7575, 445, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Paint', 'SOB745', 5.15, 786, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9700', 9, 1030, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9200', 10, 871, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB200 BINDER', 'Paint', 'NB200', 1, 2100, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 1, 2100, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 2, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 2, 1561, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT902 GRASS GREEN 1L', 'Paint', 'MT902', 3, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT901 CYANINE GREEN 1L', 'Paint', 'MT901', 0, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 3, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 2, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 1, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 0, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 1, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 3, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 4, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 4, 1593, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT702 CINQUASIA VIOLET 1L', 'Paint', 'MT702', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 0, 1744, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 1, 2048, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 2, 1608, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 1, 2048, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 3, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 2, 2302, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 3, 1849, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 2, 2349, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 2, 2867, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 3, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 3, 2900, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 0, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 4, 2048, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 1, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 2, 2426, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 2, 2958, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 2, 1744, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 2, 3600, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 1, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 2, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 3, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', -1, 1668, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 2, 1090, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 4, 1090, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 2, 1896, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 3, 2996, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 2, 1376, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 0, 5050, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 3, 3600, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 2, 1090, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 1, 4160, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'Paint', 'MT100-1L', 2, 1090, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', 0, 6000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 4, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 1, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 1, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 0, 3650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 1, 3650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'Paint', 'MT068', 2, 6000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 4, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 3, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 2, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 1, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 1, 3000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L', 'Paint', 'MT033-4L', 0, 6430, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 2, 1995, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 1, 1745, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 4, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 0, 1745, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 4L', 'Paint', 'MT023-4L', 0, 6430, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 1, 1994, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 1, 1745, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 3, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 2, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 1, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 0, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 4L', 'Paint', 'MT002-4L', 0, 6563, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 3, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 3, 2150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 3, 3650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA 2K NB200 HARDENER', 'Paint', 'NB200-HAR', 0, 1030, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAX21 URETHANE HAEDENER', 'Paint', 'NAX21', -11, 190, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'Paint', 'NAT992', 6, 410, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 4L', 'Paint', 'NAT990-4L', 3, 1518, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 1L', 'Paint', 'NAT990-1L', 3, 409, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 7, 830, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 2, 470, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 0, 685, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 9, 436, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 6, 760, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'Paint', 'NAT728', 1, 995, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 6, 1085, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 6, 652, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 6, 621, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 1, 2325, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'Paint', 'NAT719-1L', 9, 595, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 6, 422, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 0, 422, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 4L', 'Paint', 'NAT712-4L', 0, 2180, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 0, 581, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 5, 581, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 6, 422, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 3, 422, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 5, 498, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 6, 450, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 1, 620, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 6, 517, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 2, 435, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 2, 1090, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 5, 500, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 6, 683, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', -0.25, 451, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 9, 367, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 4, 1035, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Paint', 'NAT321', 10, 897, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 5, 425, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 4, 1380, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-2930 TTC QDU SASH BLACK 1L', 'Paint', 'NAX2930', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 6, 1511, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1OO TTC WHITE 1L', 'Paint', 'NAT100-1L', 0, 425, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 14, 1125, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 3, 540, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 5, 395, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 6, 895, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158', 2, 1310, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 10, 1110, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'Paint', 'NAT147', 7, 1120, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 12, 1315, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 6, 1542, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 2, 1956, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 6, 1956, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 5, 1956, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 5, 1956, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 6, 1543, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 5, 798, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 6, 1599, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 6, 910, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 6, 840, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 6, 840, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 6, 886, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 0, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 0, 640, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 5, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 0, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 6, 694, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'Paint', 'NAT1159', 0, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 3, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 0, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 2, 780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 4, 661, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 2, 661, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 2, 2400, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 6, 635, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 6, 779, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 2, 863, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 2, 442, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 6, 1215, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', -2, 675, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-100 TTC WHITE 4L', 'Paint', 'NAT100-4L', -1, 1905, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Paint', 'SOB642', 0, 591, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Paint', 'NXE4090', 7, 1320, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLUE W/HARDENER 4L', 'Paint', 'NXE1513', 0, 1320, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLACK WITH HARDENER 4L', 'Paint', 'NXE1988', 3.75, 1050, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Paint', 'PRI3634', 6.13, 363, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Paint', 'NAX301', 0.25, 784, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Paint', 'NAX141', 27, 344, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX108', -701.7, 460, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'Paint', 'MEG3001-4L', 0, 710, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L', 'Paint', 'MEG3001-1L', 0, 193, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE W/H REPACK', 'Paint', 'MEG3001R-1L', -1, 260, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L', 'Paint', 'MEG3100-4L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'Paint', 'MEG3100-1L', 23, 193, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'Paint', 'MEG3602-4L', 0, 685, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L', 'Paint', 'MEG3602-1L', 0, 193, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Paint', 'MEG3901-4L', 2, 710, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L', 'Paint', 'MEG3901-1L', 0, 193, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK W/H REPACK', 'Paint', 'MEG3901R-1L', -0.25, 250, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MAYON LACQUER THINNER 3.75L', 'Paint', 'MYNALTHNR-3.75L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MARINE EPOXY A & B 1L SET EL KAPITAN BOSTIK', 'Paint', 'MEEKBOS-1L', 8, 538.2, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LIME ROS-138 RAIN OR SHINE 4L', 'Paint', 'ROS-138', 0, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LIGHT BEIGE ROS-353 RAIN OR SHINE 4L', 'Paint', 'ROS-353', 5, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LAMP BLACK OIL TINTING COLOR PWTCO-1133 1/4L WELCOAT PREMIUM', 'Paint', 'PWTCO-1133', 0, 60.8736, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #6', 'Paint', 'PUTTYKNI #6', 14, 15, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #4', 'Paint', 'PUTTYKNI #4', 0, 12, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HANSA YELLOW OIL TINITNG COLOR PWTCO-5033 1/4L WELCOAT PREMIUM', 'Paint', 'PWTCO-5033', 0, 90.8818, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HANSA YELLOW ACRY-COLOR AC-40 1L DAVIES', 'Paint', 'AC-40-1L', 3, 141, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GREEN ELASTOMERIC WATER FROOFING PAINT ROS-SR-911 SUN ROOF RAIN 4L', 'Paint', 'ROS-SR-911', 0, 577.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GOLDEN BUTTER ROS-678 RAIN OR SHINE 4L', 'Paint', 'ROS-678', 5, 645.3, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GOLD RUSH ROS-529 RAIN OR SHINE 4L', 'Paint', 'ROS-529', 2, 767.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL YELLOW GREEN 1L', 'Paint', 'GLAZERYG-1L', 0, 350, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE 4L', 'Paint', 'GLAUEWHITE-4L', 0, 855, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL WHITE (R) 1L', 'Paint', 'GLAZERW-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL LEMON YELLOW 4L', 'Paint', 'GLAZERYG-4L', 0, 855, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL BLACK 4L', 'Paint', 'GLAZERB-4L', 0, 761, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GI PAINT REMOVER BOTTLE', 'Paint', 'GIPREMOVER-BOT', 16, 68, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FRANELLA CLOTH 1YARD', 'Paint', 'FRANELLA', 70, 68, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLAT WHITE ACRYLIC LATEX B-701 BOYSEN 4L', 'Paint', 'B-701-4L', 3, 640, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EUROMAX SPRAY GUN F75', 'Paint', 'SPRYGUN', 0, 880, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EPOXY ENAMEL MIX BLUE 1L', 'Paint', 'EPOXYELB-1L', 0, 400, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EMPTY GLASS FOR MIXING PAINT 1/4L', 'Paint', 'EMPTYGLASS', 0, 3, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EMPTY CAN LITER SIZE', 'Paint', 'CAN-1L', 0, 3, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EL KAPITAN A & B 4L', 'Paint', 'MEEKBOS-4L', 3, 2098, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO BAG MEDIUM', 'Paint', 'ECOBAG-M', 0, 5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1500', 'Paint', 'EA1500', 101, 28, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #800', 'Paint', 'EA800', 75, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #600', 'Paint', 'EA600', -15, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #60', 'Paint', 'EA60', 197, 28, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #400', 'Paint', 'EA400', 63, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #240', 'Paint', 'EA240', 115, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #2000', 'Paint', 'EA2000', 70, 28, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1200', 'Paint', 'EA1200', 28, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #120', 'Paint', 'EA120', 115, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #1000', 'Paint', 'EA1000', 291, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SAND PAPER #320', 'Paint', 'EA320', 363, 18.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'Paint', 'PTRL-7', 0, 65, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #4', 'Paint', 'DPB-4', 2, 99, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #3', 'Paint', 'DPB-3', 0, 65, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #2', 'Paint', 'DPB-2', 0, 35, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1 1/2', 'Paint', 'DPB-1 1/2', -1, 25, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1', 'Paint', 'DPB-1', 0, 18, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'Paint', 'BBR-MINI', 0, 35, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILTER WITH HARDENER 4L', 'Paint', 'DOMBF-4L', 4, 495, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILTER WITH HARDENER 1L', 'Paint', 'DOMBF-1L', 3, 150, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 3, 1780, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL MIX 4L', 'Paint', 'AEMIX-4L', -2, 1400, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE THINNER 4L', 'Paint', 'DOITH-4L', 1, 590, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 0, 2205, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Paint', 'DOITSHLDALL-BOT', 9, 160, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT HARDENER 2K TOP COAT', 'Paint', 'HDOIT', 0, 240, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT BLACK MIX MICA 1L', 'Paint', 'QDUDTBLACKM-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DEEP BASED MUTI PURPOSE COATING NIPPON PAINT', 'Paint', 'NP PB 1534D', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE WHITE 4L', 'Paint', 'DV400-WHITE-4L', 0, 820, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OTC THALO GREEN 1/4L', 'Paint', 'TC-33-1/4L', 1, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OTC THALO BLUE 1/4L', 'Paint', 'TC-21-1/4L', 0, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR TC-60 LAMP BLACK 1/4L', 'Paint', 'TC-60-1/4L', 4, 95, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID-TILE TINTING COLOR VENETIAN RED 1L', 'Paint', 'TCLT-11-1L', 4, 399, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID-TILE TINTING COLOR BLACK 1L', 'Paint', 'TCLT-60-1L', 3, 399, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'Paint', 'DV-5-525-4L', 12, 1095, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 80', 'Paint', 'CUMIFS-80', 56, 42.4, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 60', 'Paint', 'CUMIFS-60', 18, 44.73, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 36', 'Paint', 'CUMIFS-36', 130, 55.36, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING 100', 'Paint', 'CUMIFS-100', 94, 39.03, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 25, 23.59, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Paint', 'CRO-MT1/2', 39, 15.73, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE #2', 'Paint', 'CRO-MT2', 13, 63, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE #1', 'Paint', 'CRO-MT1', 14, 32, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('COTTA ELASTOMERIC WATER FROOFING PAINT R0S-SR-337 SUN ROOF RAIN 4L', 'Paint', 'ROS-SR-337', 2, 523.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('COCONUT ELASTOMERIC WATER FROOFING PAINT ROS-739 RAIN OR SHINE 4L', 'Paint', 'ROS-739', 0, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CANDY TUFF ROS-367 RAIN OR SHINE 4L', 'Paint', 'ROS-367', 0, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BURNT UMBER PREMIUM ACRY COLOR PWTAC-4617 1L WELCOAT', 'Paint', 'PWTAC-4617-1L', 6, 104.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BURNT UMBER OIL TINTING COLOR TC-93 1/4L DAVIES', 'Paint', 'TC-93-1/4L', 0, 53, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BURNT SIENNA TINTING COLOR PWTCO-6133 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-6133', 1, 80.59, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BURNT SIENNA PREMIUM ACRY COLOR PWTAC-6517 1L WELCOAT', 'Paint', 'PWTAC-6517-1L', 6, 104.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BULLETIN RED TINTING COLOR PWTCO-2133 1/4L PREMIUM WELCOAT', 'Paint', 'PWTCO-2133', 0, 87.4523, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BUFFING PAD', 'Paint', 'BPAD', 2, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN QDE WHITE GAL', 'Paint', 'BSQDEW-GAL', 0, 834, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN PERMACOAT GLOSS LATEX B-710 WHITE 4L', 'Paint', 'B-710', 4, 765, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN PERMACOAT FLAT LATEX BLACK 4L', 'Paint', 'B-791', 1, 615, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN LTC LAMP BLACK 1L', 'Paint', 'B1490-1L', 8, 92, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN FWE WHITE GAL', 'Paint', 'BSFWEW-GAL', 7, 777, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX CAST 4L', 'Paint', 'B-1711', 2, 545, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'Paint', 'BSKSMCOAT-BAG', 16, 495, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK ELASTO FLOOR ROS-EF-1130 RAIN OR SHINE 4L', 'Paint', 'ROS-EF-1130', 3, 925.5, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK ACRY-COLOR AC-60 1L DAVIES', 'Paint', 'AC-60-1L', 0, 85, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BITTER SWEET SUN ROOF ROS-SR-777 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-777', 1, 595.7, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BEIGE SUN ROOF ROS-SR-182 RAIN OR SHINE 4L', 'Paint', 'ROS-SR-182', 2, 577.6, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ANTIQUE WHITE ROS-270 RAIN OR SHINE 4L', 'Paint', 'ROS-270', 0, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AMBER ROSE ROS-350 RAIN OR SHINE 4L', 'Paint', 'ROS-350', 3, 661.1, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'Paint', 'ALPHAGLOSS-4L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ACRYTEX PRIMER WHITE B-1705 BOYSEN 4L', 'Paint', 'B-1705', 0, 979, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT ROLLER #7', 'Paint', '2B-#7', 0, 62, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT ROLLER #4', 'Paint', '2B-#4', 11, 35, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #3', 'Paint', '2B-PB#3', 4, 65, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #2', 'Paint', '2B-PB-2', 0, 31, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', 0, 1342, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PREMILA MIXING 1L', 'Paint', 'PREMILAMIX-1L', 43.75, 2440, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Paint', 'PRI1680', 3.125, 496, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDE NP, ALPHA CHROMA, DAVIES, BOYSEN 4L', 'Paint', 'QDEMIX-4L', 0, 800, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ACRYLIC NP, TIMEOUT 1L', 'Paint', 'ACRYLICMIX-1L', 9.5, 310, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 4L', 'Paint', 'LATEXMIX-4L', -3, 900, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LATEX NP, ALPHA CHROMA, DAVIES, BOYSEN, WC 1L', 'Paint', 'LATEXMIX-1L', 14, 240, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX QDU MIX 4L', 'Paint', 'NAXQDUMIX-4L', 0, 3600, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX QDU MIX 1L', 'Paint', 'NAXQDUMIX-1L', -13.1, 900, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTREME QDU MIXING 4L', 'Paint', 'EXTREMEMIX-4L', 0, 2000, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTREME QDU MIXING 1L', 'Paint', 'EXTREMEMIX-1L', 4, 500, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE WHITE 4L', 'Paint', 'RSW-4L', 2, 735, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH 1 1/2', 'Paint', '2B-PB-1 1/2', -2, 25, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('URETHANE MIXING POLYGLOSS, DO IT 4L', 'Paint', 'UTMIX-4L', -1.09375, 3200, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE-TEMPTATION 4L', 'Paint', 'ROS-TEMP-4L', 0, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE- UH SO RED 4L', 'Paint', 'ROS- UH SO RED -4L', 0, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROS-BRIDAL GOWN-4L', 'Paint', 'ROS-BRIDE-4L', 0, 650, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROS-SAFARI BROWN_4L', 'Paint', 'ROS-SAFARE-4L', 0, 730, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE-BLUE OCEAN-4L', 'Paint', 'ROS-BLUE -OC-4L', 0, 850, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS-ZINCROMATE PRIMER GREEN-1L', 'Paint', 'PZPG-1L', 3, 520, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTOMOTIVE ENAMEL THALO BLUE-4L', 'Paint', 'GAETB-4L', 0, 855, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE HARDENER', 'Paint', 'DOITUH', 0, 240, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('LATEXNP,ALPHA CROMA,DAVIES,BOYSEN,WC 15L', 'Paint', 'LATEXMIX-15L', 0, 3200, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CROMA LTC THALO BLUE', 'Paint', 'ALCROLTC -THALO BLUE-1L', 0, 130, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ACRYLIC NP, TIMEOUT 4L', 'Paint', 'ACRYLICMIX-4L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE', 'Paint', 'ACRYPRIMER-4L', 0, 950, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL MIX 1L', 'Paint', 'AEMIX-1L', 0, 0, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX MATT BLACK#47', 'Paint', 'PLYZMTB-47', 6, 90, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW SEINA 1CAN', 'Paint', 'ALPHAC-RS-CAN', 0, 80, 0, v_branch_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE 
  SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;

END $MIGRATION$;
