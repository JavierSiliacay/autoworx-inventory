-- Migrate Master Inventory from Google Sheet
DO $$
DECLARE b_id UUID;
BEGIN
  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%main distribution%' OR name ILIKE '%main%' LIMIT 1;
  IF b_id IS NULL THEN
    SELECT id INTO b_id FROM public.branches ORDER BY created_at LIMIT 1;
  END IF;

  DELETE FROM public.inventory WHERE branch_id = b_id;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WARM YELLOW 4L', 'Paint', 'XTRMEQDWARMYLW-4L', 16, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT QDE LIGHT GRAY 4L', 'Paint', 'WCQDLTGRY-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT QDE BEIGE 4L', 'Paint', 'WCQDBEIG-4L', 0, 712.5, 926.25, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT PREM OTC THALO GREEN 1/4L', 'Paint', 'WCOTCTHGR-1/4L', 0, 80, 104, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT PREM OTC THALO BLUE 1/4L', 'Paint', 'WCOTCTHBLU-1/4L', 0, 80, 104, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT PREM OTC HANZA YELLOW 1/4L', 'Paint', 'WCOTCHNYL-1/4L', 0, 91, 118.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE RUSSET MICA 4L', 'Paint', 'WBRUTRSTMICA-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE PEARL YELLOW MICA 4L', 'Paint', 'WBRUTMICAYLW-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE CHROMA RED MICA 4L', 'Paint', 'WBRUTMICARED-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE MICA ORANGE 4L', 'Paint', 'WBRUTMICAORNGE-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE PEARL GREEN MICA 4L', 'Paint', 'WBRUTMICAGRN-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER URETHANE BLUE MICA 4L', 'Paint', 'WBRUTBLUMICA-4L', 0, 3600, 4680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER EPOXY ENAMEL THALO BLUE 4L', 'Paint', 'WBREPENTHB-4L', 0, 1250, 1625, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY REDUCER 4L', 'Paint', 'USAEPR-4L', 0, 500, 650, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO PAINT THINNER BOT', 'Paint', 'UNOPT-BOT', 0, 48, 62.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO PAINT THINNER BOX', 'Paint', 'UNOPT', 0, 1176, 1528.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER BOX', 'Paint', 'UNOLT-BOX', 0, 1152, 1497.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER BOT', 'Paint', 'UNOLT-BOT', 0, 45, 58.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('UNO LACQUER THINNER 4L', 'Paint', 'UNOLT-4L', 0, 341, 443.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS QDE WHITE 4L', 'Paint', 'TXQDW-4L', 0, 419, 544.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS QDE BLACK 4L', 'Paint', 'TXQDBL-4L', 0, 409, 531.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS FLAT LATEX WHITE 4L', 'Paint', 'TXFLW-4L', 0, 264.44, 343.77, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PAINT ROLLER TRAY', 'Paint', 'TRAY', 29, 32, 41.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT URETHANE THINNER 4L', 'Paint', 'TOUT-4L', 36, 698.88, 908.54, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 4L', 'Paint', 'TOBF-4L', 324, 611.34, 635, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT BODY FILLER WITH HARDENER 1L', 'Paint', 'TOBF-1L', 252, 167.67, 190, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC WHITE 4L', 'Paint', 'TOACW-4L', 9, 922.78, 1199.61, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC TOPCOAT CLEAR 4L', 'Paint', 'TOACCLR-4L', 0, 824, 1071.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THINNER 4L', 'Paint', 'TOAT-4L', 570, 636.48, 827.42, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO GREEN 4L', 'Paint', 'TOACTHGR-4L', 12, 1050.06, 1365.08, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC THALO BLUE 4L', 'Paint', 'TOACTB-4L', 13, 1140.34, 1482.44, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC RED GOLD 4L', 'Paint', 'TOACREDGLD-4L', 20, 1168.46, 1519, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC PRIMER WHITE 4L', 'Paint', 'TOACPW-4L', 19, 876.9, 1139.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON TINT BASE MATEX CC 5L', 'Paint', 'TBM-5L', 0, 684, 889.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON TINT BASE MATEX CC 1L', 'Paint', 'TBM-1L', 4, 180, 234, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON TINT BASE MATEX CC 15L', 'Paint', 'TBM-15L', 0, 1950, 2535, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOD145 SOLVENT NAPTHA/DEGREASER 4L', 'Paint', 'SOD145', 28, 415, 800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOB757 HIGH GRADE URETHANE THINNER 4L', 'Paint', 'SOB757', 1256, 620, 680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX SOB745 BLENDING THINNER 4L', 'Paint', 'SOB745', 48, 691, 898.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX MULTIPURPOSE URETHANE THINNER 4L', 'Paint', 'SOB642', 66, 800, 840, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUNSHINE LTC TOULIDINE RED 4L', 'Paint', 'SLTCTOLRD-4L', 0, 500, 650, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUNSHINE LTC THALO BLUE 4L', 'Paint', 'SLTCTHB-4L', 0, 500, 650, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUNSHINE LTC RAW SIENNA 4L', 'Paint', 'SLTCRS-4L', 0, 480, 624, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUNSHINE LTC HANZA YELLOW 4L', 'Paint', 'SLTCHY-4L', 0, 550, 715, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON SEALERMAX 5170 4L', 'Paint', 'SEALRMAX5170-4L', 0, 913, 1186.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERLO TACK CLOTH', 'Paint', 'ROBTCKCLTH', 0, 33.6, 43.68, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERLO RUBBING COMPOUND 1KG', 'Paint', 'ROBRC-1KG', 182, 582.67, 800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBFILTER PAINT STRAINER 125M', 'Paint', 'ROBPNTSTRNR', 39, 6.65, 8.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE REFLECTIVE YELLOW 5L', 'Paint', 'ROADLNEREFYLW-5L', 7, 1184, 1539.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE REFLECTIVE WHITE 5L', 'Paint', 'ROADLNEREFWHTE-5L', 8, 1184, 1539.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE REFLECTIVE BLACK 5L', 'Paint', 'ROADLNEREFBLACK-5L', 7, 1184, 1539.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 5L', 'Paint', 'QSHG710-5L', 0, 810, 1053, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 1L', 'Paint', 'QSHG710-1L', 0, 176.94, 230.02, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('Q-SHIELD EXTRA HG-710 GLOSS WHITE 15L', 'Paint', 'QSHG710-15L', 9, 2550, 3315, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER WHITE 02', 'Paint', 'PYLZWH-02', 38, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER VIOLET 20', 'Paint', 'PYLZVIO-20', 22, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SKY BLUE 22', 'Paint', 'PYLZSKBL-22', 2, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER SILVER 42', 'Paint', 'PYLZSIL-42', 60, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER PRIMER GRAY 145', 'Paint', 'PYLZPRGR-145', 96, 81.186336, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER MATT WHITE 03', 'Paint', 'PYLZMTW-03', 46, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER MATT BLACK 47', 'Paint', 'PYLZMTBLK-47', 48, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER LIGHT GREEN 33', 'Paint', 'PYLZLTGR-33', 50, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER HEAT RESISTANT SILVER 709', 'Paint', 'PYLZHTRSTSIL-709', 28, 146.2, 160, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GOLD 705', 'Paint', 'PYLZGLD-705', 60, 95.04, 120, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GLOSS BLACK 48', 'Paint', 'PYLZGLBLK-48', 54, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT YELLOW 600', 'Paint', 'PYLZFLOUYEL-600', 12, 123.42, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT VIOLET 604', 'Paint', 'PYLZFLOUVIO-604', 10, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT RED 602', 'Paint', 'PYLZFLOURED-602', 36, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT ORANGE 601', 'Paint', 'PYLZFLOURANGE-601', 28, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT PINK 603', 'Paint', 'PYLZFLOUPNK-603', 48, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT GREEN 605', 'Paint', 'PYLZFLOUGRN-605', 0, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER FLOURESCENT BLUE 606', 'Paint', 'PYLZFLOUBLU-606', 0, 127.16, 140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DEEP RED 17', 'Paint', 'PYLZDR-17', 22, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER DISTINGUISHED SILVER 701', 'Paint', 'PYLZDISIL-701', 28, 97.92, 120, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CLEAR 01', 'Paint', 'PYLZCLR-01', 93, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER CANDYTONE RED 801', 'Paint', 'PYLZCANRED-801', 58, 82.28, 100, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ART YELLOW 06', 'Paint', 'PYLZAY-06', 110, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER ANTI-RUST BROWN PRIMER 12', 'Paint', 'PYLZANTPR-12', 108, 79.863168, 95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #6 BLUE', 'Paint', 'PUTTYKNI #6', 0, 13, 18, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('JAPAN PUTTY KNIFE #4 BLUE', 'Paint', 'PUTTYKNI #4', 80, 9, 15, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PRO UNIVERSAL BODY FILLER 4KG', 'Paint', 'PUT3672-4KG', 0, 628, 790, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 4KG', 'Paint', 'PUT3050-4KG', 0, 625, 812.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PAINT FILLERMAX BODY FILLER WITH HARDENER 1KG', 'Paint', 'PUT3050-1KG', 0, 165, 214.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT ROLLER #7 W/H', 'Paint', 'PTRL-7', 0, 60, 78, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ALPHA HB SPRAY FILLER GRAY WITH HARDENER 1L', 'Paint', 'PRI3634', 408, 360, 450, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER GRAY 1L', 'Paint', 'PRI1680', 0, 605, 635, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB100 B/C BINDER 4L', 'Paint', 'PNB100', 27, 2158, 2280, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 4L', 'Paint', 'PLQDW-4L', 0, 750, 975, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE WHITE 1L', 'Paint', 'PLQDW-1L', 0, 200, 260, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE ROYAL BLUE 4L', 'Paint', 'PLQDRB-4L', 0, 805, 1046.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE LEMON YELLOW 4L', 'Paint', 'PLQDLY-4L', 8, 965, 1254.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE JADE GREEN 4L', 'Paint', 'PLQDJG-4L', 0, 844, 1097.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE INTERNATIONAL RED 4L', 'Paint', 'PLQDIR-4L', 2, 891, 1158.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE CHOCOLATE BROWN 4L', 'Paint', 'PLQDCB-4L', 8, 770, 1001, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 4L', 'Paint', 'PLQDB-4L', 0, 763, 991.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE QDE BLACK 1L', 'Paint', 'PLQDB-1L', 0, 215, 279.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN KONSTRUKT SKIMCOAT K201 16L', 'Paint', 'PERMAPLSTK201-16L', 0, 1335, 1735.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PASTEL BASE MATEX CC 5L', 'Paint', 'PBM-5L', 17, 714, 928.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PASTEL BASE MATEX CC 1L', 'Paint', 'PBM-1L', 6, 188, 244.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PASTEL BASE MATEX CC 15L', 'Paint', 'PBM-15L', 8, 2036, 2646.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU SILVER 4L', 'Paint', 'NXU7391-4L', 47, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU GREEN 4L', 'Paint', 'NXU4406-4L', 11, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU RED 4L', 'Paint', 'NXU4113-4L', 0, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU WHITE 4L', 'Paint', 'NXU4075-4L', 88, 1560, 1640, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLACK 4L', 'Paint', 'NXU1965-4L', 62, 1560, 1640, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU BLUE 4L', 'Paint', 'NXU1587-4L', 0, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU YELLOW 4L', 'Paint', 'NXU1338-4L', 21, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU ORANGE 4L', 'Paint', 'NXU1224-4L', 0, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL RED WITH HARDENER 4L', 'Paint', 'NXE4130', 0, 1110, 1443, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL WHITE WITH HARDENER 4L', 'Paint', 'NXE4090', -3, 1310, 1350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLACK W/HARDENER 4L', 'Paint', 'NXE1988', -2, 1110, 1350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL GRAY WITH HARDENER 4L', 'Paint', 'NXE1670', 0, 1110, 1443, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL BLUE W/HARDENER 4L', 'Paint', 'NXE1513', 0, 1310, 1703, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL YELLOW WITH HARDENER 4L', 'Paint', 'NXE1313', 10, 1305, 1350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME EPOXY ENAMEL ORANGE WITH HARDENER 4L', 'Paint', 'NXE1234', 0, 1110, 1443, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON SANDING SEALER 4L', 'Paint', 'NSS-4L', 0, 611, 794.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE BRIGHT WHITE 4L', 'Paint', 'NPA4021', 4, 1245, 1320, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE JET BLACK 4L', 'Paint', 'NPA1983', 16, 1245, 1320, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE THALO GREEN 4L', 'Paint', 'NPA1487', 5, 1494, 1570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE LEMON YELLOW 4L', 'Paint', 'NPA1372', 115, 1494, 1570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE PERMANENT MAROON 4L', 'Paint', 'NPA1177', 0, 1979, 2572.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPELAC ACE RED TRIPLE 8 4L', 'Paint', 'NPA1131', 14, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9700 HS 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9700', 108, 1145, 1205, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NP9200 2K CLEAR WITH HARDENER 1L', 'Paint', 'NP9200', 23, 925, 975, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE YELLOW 5L', 'Paint', 'NONREFLCTVEYEL-5L', 7, 1124, 1461.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE WHITE 5L', 'Paint', 'NONREFLCTVEWHTE-5L', 8, 1124, 1461.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ROADLINE NON-REFLECTIVE BLACK 5L', 'Paint', 'NONREFLCTVEBLK-5L', 7, 1124, 1461.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON LACQUER THINNER (FAST DRY) 4L', 'Paint', 'NLT-4L', 0, 485, 630.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATWALL ENAMEL WHITE 4L', 'Paint', 'NFWE-4L', 0, 585, 760.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 5KG', 'Paint', 'NF146G-5KG', 1, 1278, 1661.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 146 GRAY 20KG', 'Paint', 'NF146G-20KG', 0, 4855, 6311.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 5KG', 'Paint', 'NF145W-5KG', 2, 1278, 1661.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLEXI-SEAL 145 WHITE 20KG', 'Paint', 'NF145W-20KG', 0, 4855, 6311.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME PU GLOSS VARNISH', 'Paint', 'NEV177-1L', 0, 301, 391.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME METAL PRIMER GRAY 4L', 'Paint', 'NEM3677-4L', 0, 439, 570.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME METAL PRIMER GRAY 1L', 'Paint', 'NEM3677-1L', 0, 117, 152.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME METAL PRIMER RED OXIDE 4L', 'Paint', 'NEM3120-4L', 0, 439, 570.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX EXTREME METAL PRIMER RED OXIDE 1L', 'Paint', 'NEM 3120-1L', 0, 117, 152.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DEAD FLAT LACQUER 4L', 'Paint', 'NDFL-4L', 27, 643, 835.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CELAR GLOSS LACQUER 4L', 'Paint', 'NCGL-4L', 27, 627, 815.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB200 HARDENER', 'Paint', 'NB200-HARD', 1, 685, 890.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA NB200 BINDER', 'Paint', 'NB200', 0, 2000, 2250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 34 ALPHA HARDENER', 'Paint', 'NAX34', 0, 95, 123.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 301 NAX QDU FLAT CLEAR WITH HARDENER 1L', 'Paint', 'NAX301', 42, 830, 875, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-2930 TTC QDU SASH BLACK 1L', 'Paint', 'NAX2930', 0, 308, 400.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAX21 URETHANE HARDENER', 'Paint', 'NAX21', 109, 165, 225, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 141 NAX MAXIMA URETHANE FD CLEAR WITH HARDENER 1L', 'Paint', 'NAX141', 1248, 430, 450, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 108 CERAMIC 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX108', 4884, 545, 560, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX 107 SUPERIO 2K CLEAR WITH HARDENER 1L', 'Paint', 'NAX107', 0, 626, 813.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1062 QDU 040 SUPER WHITE 1L', 'Paint', 'NAX1062', 2, 581, 620, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-10100 NH-585 PEARL WHITE MICA 1L', 'Paint', 'NAX10100', 2, 806, 850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-992 TTC BLACK NO.8 1L', 'Paint', 'NAT992', 0, 515, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 4L', 'Paint', 'NAT990-4L', 0, 1743, 1835, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-990 TTC BLACK 1L', 'Paint', 'NAT990-1L', 0, 514.6, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-745 TTC MEDIUM SPARKLE SILVER 1L', 'Paint', 'NAT745', 29, 996, 1050, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-740 TTC ULTRA FINE SILVER 1L', 'Paint', 'NAT740', 18, 557, 585, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-736 TTC HI-SPARKLE EXTRA COARSE 1L', 'Paint', 'NAT736', 23, 747, 784, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-733 TTC SUPER FINE WHITE SILVER 1L', 'Paint', 'NAT733', 24, 515, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-729 TTC HI-SPARKLE FINE SILVER 1L', 'Paint', 'NAT729', 53, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-728 TTC SPARKLE ORANGE METALLIC 1L', 'Paint', 'NAT728', 0, 1286.5, 1355, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-727 TTC HI-SPARKLE MIDCOARSE SILVER 1L', 'Paint', 'NAT727', 29, 1162, 1225, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-725 TTC SPARKLE MID-COARSE SILVER 1L', 'Paint', 'NAT725', 29, 723, 760, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-720 TTC SPARKLE WHITE SILVER 1L', 'Paint', 'NAT720', 29, 747, 785, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 4L', 'Paint', 'NAT719-4L', 0, 2573, 2705, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-719 TTC COARSE SILVER 1L', 'Paint', 'NAT719-1L', 0, 706, 745, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-716 TTC SPARKLE SILVER 1L', 'Paint', 'NAT716', 27, 515, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-715 TTC FINE SILVER 1L', 'Paint', 'NAT715-1L', 0, 515, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 4L', 'Paint', 'NAT712-4L', 0, 2490, 2620, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-712 TTC MEDIUM FINE SILVER 1L', 'Paint', 'NAT712-1L', 0, 706, 745, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT707 HI-SPARKLE SILVER 1L', 'Paint', 'NAT707-1L', 15, 580, 745, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT706 MEDIUM COARSE SILVER 1L', 'Paint', 'NAT706-1L', 27, 430, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT705 SUPER FINE SILVER 1L', 'Paint', 'NAT705-1L', 17, 430, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-595 TTC CYANINE BLUE 1L', 'Paint', 'NAT595', 16, 581, 610, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-557 TTC BLUE NO.9 1L', 'Paint', 'NAT557', 20, 540, 570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-556 TTC BLUE NO.8 1L', 'Paint', 'NAT556', 19, 747, 785, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-555 TTC BLUE NO.7 1L', 'Paint', 'NAT555', 12, 565, 595, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-550 TTC SUPER BLUE 1L', 'Paint', 'NAT550', 15, 515, 545, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-530 TTC FINE BLUE 1L', 'Paint', 'NAT530', 16, 1245, 1310, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-490 TTC EVERGREEN 1L', 'Paint', 'NAT490', 19, 664, 700, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-410 TTC CYANINE GREEN 1L', 'Paint', 'NAT410', 8, 847, 890, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-3974 QDU FLAT BLACK 1L', 'Paint', 'NAT3974', 35, 557, 590, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-390 TTC IRON YELLOW 1L', 'Paint', 'NAT390', 16, 482, 510, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-380 TTC SUPER YELLOW 1L', 'Paint', 'NAT380', 19, 1295, 1360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-321 TTC HOSTAPERM YELLOW 1L', 'Paint', 'NAT321', 15, 1079, 1135, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-320 TTC GOLD YELLOW 1L', 'Paint', 'NAT320', 29, 540, 570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-305 TTC GREEN YELLOW 1L', 'Paint', 'NAT305', 12, 1494, 1570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-210 TTC SUPER ORANGE 1L', 'Paint', 'NAT210', 16, 1826, 1920, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-196 TTC PURPLISH RED 1L', 'Paint', 'NAT196', 13, 1577, 1660, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-192 TTC BRIGHT RED 1L', 'Paint', 'NAT192', 6, 706, 745, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-190 TTC IRON RED 1L', 'Paint', 'NAT190', 10, 465, 490, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-180 TTC STRAWBERRY RED 1L', 'Paint', 'NAT180', 10, 1030, 1085, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT158 CINQUASIA VIOLET 1L', 'Paint', 'NAT158-1L', 17, 1345, 1675, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-149 TTC DARK MAROON 1L', 'Paint', 'NAT149', 10, 1544, 1625, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-147 TTC THRENE RED 1L', 'Paint', 'NAT147', 0, 1337, 1405, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-143 TTC FLAME RED 1L', 'Paint', 'NAT143', 22, 1411, 1485, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1305 TTC 211 MICA BASE 1L', 'Paint', 'NAT1305', 23, 1743, 1835, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1304 TTC CRYSTALLINE ORANGE 1L', 'Paint', 'NAT1304', 7, 2200, 2350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1303 TTC OMEGA PEARL 1L', 'Paint', 'NAT1303', 26, 2200, 2350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1301 TTC XIRALLIC BLUE MICA 1L', 'Paint', 'NAT1301', 17, 2200, 2350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1300 TTC CRYSTALLINE SILVER 1L', 'Paint', 'NAT1300', 18, 2200, 2350, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1180 TTC OYSTER WHITE MICA 1L', 'Paint', 'NAT1180', 22, 1660, 1745, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1175 TTC MEDIUM FINE BLUE MICA 1L', 'Paint', 'NAT1175', 10, 930, 980, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1173 TTC EXTRA FINE WHITE MICA 1L', 'Paint', 'NAT1173', 8, 1719, 1810, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1172 TTC BRIGHT GREEN MICA 1L', 'Paint', 'NAT1172', 22, 1079, 1140, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1171 TTC ULTRA FINE BLUE MICA 1L', 'Paint', 'NAT1171', 28, 1055, 1115, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1167 TTC PALE GREEN MICA 1L', 'Paint', 'NAT1167', 22, 1079, 1130, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1166 TTC EARTH BROWN MICA 1L', 'Paint', 'NAT1166', 20, 1470, 1290, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1165 TTC HI-LITE RED 1L', 'Paint', 'NAT1165', 17, 972, 1030, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1164 TTC BRIGHT GOLD MICA 1L', 'Paint', 'NAT1164', 29, 830, 875, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1163 TTC FINE GREEN MICA 1L', 'Paint', 'NAT1163', 20, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1161 TTC LAVENDER MICA 1L', 'Paint', 'NAT1161', 7, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1160 TTC RED COPPER MICA 1L', 'Paint', 'NAT1160', 12, 830, 875, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1159 TTC MEDIUM RUSSET MICA 1L', 'Paint', 'NAT1159', 0, 930, 980, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1158 TTC SUPER FINE COPPER MICA 1L', 'Paint', 'NAT1158', 14, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1157 TTC BRIGHT COPPER MICA 1L', 'Paint', 'NAT1157', 18, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1153 TTC SUPER RED MICA 1L', 'Paint', 'NAT1153', 17, 913, 960, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1114 TTC GREEN MICA 1L', 'Paint', 'NAT1114', 11, 676, 878.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1113 TTC FINE BLUE MICA 1L', 'Paint', 'NAT1113', 13, 889, 950, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 4L', 'Paint', 'NAT1110-4L', 4, 2490, 2620, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1110 TTC BRIGHT WHITE 1L', 'Paint', 'NAT1110-1L', 8, 806, 850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1107 TTC FINE RED MICA 1L', 'Paint', 'NAT1107', 13, 889, 940, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1106 TTC PEARL BLUE MICA 1L', 'Paint', 'NAT1106', 6, 996, 1050, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-103 TTC OPAL 1L', 'Paint', 'NAT103', 10, 1353, 1425, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-100 TTC WHITE 4L', 'Paint', 'NAT100-4L', 0, 1810, 1905, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX NAT-1OO TTC WHITE 1L', 'Paint', 'NAT100-1L', 0, 498, 525, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 5KG', 'Paint', 'NAS-5KG', 0, 382, 496.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC GLOSS THINNER 4L', 'Paint', 'NAS535', -3, 750, 790, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACRYLIC SKIMCOAT 30KG', 'Paint', 'NAS-30KG', 0, 1671, 2172.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MAYON LACQUER THINNER 3.75L', 'Paint', 'MYNALTHNR-3.75L', 0, 512, 665.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT904 SHADOWN GREEN 1L', 'Paint', 'MT904', 7, 1743, 1850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT903 SUN GREEN 1L', 'Paint', 'MT903', 7, 1743, 1850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT902 GRASS GREEN 1L (PHASED OUT)', 'Paint', 'MT902', 0, 1455, 1891.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT901 CYANINE GREEN 1L (PHASED OUT)', 'Paint', 'MT901', 0, 1455, 1891.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT807 VACANCE BLUE 1L', 'Paint', 'MT807', 7, 1743, 1850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT806 HERMES BLUE 1L', 'Paint', 'MT806', 8, 1826, 1950, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT805 CUSTOM BLUE 1L', 'Paint', 'MT805', 8, 1826, 1950, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT804 ORIENT BLUE 1L', 'Paint', 'MT804', 5, 1826, 1950, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT803 FRESH BLUE 1L', 'Paint', 'MT803', 10, 1826, 1950, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT801 CYANINE BLUE 1L', 'Paint', 'MT801', 11, 1743, 1850, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT705 FLORA VIOLET 1L', 'Paint', 'MT705', 5, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT704 FINE VIOLET 1L', 'Paint', 'MT704', 8, 2905, 3100, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT702 CINQUASIA VIOLET 1L (PHASED OUT)', 'Paint', 'MT702', 0, 1594, 2072.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT701 FAST VIOLET 1L', 'Paint', 'MT701', 5, 1992, 2100, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT607 AUTUMN RED 1L', 'Paint', 'MT607', 6, 2158, 2280, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT606 GIRAFFE YELLOW 1L', 'Paint', 'MT606', 7, 1909, 2020, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT604 EXTRA MAROON 1L', 'Paint', 'MT604', 11, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT603 CINQUASIA BROWN 1L', 'Paint', 'MT603', 10, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT602 PEGASUS MAROON 1L', 'Paint', 'MT602', 4, 2490, 2620, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT601 IRON RED 1L', 'Paint', 'MT601', 4, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT508 INDIAN RED 1L', 'Paint', 'MT508', 5, 2573, 2750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT507 RUBY RED 1L', 'Paint', 'MT507', 4, 2905, 3060, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT506 CINQUASIA RED 1L', 'Paint', 'MT506', 10, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT505 SPARK RED 1L', 'Paint', 'MT505', 11, 2365.5, 2500, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT503 THRENE RED G 1L', 'Paint', 'MT503', 2, 2117, 2300, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT501 STRONG RED 1L', 'Paint', 'MT501', 19, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT405 SUN ORANGE 1L', 'Paint', 'MT405', 32, 3611, 3800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT401 MAXIM ORANGE 1L', 'Paint', 'MT401', 7, 2656, 2800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT307 EXTRA YELLOW 1L', 'Paint', 'MT307', 9, 2988, 3150, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT305 NATURAL YELLOW 1L', 'Paint', 'MT305', 13, 1951, 2060, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT304 GAILY YELLOW 1L', 'Paint', 'MT304', 9, 3486, 3680, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT303 FINE YELLOW 1L', 'Paint', 'MT303', 15, 2075, 2190, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT302 JEWEL YELLOW 1L', 'Paint', 'MT302', 13, 2158, 2280, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT301 MAPICO YELLOW 1L', 'Paint', 'MT301', 16, 2573, 2750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT203 DEEP BLACK 1L', 'Paint', 'MT203', 0, 1909, 2010, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK 4L', 'Paint', 'MT202-4L', 0, 3581, 4655.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT202 TINTING BLACK NP 1L', 'Paint', 'MT202-1L', 9, 1204, 1280, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT201 BLUE BLACK 1L', 'Paint', 'MT201', 20, 1162, 1230, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT175 GRAPHITE 1L', 'Paint', 'MT175', 31, 1992, 2100, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT172 OPAL COLOR 1L', 'Paint', 'MT172', 11, 3154, 3320, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT170 OPAL COLOR LS 1L', 'Paint', 'MT170', 11, 2075, 2190, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT136 METALLIC ORANGE 1L', 'Paint', 'MT136', 5, 4980, 5250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT134 METALLIC GOLD 1L', 'Paint', 'MT134', 8, 3320, 3500, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT103 WHITE LS 1L', 'Paint', 'MT103', 2, 1245, 1310, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 4L', 'Paint', 'MT100-4L', 4, 4980, 5240, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT100 WHITE HS 1L', 'Paint', 'MT100-1L', 0, 1328, 1400, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT096 MICA BASE 3M CRYSTAL SILVER 1L', 'Paint', 'MT096', 5, 5810, 6150, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT093 MICA BASE 5G BLUE GREEN 1L', 'Paint', 'MT093', 13, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT086 MICA BASE 6B MEDIUM BLUE 1L', 'Paint', 'MT086', 8, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT085 MICA BASE 4G GREEN 1L', 'Paint', 'MT085', 11, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT083 MICA BASE 4R RED 1L', 'Paint', 'MT083', 4, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT081 MICA BASE 3PK RUTILE RED 1L', 'Paint', 'MT081', 9, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT080 MICA BASE 3G FINE GREEN 1L', 'Paint', 'MT080', 12, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT079 MICA BASE 2V VIOLET 1L', 'Paint', 'MT079', 8, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT078 MICA BASE 5W BRIGHT WHITE 1L', 'Paint', 'MT078', 14, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT076 MICA BASE 4Y PLATINUM GOLD 1L', 'Paint', 'MT076', 19, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT075 MICA BASE 3Y FINE GOLD 1L', 'Paint', 'MT075', 10, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT072 MICA BASE 2W LUSTRE SATIN 1L', 'Paint', 'MT072', 12, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT071 MICA BASE 5B BLUE 1L', 'Paint', 'MT071', 12, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT 06M NEO MICA BASE 3AG GREEN 1L', 'Paint', 'MT06M', 10, 3569, 3750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06H NEO MICA BASE 3AB BLUE 1L', 'Paint', 'MT06H', 12, 3569, 3750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT06A NEO MICA BASE 3YG YELLOW 1L', 'Paint', 'MT06A', 20, 3569, 3750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT068 MICA BASE 3U RADIANT RED 1L', 'Paint', 'MT068', 0, 5976, 6300, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT067 MICA BASE 2K RED BROWN 1L', 'Paint', 'MT067', 8, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT066 MICA BASE 2R FINE RUSSET 1L', 'Paint', 'MT066', 7, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT065 MICA BASE 3B FINE BLUE 1L', 'Paint', 'MT065', 12, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT061 MICA BASE 6W FINE SATIN 1L', 'Paint', 'MT061', 4, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT051 MICA BASE 2BZ BRONZE 1L', 'Paint', 'MT051', 24, 3320, 3500, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT050 MICA BASE 2ST SCRAB RED 1L', 'Paint', 'MT050', 10, 3071, 3250, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 1L', 'Paint', 'MT033', 12, 2241, 2370, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT033 WHITE MET. MEDIUM FINE 4L (N/A)', 'Paint', 'MT033-4L', 0, 5821, 7567.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT030 WHITE MET. SNOW FINE 1L', 'Paint', 'MT030', 32, 1909, 2020, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT028 HIGH SPARKLE SUPER GLAMOUR 1L', 'Paint', 'MT028', 7, 2241, 2370, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT025 HIGH SPARKLE SUPER COARSE 1L', 'Paint', 'MT025', 7, 1909, 2020, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 1L', 'Paint', 'MT023', 9, 2075, 2200, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT023 HIGH SPARKLE FINE 4L (N/A)', 'Paint', 'MT023-4L', 0, 5820, 7566, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT012 MET. BASE FINE 1L', 'Paint', 'MT012', 21, 1909, 2020, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT008 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT008', 8, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT006 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT006', 12, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT004 CRYSTAL SILVER COARSE 1L', 'Paint', 'MT004', 12, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT003 CRYSTAL SILVER MEDIUM 1L', 'Paint', 'MT003', 7, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 4L (N/A)', 'Paint', 'MT002-4L', 0, 6058, 7875.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT002 CRYSTAL SILVER FINE 1L', 'Paint', 'MT002-1L', 2, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA MT001 CRYSTAL SILVER EXTRA FINE 1L', 'Paint', 'MT001', 19, 2241, 2360, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OLD NEWS', 'Paint', 'MSC', 0, 41, 45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE TINT BASE FLOOR COATING 5L', 'Paint', 'MPTBFC-5L', 1, 1686, 2191.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE PASTEL BASE FLOOR COATING 5L', 'Paint', 'MPPBFC-5L', 1, 1756, 2282.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE JOINT COMPOUND 5L', 'Paint', 'MPJOINTCMPND-5L', 4, 378, 491.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE DEEP BASE FLOOR COATING 5L', 'Paint', 'MPDBFC-5L', 0, 1650, 2145, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTI-PURPOSE ACCENT BASE FLOOR COATING 5L', 'Paint', 'MPABFC-5L', 1, 1616, 2100.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 4L', 'Paint', 'MEG3901-4L', 20, 950, 955, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER BLACK WITH HARDENER 1L', 'Paint', 'MEG3901-1L', 0, 182, 236.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 4L', 'Paint', 'MEG3602-4L', 0, 910, 955, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER GRAY WITH HARDENER 1L', 'Paint', 'MEG3602-1L', 0, 182, 236.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 4L', 'Paint', 'MEG3100-4L', 0, 645, 955, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER RED OXIDE WITH HARDENER 1L', 'Paint', 'MEG3100-1L', 0, 182, 236.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 4L', 'Paint', 'MEG3001-4L', 0, 910, 955, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALGUARD EPOXY PRIMER WHITE WITH HARDENER 1L', 'Paint', 'MEG3001-1L', 0, 182, 236.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON HS FILLER 1L', 'Paint', 'HS-1L', -12, 545, 575, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HRC PAINT BRUSH 2', 'Paint', 'HPB-2', 0, 19.5, 25.35, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HRC PAINT BRUSH 1', 'Paint', 'HPB-1', 0, 9.5, 12.35, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA FF151 FLIP FLAT ADJ 1L', 'Paint', 'FF151', 73, 1000, 1100, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU FINE SILVER 4L', 'Paint', 'EXTRMEFNESLVR-4L', 0, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTRA HARDENER SMALL', 'Paint', 'EXTRAHRDENER-SMALL', 0, 60.48, 78.62, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTRA HARDENER BIG', 'Paint', 'EXTRAHRDENER-BIG', 0, 206.64, 268.63, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EPOXY THINNER 4L', 'Paint', 'EPOXYTHNR-4L', 179, 480, 870, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 MAGENTA V', 'Paint', 'ECO100-V', 12, 1030, 1339, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 MEDIUM YELLOW T', 'Paint', 'ECO100-T', 11, 1160, 1508, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 RED OXIDE OR', 'Paint', 'ECO100-OR', 5, 640, 832, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 OXIDE GREEN OG', 'Paint', 'ECO100-OG', 13, 1880, 2444, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 RED LR', 'Paint', 'ECO100-LR', 11, 2260, 2938, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 WHITE KX', 'Paint', 'ECO100-KX', 12, 630, 819, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 RED HT', 'Paint', 'ECO100-HT', 11, 2100, 2730, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 RED OXIDE F', 'Paint', 'ECO100-F', 6, 610, 793, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 HS YELLOW EY', 'Paint', 'ECO100-EY', 11, 1370, 1781, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 PHTHALO BLUE E', 'Paint', 'ECO100-E', 12, 580, 754, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 PHTHALO GREEN D', 'Paint', 'ECO100-D', 7, 590, 767, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 COBALT BLUE CB', 'Paint', 'ECO100-CB', 13, 3410, 4433, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 YELLOW OXIDE C', 'Paint', 'ECO100-C', 0, 500, 650, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 BLACK B', 'Paint', 'ECO100-B', 12, 360, 468, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 ORGANIC YELLOW A 1L', 'Paint', 'ECO100-A', 10, 1100, 1430, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 800', 'Paint', 'EA800', 600, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #80', 'Paint', 'EA80', 300, 27.5, 29, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 600', 'Paint', 'EA600', 500, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #60', 'Paint', 'EA60', 400, 29.7, 32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 400', 'Paint', 'EA400', 100, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 240', 'Paint', 'EA240', 1000, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 2000', 'Paint', 'EA2000', 300, 27.5, 29, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 1500', 'Paint', 'EA1500', 500, 25.3, 28, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 1200', 'Paint', 'EA1200', 1000, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 120', 'Paint', 'EA120', 900, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 1000', 'Paint', 'EA1000', 600, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER #100', 'Paint', 'EA100', 300, 25.3, 28, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE WHITE 4L', 'Paint', 'DVQDW-4L', 0, 779, 1012.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR VENETIAN RED 1/4L', 'Paint', 'DVOTCVNRED-1/4L', 8, 90, 117, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR THALO GREEN 1/4L', 'Paint', 'DVOTCTHGRN-1/4L', 0, 90, 117, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR THALO BLUE 1/4L', 'Paint', 'DVOTCTHBLU-1/4L', 0, 90, 117, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR RAW SIENNA 1/4L', 'Paint', 'DVOTCRWSNA-1/4L', 1, 79, 102.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR HANZA YELLOW 1/4L', 'Paint', 'DVOTCHNZYLW-1/4L', 0, 97, 126.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BURNT SIENNA 1/4L', 'Paint', 'DVOTCBSNA-1/4L', 16, 87, 113.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BULLETIN RED 1/4L', 'Paint', 'DVOTCBLTNRD-1/4L', 4, 96, 124.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES OIL TINTING COLOR BLACK 1/4L', 'Paint', 'DVOTCBLK-1/4L', 2, 80, 104, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LTC THALO BLUE 1L', 'Paint', 'DVLTCTHBLU-1L', 0, 106, 137.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 4', 'Paint', 'DPB-4', 72, 93.33, 121.33, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 3/4', 'Paint', 'DPB-3/4', 0, 12, 15.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #3', 'Paint', 'DPB-3', 0, 52, 67.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #2', 'Paint', 'DPB-2', 0, 26.4, 34.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH 1/2', 'Paint', 'DPB-1/2', 0, 9.33, 12.13, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH # 1 1/2', 'Paint', 'DPB-1 1/2', 0, 17.6, 22.88, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY PAINT BRUSH #1', 'Paint', 'DPB-1', 0, 15, 19.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO QDE LEMON YELLOW 4L', 'Paint', 'DOMQDLY-4L', 0, 580, 754, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO QDE ALUMINUM 4L', 'Paint', 'DOMQDAL-4L', 0, 700, 910, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 4L', 'Paint', 'DOMBF-4L', 334, 514.05, 570, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO BODY FILLER WITH HARDENER 1L', 'Paint', 'DOMBF-1L', 420, 154.56, 180, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE THINNER 4L', 'Paint', 'DOITTH-4L', 0, 548, 712.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT SHIELD ALL MULTI-PURPOSE WAX 250ML', 'Paint', 'DOITSHLDALL-BOT', 144, 131.25, 170.63, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DELIVERY CHARGE', 'Paint', 'DELCHRGE', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 5L', 'Paint', 'DCTBSG-5L', 8, 934, 1214.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 1L', 'Paint', 'DCTBSG-1L', 12, 224, 291.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC TINT BASE SEMI-GLOSS 15L', 'Paint', 'DCTBSG-15L', 3, 2661, 3459.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 5L', 'Paint', 'DCSG715-5L', 0, 788, 1024.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG 715 WHITE 1L', 'Paint', 'DCSG715-1L', 0, 245, 318.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG WHITE 715 15L', 'Paint', 'DCSG715-15L', 0, 2555.38, 3321.99, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 5L', 'Paint', 'DCPBSG-5L', 20, 972, 1263.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 1L', 'Paint', 'DCPBSG-1L', 10, 234, 304.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC PASTEL BASE SEMI-GLOSS 15L', 'Paint', 'DCPBSG-15L', 0, 2773, 3604.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 5L', 'Paint', 'DCF701-5L', 0, 625, 812.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 1L', 'Paint', 'DCF701-1L', 0, 154, 200.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC FLAT WHITE 701 15L', 'Paint', 'DCF701-15L', 0, 2199, 2858.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 5L', 'Paint', 'DCDBSG-5L', 12, 914, 1188.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 1L', 'Paint', 'DCDBSG-1L', 0, 219, 284.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC DEEP BASE SEMI-GLOSS 15L', 'Paint', 'DCDBSG-15L', 7, 2606, 3387.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 5L', 'Paint', 'DCABSG-5L', 37, 895, 1163.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 1L', 'Paint', 'DCABSG-1L', 0, 215, 279.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC ACCENT BASE SEMI-GLOSS 15L', 'Paint', 'DCABSG-15L', 4, 2551, 3316.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DEEP BASE MATEX CC 5L', 'Paint', 'DBM-5L', 12, 670, 871, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DEEP BASE MATEX CC 1L', 'Paint', 'DBM-1L', 6, 176, 228.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DEEP BASE MATEX CC 15L', 'Paint', 'DBM-15L', 4, 1912, 2485.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 3/4 18MM (1X64)', 'Paint', 'CRO-MT3/4', 18, 1451.8, 1550, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 2 48MM (1X24)', 'Paint', 'CRO-MT2', 2, 1448.4, 1550, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/2 12MM (1X96)', 'Paint', 'CRO-MT1/2', 25, 1451.8, 1550, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 1 24MM (1X48)', 'Paint', 'CRO-MT1', 22, 1448.4, 1550, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN QDE WHITE 4L', 'Paint', 'BSQDWHT-4L', 0, 794, 1032.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN PLEXIBOND 4L', 'Paint', 'BSPLXIBND-4L', 0, 785, 1020.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN LATEX GLOSS WHITE 4L', 'Paint', 'BSLXGLWH-4L', 0, 763, 991.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK ULTRAFINO SKIMCOAT WHITE 20KG', 'Paint', 'BSKSKMCOAT-BAG', 0, 450, 585, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN FLATWALL ENAMEL WHITE 4L', 'Paint', 'BSFWE-4L', 0, 740, 962, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX REDUCER 4L', 'Paint', 'BSAXREDUCR-4L', 0, 464, 603.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX PRIMER WHITE 4L', 'Paint', 'BSAXPRWHT-4L', 0, 970, 1261, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BRILL RUBBING COMPOUND 1KG', 'Paint', 'BRC-1KG', 0, 900, 1170, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DRAGONFLY MINI BABY ROLLER #4 W/H', 'Paint', 'BBR-MINI', 0, 25, 32.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE WHITE 4L', 'Paint', 'AGUTWH-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE SPARKLE IRID 4L', 'Paint', 'AGUTSPKLEIRID-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE PERMANENT MAROON 4L', 'Paint', 'AGUTPRMRN-4L', 0, 2700, 3510, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE METALLIC COARSE 4L', 'Paint', 'AGUTMETCRSE-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE INTERNATIONAL RED 4L', 'Paint', 'AGUTINTRED-4L', 0, 2200, 2860, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE GOLD TONER 4L', 'Paint', 'AGUTGLDTNR-4L', 0, 2200, 2860, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE FERRARI RED 4L', 'Paint', 'AGUTFERRED-4L', 0, 2200, 2860, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE CYANINE GREEN 4L', 'Paint', 'AGUTCYGRN-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE CYANINE BLUE 4L', 'Paint', 'AGUTCYBLU-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE CHROME YELLOW 4L', 'Paint', 'AGUTCHRMYL-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE BLACK 4L', 'Paint', 'AGUTBLK-4L', 0, 2000, 2600, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AEROGLOSS URETHANE HARDENER 1/4L', 'Paint', 'AGCAT-1/4L', 0, 180, 234, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACCENT BASE MATEX CC 5L', 'Paint', 'ABM-5L', 24, 659, 856.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACCENT BASE MATEX CC 1L', 'Paint', 'ABM-1L', 7, 174, 226.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ACCENT BASE MATEX CC 15L', 'Paint', 'ABM-15L', 5, 1877, 2440.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG SMOKING GRAY 2045T 5L', 'Paint', '2045T-5L', 0, 1050, 1365, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG ABACADABRA 2034P 5L', 'Paint', '2034P-5L', 0, 1000, 1300, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON DOU CLASSIC SG GRAY SUIT 2027P 5L', 'Paint', '2027P-5L', 0, 1050, 1365, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE BLACK 4L', 'Paint', 'DOITBLACK-4L', 12, 2100, 2730, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE WHITE 4L', 'Paint', 'DOITWHITE-4L', 6, 1475.33, 1917.93, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('XPERTO ACRYLIC THINNER 4L', 'Paint', 'XPRTOACTHNR-4L', 0, 456, 592.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #36', 'Paint', 'CUMISPRME-FS36', 0, 7907, 10279.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #60', 'Paint', 'CUMISPREME-FS60', 1, 6388.2, 8304.66, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #80', 'Paint', 'CUMISPREME-FS80', 3, 7434, 9664.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SUPREME FLOOR SANDING #100', 'Paint', 'CUMISPREME-FS100', 4, 5575.48, 7248.12, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GI PAINT REMOVER BOT', 'Paint', 'GIPNTRMOVR-BOT', 0, 99, 128.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON FLATTENING PASTE 1L', 'Paint', 'NFP-1L', 12, 650, 750, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE HIGH GLOSS ACCENT BASE 1L', 'Paint', 'PLTHGAB-1L', 16, 274, 356.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 1L', 'Paint', 'NPCGV-1L', 108, 427, 555.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON CLEAR GLOSS VARNISH 4L', 'Paint', 'NPCGV-5L', 42, 1390, 1807, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE 1L', 'Paint', 'MTLPRRO-1L', 0, 140, 182, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON METAL PRIMER RED OXIDE 4L', 'Paint', 'MTLPRRO-4L', 4, 490, 637, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE HIGH GLOSS PASTEL BASE 1L', 'Paint', 'PLTHGPB-1L', 20, 298, 387.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU MAROON 4L', 'Paint', 'NXU4168-4L', 12, 1910, 2010, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU CINQUASIA VIOLET 4L', 'Paint', 'NXU4184-4L', 6, 1710, 1800, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE HIGH GLOSS TINT BASE 1L', 'Paint', 'PLTHGTB-1L', 20, 286, 371.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLATONE HIGH GLOSS DEEP BASE 1L', 'Paint', 'PLTHGDB-1L', 20, 280, 364, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EXTREME QDU MAGENTA 4L', 'Paint', 'NXU4197-4L', 6, 1910, 2010, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LTC HANZA YELLOW 1L', 'Paint', 'DVLTCHNYL-1L', 0, 145, 188.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE SG WHITE 4L', 'Paint', 'DVLIQSG-4L', 0, 1043, 1355.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE REDUCER 4L', 'Paint', 'DVLIQRDCR-4L', 0, 464, 603.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 4L', 'Paint', 'DVLQPR-4L', 0, 985, 1280.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE PRIMER WHITE 16L', 'Paint', 'DVLIQPRWHT-16L', 0, 3865, 5024.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE GLOSS WHITE 4L', 'Paint', 'DVLIQWHTE-4L', 0, 1043, 1355.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE FLAT WHITE 4L', 'Paint', 'DVLIQFLT-4L', 0, 990, 1287, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR VENETIAN RED 1L', 'Paint', 'DVLTCVNRD-1L', 0, 111, 144.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR TOLOUDINE RED 1L', 'Paint', 'DVLTCTLRED-1L', 0, 111, 144.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR THALO GREEN 1L', 'Paint', 'DVLTCTHGRN-1L', 0, 106, 137.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR RAW SIENNA 1L', 'Paint', 'DVLTCRWSNA-1L', 0, 118, 153.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LATEX TINTING COLOR BLACK 1L', 'Paint', 'DVLTCBLK-1L', 0, 87, 113.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LACQUER PUTTY WHITE 4L', 'Paint', 'DVLACPTW-4L', 0, 756, 982.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LACQUER PRIMER WHITE 4L', 'Paint', 'DVLACPRW-4L', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS RUBBERIZED BLACK 4L', 'Paint', 'TXSRUB-4L', 0, 433, 562.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 4L', 'Paint', 'ELKAP-4L', 0, 1998, 2597.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK EL KAPITAN MARINE EPOXY A&B 1L', 'Paint', 'ELKAP-1L', 0, 542.7, 705.51, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK VULCASEAL JR (24X1)', 'Paint', 'VULCASL-JR', 0, 58.05, 75.47, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOSTIK RUGBY ORIGINAL 300ML (24X1)', 'Paint', 'BSTKRGBY-300ML', 0, 61.2, 79.56, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CANCELLED INVOICE', 'Paint', 'CANCELLED', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 320', 'Paint', 'EA320', 100, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #2', 'Paint', '2BPB-2', 0, 366.4, 476.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DO IT URETHANE CATALYST CAN', 'Paint', 'DOIT-CAT', 36, 225.82, 293.57, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B BABY ROLLER COTTON WITH HANDLE 4"', 'Paint', '2BBBRLR 4"', 0, 28, 36.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLANELLA', 'Paint', 'FLANEL', 0, 64, 83.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER WHITE 4L', 'Paint', 'DOMLCQWHTE-4L', 20, 760, 988, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER BLACK 4L', 'Paint', 'DOMLCQBLK-4L', 60, 760, 988, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER LEMON YELLOW 4L', 'Paint', 'DOMLCQLY-4L', 16, 1016, 1320.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER MOLYBDATE ORANGE 4L', 'Paint', 'DOMLCQMO-4L', 8, 894.4, 1162.72, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER THALO BLUE 4L', 'Paint', 'DOMLCQTHBL-4L', 12, 879.2, 1142.96, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER THALO GREEN 4L', 'Paint', 'DOMLCQTHGR-4L', 4, 879.2, 1142.96, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER INTERNATIONAL RED 4L', 'Paint', 'DOMLCQINTRD-4L', 12, 896, 1164.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER CATERPILLAR YELLOW 4L', 'Paint', 'DOMLCQCATYLW-4L', 0, 812.8, 1056.64, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'PINEPENTHBLU-4L', 0, 991.44, 1288.87, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'PINEPENTHGR-4L', 0, 991.44, 1288.87, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'PINEPENLY-4L', 60, 1056.24, 1373.11, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL INTERNATIONAL RED W/H 4L', 'Paint', 'PINEPENINTRD-4L', 16, 1056.24, 1373.11, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL ORANGE W/H 4L', 'Paint', 'PINEPENORNGE-4L', 0, 959.76, 1247.69, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PINNACLE EPOXY ENAMEL CLEAR W/H 4L', 'Paint', 'PINEPENCLR-4L', 18, 924.48, 1201.82, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC PRIMER GRAY 4L', 'Paint', 'TOACPG-4L', 12, 876.9, 1139.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC MOLYBDATE ORANGE 4L', 'Paint', 'TOACMORNGE-4L', 12, 922.78, 1199.61, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC METALLIC FINE 4L', 'Paint', 'TOACMETFNE-4L', 20, 1033.78, 1343.91, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC METALLIC COARSE 4L', 'Paint', 'TOACMETCRSE-4L', 20, 1033.78, 1343.91, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC LEMON YELLOW 4L', 'Paint', 'TOACLMNYLW-4L', 32, 942.76, 1225.59, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'USAEPENWHT-4L', 0, 985, 1280.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PYLOX LAZER GRAY 45', 'Paint', 'PYLZGRY-45', 36, 79.863168, 103.82, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES GLOSS LATEX WHITE 4L', 'Paint', 'DVGLW-4L', 0, 757, 984.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMELESS RUBBING COMPOUND 630GRMS', 'Paint', 'TLRUBCMP-CAN', 27, 373.1, 485.03, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMELESS LIQUID WAX 50ML', 'Paint', 'TLLQWX-50ML', 200, 44.8, 65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER PRIMER WHITE 4L', 'Paint', 'DOMLCQPRWHT-4L', 0, 726.4, 944.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER PUTTY WHITE 4L', 'Paint', 'DOMLCQPUTYWH-4L', 28, 778.4, 1011.92, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER METALLIC FINE 4L', 'Paint', 'DOMLCQMETFNE-4L', 24, 826.4, 1074.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER METALLIC COARSE 4L', 'Paint', 'DOMLCQMETCRSE-4L', 28, 826.4, 1074.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DOMINO AUTO LACQUER GOLD TONER 4L', 'Paint', 'DOMLCQGLDTNR-4L', 12, 868, 1128.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC INTERNATIONAL RED 4L', 'Paint', 'TOACINTRD-4L', 2, 1186.96, 1543.05, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC GOLD TONER 4L', 'Paint', 'TOACGLDTNR-4L', 12, 1320.16, 1716.21, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC FIRE RED 4L', 'Paint', 'TOACFRED-4L', 15, 1186.96, 1543.05, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMEOUT ACRYLIC BLACK 4L', 'Paint', 'TOACB-4L', 0, 831.76, 1081.29, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TIMELESS RUBBING COMPOUND SACHET', 'Paint', 'TLRUBCMP-SACHET', 50, 37.8, 65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON EPOXY PRIMER WHITE W/H 4L', 'Paint', 'NPEPPRWHT-4L', 0, 830, 1079, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ULTRA 8100T FD 2K CLEAR 1L', 'Paint', 'NP8100T-1L', 218, 1355, 1425, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON PREMIUM HS CLEAR W/H 1L', 'Paint', 'HSCLR-1L', 72, 625, 660, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ULTIMA P/S WHITE W/H 4L', 'Paint', 'NPULTIMA-4L', 0, 1300, 1690, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ULTIMA ISUZU TRAVIS WHITE 4L', 'Paint', 'NPULTIMATRVISWHT-4L', 0, 1600, 2080, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ULTIMA BASECOAT HARDENER 1L', 'Paint', 'NPULTIMA-HARD 1L', 0, 600, 780, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT ROLLER #7 W/HANDLE', 'Paint', '2BPTRL-7', 200, 58.5, 65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ECO 100 R ORGANIC RED 1L', 'Paint', 'ECO100-R', 12, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CROCO MASKING TAPE 1/4', 'Paint', 'CROMT-1/4', 0, 1448.4, 1882.92, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EAGLE SANDPAPER 220', 'Paint', 'EA220', 300, 20.35, 22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #1', 'Paint', '2BPB-1', 0, 168, 218.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #1 1/2', 'Paint', '2BPB-1 1/2', 10, 246.4, 320.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #2 1/2', 'Paint', '2BPB-2 1/2', 0, 432, 561.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PREMILA FF155 FLIP FLOP CONTROLLER', 'Paint', 'FF155', 0, 885, 1150.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES FLAT LATEX WHITE 4L', 'Paint', 'DVFLW-4L', 0, 607, 789.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN LTC BLACK 1L', 'Paint', 'BSLTCBLK-1L', 0, 87, 113.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU FLAT BLACK 4L', 'Paint', 'PGFLTBLK-4L', 0, 1820.7, 2366.91, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU LIGHT YELLOW 4L', 'Paint', 'PGLTYLW-4L', 7, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW GOLD 4L', 'Paint', 'PGYLGLD-4L', 15, 2283.1, 2968.03, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU YELLOW OXIDE 4L', 'Paint', 'PGYLOXDE-4L', 17, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MOLY ORANGE 4L', 'Paint', 'PGMLYORNGE-4L', 10, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU BON RED 4L', 'Paint', 'PGBNRED-4L', 12, 1965.2, 2554.76, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU 888 RED 4L', 'Paint', 'PG888RED-4L', 0, 2309.45, 3002.28, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU RED GOLD 4L', 'Paint', 'PGRDGLD-4L', 5, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PERMANENT MAROON 4L', 'Paint', 'PGPRMRN-4L', 8, 2312, 3005.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MAROON TONER 4L', 'Paint', 'PGMRNTNR-4L', 5, 1987.3, 2583.49, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU THALO BLUE 4L', 'Paint', 'PGTHBLU-4L', 0, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU THALO GREEN 4L', 'Paint', 'PGTHGRN-4L', 9, 1776.5, 2309.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC FINE 4L', 'Paint', 'PGMETFNE-4L', 0, 1642.2, 2134.86, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU BRIGHT ALUMINUM 4L', 'Paint', 'PGBRTALUM-4L', 8, 1796.05, 2334.87, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU METALLIC COARSE 4L', 'Paint', 'PGMETCRSE-4L', 0, 1642.2, 2134.86, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU APPLE RED 4L', 'Paint', 'PGAPLRED-4L', 0, 2291.6, 2979.08, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU SPARKLE IRID 4L', 'Paint', 'PGSPRKLIRD-4L', 0, 1642.2, 2134.86, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST WHITE 4L', 'Paint', 'PGGLEMSTWHT-4L', 7, 3003.05, 3903.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST YELLOW 4L', 'Paint', 'PGGLEMSTYLW-4L', 4, 3003.05, 3903.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST ORANGE 4L', 'Paint', 'PGGLEMSTORNGE-4L', 8, 3003.05, 3903.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST COPPER 4L', 'Paint', 'PGGLEMSTCPR-4L', 0, 3544.5, 4607.85, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST RED 4L', 'Paint', 'PGGLEMSTRED-4L', 11, 3003.05, 3903.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU GLEAMIST MAROON 4L', 'Paint', 'PGGLEMSTMRN-4L', 8, 3003.05, 3903.97, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PEARL WHITE 4L', 'Paint', 'PGPRLWHT-4L', 12, 2900.2, 3770.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED YELLOW 4L', 'Paint', 'PGPRLFRSTDYL-4L', 5, 2900.2, 3770.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED ORANGE 4L', 'Paint', 'PGPRLFRSTDORNGE-4L', 0, 2900.2, 3770.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED RED 4L', 'Paint', 'PGPRLFRSTDRD-4L', 4, 2900.2, 3770.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU PEARL FROSTED GREEN 4L', 'Paint', 'PGPRLFRSTDGRN-4L', 12, 2900.2, 3770.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED FINE 4L', 'Paint', 'PGMICARDFNE-4L', 13, 2660.5, 3458.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU MICA RED COARSE 4L', 'Paint', 'PGMICARDCRSE-4L', 14, 2660.5, 3458.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU WHITE 4L', 'Paint', 'PGPUWHT-4L', 0, 1632, 2121.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU JET BLACK 4L', 'Paint', 'PGPUJTBLK-4L', 0, 1722.95, 2239.84, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN AND RAIN TASTY TAN 4L', 'Paint', 'SR-913', 0, 698, 907.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES EPOXY ENAMEL TOPCOAT WHITE W/H 4L', 'Paint', 'DVEPENWHT-4L', 0, 1236, 1606.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES EPOXY ENAMEL TOPCOAT LEMON YELLOW W/H 4L', 'Paint', 'DVEPENLY-4L', 0, 1327, 1725.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES EPO PATCH SET 4L', 'Paint', 'DVEPOPTCH-4L', 6, 2655, 3451.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES ALUMINUM SILVER FINISH 4L', 'Paint', 'DVSLVRALUM-4L', 0, 695, 903.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER EPOXY PRIMER RED OXIDE 4L', 'Paint', 'WBREPRO-4L', 0, 705, 916.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2B PAINT BRUSH #3', 'Paint', '2BPB-3', 8, 726.4, 944.32, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX CAST 4L', 'Paint', 'BSAXCAST-4L', 0, 516, 670.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN ACRYTEX GLOSS WHITE 4L', 'Paint', 'BSAXGLWHT-4L', 0, 1043, 1355.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN FLAT LATEX BLACK 4L', 'Paint', 'BSFLLXBL-4L', 0, 583, 757.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE TINTING VENETIAN RED 1L', 'Paint', 'DVLIQVENRED-1L', 0, 380, 494, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LIQUID TILE TINTING BLACK 1L', 'Paint', 'DVLIQBLK-1L', 0, 380, 494, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES POWER FLOOR VELVET GRAY W/H', 'Paint', 'DVPFVLGRY-4L', 0, 2422, 3148.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PIONEER NON-SAG MARINE EPOXY A&B', 'Paint', 'NONSAG-4L', 2, 2564.32, 3333.62, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU VIOLET TONER 4L', 'Paint', 'PGVIOTNR-4L', 10, 2291.6, 2979.08, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS ZINC-PRIMER BASED GREEN W/CAT 1L', 'Paint', 'PGZNCPR-1L', 45, 520, 560, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-938 MARGIE 4L', 'Paint', 'RSM-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER SPRAY GUN F-75 GRAVITY TYPE', 'Paint', 'WBRSPGUN-F75', 0, 576, 748.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'GLEPENTHGRN-4L', 8, 1094.8, 1423.24, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 4L', 'Paint', 'ALPGLLXWHT-4L', 0, 654.31, 850.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 4L', 'Paint', 'ALPSGLXWHT-4L', 0, 654.31, 850.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 16L', 'Paint', 'ALPSGLXWHT-16L', 0, 2608.23, 3390.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES FLAT LATEX WHITE 16L', 'Paint', 'DVFLLXWHT-16L', 0, 2413, 3136.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE BLACK 4L', 'Paint', 'DVQDBLK-4L', 0, 592, 769.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC BURNT UMBER 1/4L', 'Paint', 'ALPOTCBUMBR-1/4L', 24, 79.42, 103.25, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LACQUER FLO 4L', 'Paint', 'DVALFLO-4L', 0, 732, 951.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1L', 'Paint', 'ALPLTCRWSIENA-LTR', 0, 102.89, 133.76, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC VENETIAN RED 1/4L', 'Paint', 'ALPOTCVENRD-CAN', 44, 80.77, 105, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA QDE WHITE 4L', 'Paint', 'ALPQDWHT-4L', 0, 726.51, 944.46, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA QDE BLACK 4L', 'Paint', 'ALPQDBLK-4L', 0, 550.53, 715.69, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CALIFORNIA ORANGE 4L', 'Paint', 'WCQDCALORNGE-4L', 9, 884.45, 1149.79, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA QDE WHITE 1L', 'Paint', 'ALPQDWHT-1L', 24, 194.94, 253.42, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL CATERPILLAR YELLOW W/H 4L', 'Paint', 'GLEPENCATYLW-4L', 4, 1136.65, 1477.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES SG LATEX WHITE 4L', 'Paint', 'DVSGLXWHT-4L', 0, 701, 911.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OMEGA CUP BRUSH 3INXM10X1.50MM TWISTED WHITE', 'Paint', 'CUPBRSH', 4, 112, 145.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER UNDERCOATING SPRAY GUN 616A', 'Paint', 'UNDRCOATGUN', 15, 576, 748.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OMEGA DOUBLE SIDED WOOL BUFFING PAD 8IN', 'Paint', 'BUFFPAD', 55, 580, 754, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES LACQUER THINNER 4L', 'Paint', 'DLT-4L', 0, 496, 644.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN FLAT LATEX WHITE 4L', 'Paint', 'BSFLXWHT-4L', 0, 630, 819, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 4L', 'Paint', 'WCQDWHT-4L', 0, 672.36, 874.07, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE WHITE 1L', 'Paint', 'WCQDWHT-1L', 0, 181.4, 235.82, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 4L', 'Paint', 'WCQDBLK-4L', 0, 613.7, 797.81, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE BLACK 1L', 'Paint', 'WCQDBLK-1L', 12, 151.62, 197.11, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 4L', 'Paint', 'WCQDCB-4L', 16, 559.55, 727.41, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CHOCOLATE BROWN 1L', 'Paint', 'WCQDCB-1L', 12, 151.62, 197.11, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 4L', 'Paint', 'WCFLXWHT-4L', 0, 440.42, 572.55, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR FLAT LATEX WHITE 1L', 'Paint', 'WCFLXWHT-1L', 0, 119.13, 154.87, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 1L', 'Paint', 'WCSGLXWHT-1L', 0, 140.79, 183.03, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 1L', 'Paint', 'WCGLXWHT-1L', 36, 140.79, 183.03, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 4L', 'Paint', 'WCFWE-4L', 24, 626.34, 814.24, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR FLATWALL ENAMEL WHITE 1L', 'Paint', 'WCFWE-1L', 0, 169.67, 220.57, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 4L', 'Paint', 'WCMPRO-4L', 4, 413.35, 537.36, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR METAL PRIMER RED OXIDE 1L', 'Paint', 'WCMPRO-1L', 0, 114.17, 148.42, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 4L', 'Paint', 'ALPFLXWHT-4L', 14, 568.58, 739.15, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 1L', 'Paint', 'ALPFLXWHT-1L', 0, 152.52, 198.28, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA FLAT LATEX WHITE 16L', 'Paint', 'ALPFLXWHT-16L', 0, 2265.28, 2944.86, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA SG LATEX WHITE 1L', 'Paint', 'ALPSGLXWHT-1L', 0, 173.28, 225.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 1L', 'Paint', 'ALPGLXWHT-1L', 0, 173.28, 225.26, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA GLOSS LATEX WHITE 16L', 'Paint', 'ALPGLXWHT-16L', 0, 2608.23, 2775, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1L', 'Paint', 'ALPLTCBLK-1L', 0, 79.42, 103.25, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1/4L', 'Paint', 'ALPLTCBLK-1/4L', 45, 27.98, 36.37, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1L', 'Paint', 'ALPLTCBS-1L', 12, 105.59, 137.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT SIENNA 1/4L', 'Paint', 'ALPLTCBS-1/4L', 24, 37, 48.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1L', 'Paint', 'ALPLTCBU-1L', 24, 105.59, 137.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BURNT UMBER 1/4L', 'Paint', 'ALPLTCBU-1/4L', 24, 37, 48.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1L', 'Paint', 'ALPLTCHY-1L', 0, 132.67, 172.47, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC HANZA YELLOW 1/4L', 'Paint', 'ALPLTCHY-1/4L', 0, 46.48, 60.42, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1L', 'Paint', 'ALPLTCTB-1L', 10, 105.59, 137.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO BLUE 1/4L', 'Paint', 'ALPLTCTB-1/4L', 18, 37, 48.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1L', 'Paint', 'ALPLTCTG-1L', 12, 105.59, 137.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC THALO GREEN 1/4L', 'Paint', 'ALPLTCTG-1/4L', 24, 37, 48.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE CAST 4L', 'Paint', 'ALPATC-4L', 0, 550.53, 715.69, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE PRIMER WHITE 4L', 'Paint', 'ALPATPW-4L', 0, 870.91, 1132.18, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE FLAT WHITE 4L', 'Paint', 'ALPATFLWHT-4L', 12, 888.96, 1155.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE SG WHITE 4L', 'Paint', 'ALPATSGWHT-4L', 4, 929.58, 1208.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE GLOSS WHITE 4L', 'Paint', 'ALPATGLWHT-4L', 0, 929.58, 1208.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ACRYTILE REDUCER 4L', 'Paint', 'ALPATR-4L', 0, 500, 650, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR SEALER W/CATALYST 4L', 'Paint', 'ALPPUSLR-4L', 20, 1064.95, 1384.44, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE FLOOR TOPCOAT W/CATALYST 4L', 'Paint', 'ALPPUTC-4L', 20, 1344.73, 1748.15, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE REDUCER 4L', 'Paint', 'ALPPUR-4L', 6, 694.93, 903.41, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA TEXTURED COATING LOW PROFILE FLAT WHITE 4L', 'Paint', 'LOPROF-4L', 8, 654.31, 850.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA TEXTURED COATING HI PROFILE FLAT WHITE 4L', 'Paint', 'HIPROF-4L', 8, 622.73, 809.55, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW SIENNA 1/4L', 'Paint', 'ALPLTCRS-1/4L', 24, 36.1, 46.93, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC RAW UMBER 1L', 'Paint', 'ALPLTCRU-1L', 0, 105.59, 137.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC TOLUIDINE RED 1L', 'Paint', 'ALPLTCTR-1L', 12, 100.18, 130.23, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1L', 'Paint', 'ALPLTCVR-1L', 12, 99.28, 129.06, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC VENETIAN RED 1/4L', 'Paint', 'ALPLTCVR-1/4L', 24, 34.75, 45.18, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC BULLETIN RED 1/4L', 'Paint', 'ALPOTCBR-1/4L', 36, 87.54, 113.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC BURNT SIENNA 1/4L', 'Paint', 'ALPOTCBS-1/4L', 39, 76.71, 99.72, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC FRENCH YELLOW OCHRE 1/4L', 'Paint', 'ALPOTCFYO-1/4L', 12, 77.62, 100.91, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC HANZA YELLOW 1/4L', 'Paint', 'ALPOTCHY-1/4L', 36, 91.15, 118.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC LAMP BLACK 1/4L', 'Paint', 'ALPOTCLB-1/4L', 24, 71.3, 92.69, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC THALO BLUE 1/4L', 'Paint', 'ALPOTCTB-1/4L', 24, 80.77, 105, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC THALO GREEN 1/4L', 'Paint', 'ALPOTCTG-1/4L', 32, 80.77, 105, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW SIENNA 1/4L', 'Paint', 'ALPOTCRS-1/4L', 24, 77.62, 100.91, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA OTC RAW UMBER 1/4L', 'Paint', 'ALPOTCRU-1/4L', 36, 72.2, 93.86, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-933 COOL MINT 4L', 'Paint', 'RSCM-4L', 8, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-888 LUCKY ORANGE 4L', 'Paint', 'RSLO-4L', 16, 1308.63, 1701.22, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-862 IVORY 4L', 'Paint', 'RSI-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-829 FRESHMINT 4L', 'Paint', 'RSFM-4L', 4, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-818 CHINA WHITE 4L', 'Paint', 'RSCW-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-739 COCONUT 4L', 'Paint', 'RSCNT-4L', 24, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-723 BLUE OCEAN 4L', 'Paint', 'RSBO-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-701 BAGUIO GREEN 4L', 'Paint', 'RSBG-4L', 20, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-678 GOLDEN BUTTER 4L', 'Paint', 'RSGB-4L', 20, 690.41, 897.53, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-633 CHOCOLATE BROWN 4L', 'Paint', 'RSCB-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-629 TULIPS 4L', 'Paint', 'RSTLPS-4L', 12, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-618 HAPPY DAYS 4L', 'Paint', 'RSHD-4L', 16, 631.75, 740, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-559 BRIDAL GOWN 4L', 'Paint', 'RSBGWN-4L', 20, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-538 SAFARI BROWN 4L', 'Paint', 'RSSB-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-530 GENTLE TOUCH 4L', 'Paint', 'RSGT-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-518 TEMPTATION 4L', 'Paint', 'RST-4L', 1, 735.54, 890, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-513 CITRUS 4L', 'Paint', 'RSC-4L', 20, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-381 SERENITY 4L', 'Paint', 'RSS-4L', 20, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-368 MY WAY 4L', 'Paint', 'RSMW-4L', 4, 690.41, 730, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-367 CANDY TUFT 4L', 'Paint', 'RSCT-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-313 IRVINE PEACH 4L', 'Paint', 'RSIP-4L', 20, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-298 OH SO RED 4L', 'Paint', 'RSOSR-4L', 16, 812.25, 1055.92, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-223 NICOLE PINK 4L', 'Paint', 'RSNP-4L', 14, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-175 ROMANCE 4L', 'Paint', 'RSR-4L', 12, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-171 TOUCH OF GRAY 4L', 'Paint', 'RSTOG-4L', 4, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-115 STONE GRAY 4L', 'Paint', 'RSSG-4L', 8, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-109 TULLE WHITE 4L', 'Paint', 'RSTW-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-101 TERRA COTTA 4L', 'Paint', 'RSTC-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-100 WHITE 4L', 'Paint', 'RSW-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE PREPA WHITE 4L', 'Paint', 'PREPA-WHITE', 0, 518.94, 674.62, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA LTC BLACK 1L (DOUBLE ENTRY)', 'Paint', 'ALPLTCB-1L', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5615 WHITE 4L', 'Paint', 'GLAEWHT-4L', 0, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5695 METALLIC FINE 4L', 'Paint', 'GLAEMF-4L', 8, 772.55, 1004.31, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5696 METALLIC COURSE 4L', 'Paint', 'GLAEMC-4L', 8, 772.55, 1004.31, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5665 THALO BLUE 4L', 'Paint', 'GLAETB-4L', 8, 772.55, 1004.31, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5655 THALO GREEN 4L', 'Paint', 'GLAETG-4L', 8, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5632 MOLY ORANGE 4L', 'Paint', 'GLAEMO-4L', 0, 837, 1088.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5642 INTERNATIONAL RED 4L', 'Paint', 'GLAEIR-4L', 4, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5645 FIRE RED 4L', 'Paint', 'GLAEFR-4L', 4, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5623 LEMON YELLOW 4L', 'Paint', 'GLAELY-4L', 0, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5625 CATERPILLAR YELLOW 4L', 'Paint', 'GLAECY-4L', 12, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5690 BLACK 4L', 'Paint', 'GLAEBLK-4L', 0, 708.1, 920.53, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5699 FLAT BLACK 4L', 'Paint', 'GLAEFB-4L', 4, 772.55, 1004.31, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER AUTO ENAMEL 5648 MAROON 4L', 'Paint', 'GLAEMRN-4L', 8, 793.48, 1031.52, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN EPOXY ENAMEL WHITE W/H 4L', 'Paint', 'BSEPENWHT-4L', 0, 1274, 1656.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 4L', 'Paint', 'USAEPRO-4L', 0, 590, 767, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'USAEPENTB-4L', 0, 898, 1167.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUMI SANDMASTER FLOOR SANDING #36 (50MTR)', 'Paint', 'SNDMSTER-36', 1, 9590, 12467, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERLO SILTEX 800 PREMIUM HS STONECHIP BLACK 1L', 'Paint', 'ROBSLTX', 0, 455, 591.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR SG LATEX WHITE 4L', 'Paint', 'WCSGLXWHT-4L', 0, 521.65, 678.14, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR GLOSS LATEX WHITE 4L', 'Paint', 'WCGLXWHT-4L', 0, 521.65, 678.14, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN AND RAIN CHOCOLATE BROWN 4L', 'Paint', 'SRCB-4L', 0, 698, 907.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN AND RAIN TULLE WHITE 4L', 'Paint', 'SRTW-4L', 0, 698, 907.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BUILDSMART SKIMCOAT SF WHITE 20KG', 'Paint', 'BSKW', 0, 380, 494, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT PREMIUM EPOXY PRIMER RED OXIDE W/CATALYST 4L', 'Paint', 'WCPEPRO-4L', 0, 685, 890.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ADD ON 12%', 'Paint', 'ADD', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON ULTRA 8300F CRYSTAL 2K CLEAR W/H 1L', 'Paint', 'NP8300-1L', 41, 1505, 1770, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PP BUMPER PRIMER CLEAR 1L', 'Paint', 'PRI122', 23, 665, 700, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU TOPCOAT CLEAR W/H 1L', 'Paint', 'PGPUTC-1L', 0, 430.1, 559.13, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU SPRAY FILLER LIGHT GRAY W/H 1L', 'Paint', 'PGPUSF-1L', 0, 380.8, 495.04, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS PU COLOR CATALYST CAN', 'Paint', 'PGCAT-CAN', 0, 216.75, 281.78, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('POLYGLOSS URETHANE THINNER 4L', 'Paint', 'PGPUTH-4L', 0, 569, 739.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-393 FOXY 4L', 'Paint', 'RSF-4L', 12, 749.08, 973.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-809 MILK 4L', 'Paint', 'RSMLK-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-309 LAVENDER 4L', 'Paint', 'RSL-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-111 BLACK 4L', 'Paint', 'RSB-4L', 16, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-363 ANGELINA 4L', 'Paint', 'RSA-4L', 8, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-833 ALMOST BLACK 4L', 'Paint', 'RSAB-4L', 8, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE RS-1000 XTRA GLOSS 4L', 'Paint', 'RSXG-4L', 7, 609.19, 791.95, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS QDE WHITE 4L (DOUBLE ENTRY)', 'Paint', 'TXSWHT-4L NO', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TEXAS QDE BLACK 4L (DOUBLE ENTRY)', 'Paint', 'TXSBLK-4L NO', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TREND FLAT LATEX WHITE 4L', 'Paint', 'TFLXW-4L', 0, 270, 351, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TREND SG LATEX WHITE 4L', 'Paint', 'TSGLXW-4L', 0, 405, 526.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TREND GLOSS LATEX WHITE 4L', 'Paint', 'TGLXW-4L', 0, 450, 585, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PARALUX ZINC CHROMATE YELLOW W/H 4L', 'Paint', 'PLXZY-4L', 0, 879.94, 1143.92, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER WHITE W/H 1L', 'Paint', 'USAEPW-1L', 24, 183, 237.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER GRAY W/H 1L', 'Paint', 'USAEPG-1L', 0, 175, 227.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 1L', 'Paint', 'USAEPRO-1L', 0, 166, 215.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER RED OXIDE W/H 4L', 'Paint', 'USAEPRO-4L', 0, 590, 767, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA POLYURETHANE TOPCOAT W/H 1L', 'Paint', 'ALPPUTC-1L', 0, 361.9, 470.47, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ARKHON SKIM COAT 4L', 'Paint', 'ASKM-4L', 15, 347.46, 451.7, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE MAROON 4L', 'Paint', 'WCQDM-4L', 8, 694.93, 903.41, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE SILVER FINISH ALUMINUM 4L', 'Paint', 'DVQDAS-4L', 0, 757, 984.1, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN AND RAIN LOVELY DAYS 4L', 'Paint', 'SRLD-4L', 0, 698, 907.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN AND RAIN BLACK 4L', 'Paint', 'SRBLK-4L', 0, 698, 907.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PLYOX LAZER HI-HEAT BLACK', 'Paint', 'HIHEAT', 84, 150.5, 195.65, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EMPTY CAN LITER', 'Paint', 'CAN-1L', 0, 4, 5.2, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'WBREENTG-4L', 0, 1200, 1560, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE ROS-239 HONEY BUN 4L', 'Paint', 'RSHB-4L', 0, 755, 981.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GLAZER EPOXY ENAMEL THALO BLUE W/H 4L', 'Paint', 'GLEENTB-4L', 8, 1094.8, 1423.24, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER EPOXY ENAMEL BLACK W/H 4L', 'Paint', 'WBREEB-4L', 0, 1260, 1638, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WEBER EPOXY ENAMEL LEMON YELLOW W/H 4L', 'Paint', 'WBREELY-4L', 0, 1260, 1638, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BOYSEN LACQUER THINNER 4L', 'Paint', 'BLT-4L', 0, 588, 764.4, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER GRAY W/H 4L', 'Paint', 'USAEPG-4L', 0, 780, 1014, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RAIN OR SHINE SUN ROOF RIVERA ORANGE 4L', 'Paint', 'RSSRRO-4L', 0, 695, 903.5, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY PRIMER WHITE W/H 4L', 'Paint', 'USAEPW-4L', 0, 753, 978.9, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DAVIES QDE CRYSTAL GREEN 4L', 'Paint', 'DVQDCG-4L', 15, 851, 1106.3, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('APLUS LACQUER THINNER 4L', 'Paint', 'APLT-4L', 220, 517.27, 672.45, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ROOF AZURE BLUE 4L', 'Paint', 'ARAB-4L', 0, 654.31, 850.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ROOF BAGUIO GREEN 4L', 'Paint', 'ARBG-4L', 0, 631.75, 821.27, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ROOF SPANISH RED 4L', 'Paint', 'ARSR-4L', 0, 564.06, 733.28, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA CHROMA ROOF TERRA COTTA 4L', 'Paint', 'ARTC-4L', 0, 582.11, 756.74, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('USA EPOXY ENAMEL THALO GREEN W/H 4L', 'Paint', 'USAEPENTG-4L', 0, 940, 1222, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE APPLE GREEN 4L', 'Paint', 'WCQDAG-4L', 0, 731.03, 950.34, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR BABY PINK 4L', 'Paint', 'WCQDBP-4L', 0, 857.38, 1114.59, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL BLUE 4L', 'Paint', 'WCQDCRB-4L', 0, 685.9, 891.67, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE CRYSTAL GREEN 4L', 'Paint', 'WCQDCG-4L', 0, 694.93, 903.41, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE MANDARIN RED 4L', 'Paint', 'WCQDMR-4L', 0, 920.55, 1196.71, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WELCOAT REGULAR QDE SKY BLUE 4L', 'Paint', 'WCQDSB-4L', 0, 685.9, 891.67, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PREMILA MIXING GALON', 'Paint', 'PREM-MIX-GL', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PREMILA MIXING LITER', 'Paint', 'PREM-MIX-LTR', 0, 0, 0, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX PRO SPRAY GUN', 'Paint', 'NPSPGUN', 0, 13000, 16900, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING SKY BLUE 1532P 5L', 'Paint', '1532P-5L', -4, 1887.6, 2453.88, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING BLUE MERCURY 2099A 5L', 'Paint', '2099A-5L', -2, 2372, 3083.6, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING WOODS TRAIL 2123A 5L', 'Paint', '2123A-5L', -3, 2150.6, 2795.78, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NIPPON MULTIPURPOSE FLOOR COATING WHITE 145(N1) 5L', 'Paint', '145(N1)-5L', -1, 1736, 2256.8, b_id) ON CONFLICT (product_name, branch_id) DO NOTHING;
END $$;
