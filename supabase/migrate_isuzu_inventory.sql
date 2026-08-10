-- Migrate Isuzu Master Inventory
DO $$
DECLARE b_id UUID;
BEGIN
  SELECT id INTO b_id FROM public.branches WHERE name ILIKE '%isuzu%' LIMIT 1;
  IF b_id IS NULL THEN
    SELECT id INTO b_id FROM public.branches ORDER BY created_at LIMIT 1;
  END IF;

  -- NOTE: Consider deleting existing branch inventory if starting fresh, e.g. DELETE FROM public.inventory WHERE branch_id = b_id;

  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('# 7 PAINT ROLLER 2B', 'Paint', '7PR2B', 0, 62, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1" MASKING TAPE CROCO 48''s', 'Paint', '1MTCRO', 95, 31.458333, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1/2" MASKING TAPE CROCO 96''s', 'Paint', '1/2MTCRO', 244, 15.72916, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1/4 MASKING TAPE CROCO 192''s', 'Paint', '1/4MTCRO', 2, 15, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('100 GRITS SAND PAPER EAGLE', 'Paint', '100SPEAG', 0, 28, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1000 GRITS SAND PAPER EAGLE', 'Paint', '1000SPEAG', 187, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('120 GRITS SAND PAPER EAGLE', 'Paint', '120SPEAG', 216, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1200 GRITS SAND PAPER EAGLE', 'Paint', '1200SPEAG', 180, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('1500 GRITS SAND PAPER EAGLE', 'Paint', '1500SPEAG', 206, 28, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2" MASKING TAPE CROCO 24''s', 'Paint', '2MTCRO', 23, 64.5833, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('2000 GRITS SAND PAPER EAGLE', 'Paint', '2000SPEAG', 243, 28, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('240 GRITS SAND PAPER EAGLE', 'Paint', '240SPEAG', 167, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('3/4" MASKING TAPE CROCO 64''s', 'Paint', '3/4MTCRO', 218, 24.21875, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('3/4" PAINT BRUSH VOSCHTECH', 'Paint', '3/4PBVT', 0, 25, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('320 GRITS SAND PAPER EAGLE', 'Paint', '320SPEAG', 203, 13.2, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('36 FLOOR SANDING PAPER 1FTX150FT AIMEE', 'Paint', '36FSPAIM', 0, 22.68, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('400 GRITS SAND PAPER EAGLE', 'Paint', '400SPEAG', 222, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('60 GRIT SAND PAPER EAGLE', 'Paint', '60SPEAG', 91, 28, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('600 GRITS SAND PAPER EAGLE', 'Paint', '600SPEAG', 268, 18.5, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('80 GRIT SAND PAPER EAGLE', 'Paint', '80SPEAG', 154, 28, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('800 GRITS SAND PAPER EAGLE', 'Paint', '800SPEAG', 216, 13.2, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('9200 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA', 'Paint', 'NP9200', 38.5, 930, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('9600 HS 2K CLEAR 2:1 1L W/ HARDENER .5L PREMILA', 'Paint', 'NP9600', 0, 971.0064, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('9700 HS 2K CLEAR 2:1 1L NIPPON PAINT WITH 0.5L HARDENER', 'Paint', 'NP9700', 23, 1065, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ALPHA HIGH BUILD SPRAY FILLER GRAY PRI3634 1L NAX WITH HARDENER', 'Paint', 'PRI3634', 31.25, 353, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ANTI-CORROSION PRIMER GREEN 3370 ANZAHL', 'Paint', 'ANZ3370', 0, 520, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AUTOMOTIVE ENAMEL MIXING', 'Paint', 'A/EMIX', 0, 0, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('AUTUMN RED PREMILA 2K MT607 1L NAX', 'Paint', 'MT607', 1, 2292.9984, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BASE COAT BINDER NB100 PREMILA', 'Paint', 'NB100', 10, 2165, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK AUTOMOTIVE ENAMEL 5690 4L GLAZER', 'Paint', 'GLA-5690', 3, 765, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK EPOXY PRIMER MEG3901 1L METALGUARD W/CAT NIPPON PAINT', 'Paint', 'MEG3901-1L', 0, 193, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK EPOXY PRIMER MEG3901 4L METALGUARD W/CAT NIPPON PAINT', 'Paint', 'MEG3901-4L', 1.375, 710, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK NO. 8 QDU NAT992 1L NAX', 'Paint', 'NAT992', 0, 410, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK TTC QUICK DRYING URETHANE NAT990 1L NAX', 'Paint', 'NAT990-1L', 1, 409, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLACK TTC QUICK DRYING URETHANE NAT990 4L NAX', 'Paint', 'NAT990-4L', 2, 1585, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLENDING THINNER SOB745 4L NAX', 'Paint', 'SOB745', 0, 880, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLUE BLACK PREMILA 2K MT201 1L NAX', 'Paint', 'MT201', 2, 1125, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLUE NO. 8 TTC QUICK DRYING URETHANE NAT556 1L NAX', 'Paint', 'NAT556', 2, 651.4256, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BLUE NO. 9 QDU NAT557 1L NAX', 'Paint', 'NAT557', 0, 473.76, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BODY FILLER 1L DOMINO W/ HARDENER', 'Paint', 'BF1LDOM', 61, 160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BODY FILLER 4L DOMINO W/ HARDENER', 'Paint', 'BF4LDOM', 16, 570, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BRIGHT GOLD MICA TTC QUICK DRYING URETHANE NAT1164 1L NAX', 'Paint', 'NAT1164', 2, 640, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('BRIGHT RED TTC QUICK DRYING URETHANE NAT192 1L NAX', 'Paint', 'NAT192', 1, 540, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CERAMIC CLEAR 2K NAX108 1L NAX WITH HARDENER', 'Paint', 'NAX108', 42, 700, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CINQUASIA BROWN PREMILA 2K MT603 1L N1X', 'Paint', 'MT603', 1, 2022.0032, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CINQUASIA RED PREMILA 2K MT506 1L NAX', 'Paint', 'MT506', 1, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('COARSE SILVER TTC QUICK DRYING URETHANE NAT719 4L NAX', 'Paint', 'NAT719-4L', 0, 2325, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('COLOR COAT CATALYST NAX21 100mL NAX', 'Paint', 'NAX21', 0, 190, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER COARSE PREMILA 2K MT004 1L NAX', 'Paint', 'MT004', 1, 2230, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER EXTRA COARSE PREMILA 2K MT006 1L NAX', 'Paint', 'MT006', 1, 2150, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER EXTRA FINE PREMILA 2K MT001 1L NAX', 'Paint', 'MT001', 1, 2268, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER FINE PREMILA 2K MT002 1L NAX', 'Paint', 'MT002', 3, 2150, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER MEDIUM PREMILA 2K MT003 1L NAX', 'Paint', 'MT003', 1, 2200, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CRYSTAL SILVER SUPER GLAMOUR PREMILA 2K MT008 1L NAX', 'Paint', 'MT008', 1, 2150, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CUSTOM BLUE PREMILA 2K MT805 1L NAX', 'Paint', 'MT805', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CYANINE BLUE PREMILA 2K MT801 NAX', 'Paint', 'MT801', 2, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CYANINE BLUE TTC QUICK DRYING URETHANE NAT595 1L NAX', 'Paint', 'NAT595', 2, 550, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CYANINE GREEN PREMILA 2K MT901 1L NAX', 'Paint', 'MT901', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CYANINE GREEN QUICK DRYING URETHANE NAT410 1L NAX', 'Paint', 'NAT410', 1, 693, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('DEEP BLACK PREMILA 2K MT203 1L NIPPON PAINT', 'Paint', 'MT203', 3, 1668, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EMPTY CAN 3/4L', 'Paint', 'EMPTYCAN', 0, 4, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTRA MAROON PREMILA 2K MT604 1L NAX', 'Paint', 'MT604', 1, 2159.9984, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('EXTRA YELLOW PREMILA 2K MT307 1L NAX', 'Paint', 'MT307', 1, 2020.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('F-75 SPRAY GUN EUROMAX', 'Paint', 'F-75SGEM', 0, 880, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FAST VIOLET PREMILA 2K MT701 1L NAX', 'Paint', 'MT701', 2, 1800, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FINE VIOLET PREMILA 2K MT704 1L NAX', 'Paint', 'MT704', 1, 2022.0032, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FINE YELLOW PREMILA 2K MT303 1L NAX', 'Paint', 'MT303', 1, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLAME RED TTC QUICK DRYING URETHANE NAT143 1L NAX', 'Paint', 'NAT143', 6, 1450, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLANELLA CLOTH 1YARD', 'Paint', 'FLANELLA', 0, 70, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLAT BASE PREMILA 2K FF151 1L NAX', 'Paint', 'FF151', 9, 1160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLAT BLACK QUICK DRYING URETHANE NAX3974 1L NAX', 'Paint', 'NAX3974', 28.375, 451, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FLORA VIOLET PREMILA 2K MT705 1L NAX', 'Paint', 'MT705', 1, 1896, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('FRESH BLUE PREMILA 2K MT803 1L NAX', 'Paint', 'MT803', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GAILY YELLOW PREMILA 2K MT304 1L NAX', 'Paint', 'MT304', 2, 3465, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GIRAFFE YELLOW PREMILA 2K MT606 1L NAX', 'Paint', 'MT606', 1, 1840.0032, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GOLD YELLOW QUICK DRYING URETHANE NAT320 1L NAX', 'Paint', 'NAT320', 1, 440, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GRAPHITE PREMILA 2K MT175 1L NAX', 'Paint', 'MT175', 1, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GRASS GREEN PREMILA 2K MT902 1L NAX', 'Paint', 'MT902', 0, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('GRAY EPOXY PRIMER MEG3602 4L METALGUARD W/CAT NIPPON PAINT', 'Paint', 'MEG3602-4L', 2, 735, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HERMES BLUE PREMILA 2K MT806 1L NAX', 'Paint', 'MT806', 1, 1698.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HIGH GRADE URETHANE THINNER SOB757 4L NAX', 'Paint', 'SOB757', 32.5, 680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HIGH SPARKLE SUPER COARSE PREMILA 2K MT025 1L NAX', 'Paint', 'MT025', 1, 1745, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HI-SPARKLE FINE PREMILA 2K MT023 1L NAX', 'Paint', 'MT023', 1, 1994, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HOSTAPERM YELLOW QUICK DRYING URETHANE NAT321 1L NAX', 'Paint', 'NAT321', 6, 980, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HS FILLER AUTO REFINISH 1L NIPPON PAINT W/HARDENER .25L', 'Paint', 'HSFNP', 1, 550, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('HS SUPER GLAMOUR PREMILA 2K MT028 1L NAX', 'Paint', 'MT028', 1, 2268, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('INDIAN RED PREMILA 2K MT508 1L NAX', 'Paint', 'MT508', 1, 2349, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('IRON RED PREMILA 2K MT601 1L NAX', 'Paint', 'MT601', 1, 1849, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('IRON RED TTC QUICK DRYING URETHANE NAT190 1L NAX', 'Paint', 'NAT190', 1, 357, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('IRON YELLOW TTC QUICK DRYING URETHANE NAT390 1L NAX', 'Paint', 'NAT390', 1, 371, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('JEWEL YELLOW PREMILA 2K MT302 1L NAX', 'Paint', 'MT302', 1, 1778.9968, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MAPICO YELLOW PREMILA 2K MT301 1L NAX', 'Paint', 'MT301', 1, 1840.0032, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MAXIM ORANGE PREMILA 2K MT401 1L NAX', 'Paint', 'MT401', 2, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MAXIMA 2K URETHANE FAST DRY CLEAR NAX141 1L W/HARDENER NAX', 'Paint', 'NAX141', 0, 344, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MEDIUM FINE TTC QUICK DRYING URETHANE NAT712 4L NAX', 'Paint', 'NAT712-4L', 0, 2180, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALLIC BASE FINE PREMILA 2K MT012 1L NAX', 'Paint', 'MT012', 1, 1840, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALLIC GOLD PREMILA 2K MT134 1L NAX', 'Paint', 'MT134', 1, 2845, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALLIC MEDIUM FINE PREMILA 2K MT033 1L NAX', 'Paint', 'MT033', 1, 1840, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('METALLIC ORANGE PREMILA 2K MT136 1L NAX', 'Paint', 'MT136', 1, 5123.5184, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2BZ PREMILA 2K MT051 1L NAX', 'Paint', 'MT051', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2K PREMILA 2K MT067 1L NAX', 'Paint', 'MT067', 1, 3000, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2R MT066 1L PREMILA', 'Paint', 'MT066', 1, 3153.71, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2ST PREMILA 2K MT050 1L NAX', 'Paint', 'MT050', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2V PREMILA 2K MT079 1L NAX', 'Paint', 'MT079', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 2W PREMILA 2K MT072 1L NAX', 'Paint', 'MT072', 1, 3673.4992, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3B PREMILA 2K MT065 1L NAX', 'Paint', 'MT065', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3G PREMILA 2K MT080 1L NAX', 'Paint', 'MT080', 1, 3000, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3M PREMILA 2K MT096 1L NAX', 'Paint', 'MT096', 1, 6180, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3PR PREMILA 2K MT081 1L NAX', 'Paint', 'MT081', 1, 3000, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3U PREMILA 2K MT068 1L NAX', 'Paint', 'MT068', 2, 6320, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 3Y PREMILA 2K MT075 1L NAX', 'Paint', 'MT075', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 4G PREMILA 2K MT085 1L NAX', 'Paint', 'MT085', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 4R PREMILA 2K MT083 1L NAX', 'Paint', 'MT083', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 4Y PREMILA 2K MT076 1L NAX', 'Paint', 'MT076', 1, 3067.1984, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 5B PREMILA 2K MT071 1L NAX', 'Paint', 'MT071', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 5G PREMILA 2K MT093 1L NAX', 'Paint', 'MT093', 1, 3153.7072, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 5W PREMILA 2K MT078 1L NAX', 'Paint', 'MT078', 2, 3220.8064, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 6B PREMILA 2K MT086 1L NAX', 'Paint', 'MT086', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MICA BASE 6W PREMILA 2K MT061 1L NAX', 'Paint', 'MT061', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('MULTI PURPOSE URETHANE THINNER SOB642 4L NAX', 'Paint', 'SOB642', 0, 600, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NANOGLOS 3.8L MTX', 'Paint', 'NGMTX', 0, 2400, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NATURAL YELLOW PREMILA 2K MT305 1L NAX', 'Paint', 'MT305', 2, 1835.8256, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX / EXTREME QUICK DRY URETHINE (MIXING)', 'Paint', 'NAX/EXTMIX', 13.875, 569.52, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ISUZU TRAVIS HARDENER NUH444 1L NIPPON PAINT', 'Paint', 'NUH444-1L', 0, 660, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ULTIMA ISUZU TRAVIS WHITE 4L NIPPON PAINT', 'Paint', 'NAXISUTRA-4L', 3, 2420, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NAX ULTIMA PRIMER SURFACER WHITE 4L W/HARDENER 1L', 'Paint', 'NUP3038', 3, 1450, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NEO MICA BASE 3AB PREMILA 2K MT06H 1L NAX', 'Paint', 'MT06H', 1, 3680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NEO MICA BASE 3AG PREMILA 2K MT06M 1L NAX', 'Paint', 'MT06M', 1, 3679.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('NEO MICA BASE 3YG PREMILA 2K MT06A 1L NAX', 'Paint', 'MT06A', 1, 3650, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OLD NEWS PAPER', 'Paint', 'ONP', 0, 45, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OPAL COLOUR LS PREMILA 2K MT170 1L NAX', 'Paint', 'MT170', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('OPAL COLOUR PREMILA 2K MT172 1L NAX', 'Paint', 'MT172', 1, 3160, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ORIENT BLUE PREMILA 2K MT804 1L NAX', 'Paint', 'MT804', 2, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PEGASUS MAROON PREMILA 2K MT602 1L NAX', 'Paint', 'MT602', 2, 2375, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PP BUMPER PRIMER GRAY PRI1680 1L NAX', 'Paint', 'PRI1680', 16, 496, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PREMILA 2K (MIXING)', 'Paint', 'PREMILAMIX', 63.75, 2403.78, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PREMILA 2K HARDENER PHD411 1L', 'Paint', 'PHD411', 0, 980, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('PURPLISH RED TTC QUICK DRYING URETHANE NAT196 1L NAX', 'Paint', 'NAT196', 0, 1141, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU BLACK EXTREME 4L NIPPON PAINT', 'Paint', 'QDUBLKEXT', 0, 1485, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU BLUE EXTREME 4L NIPPON PAINT', 'Paint', 'QDUBLUEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU CINQUASIA VIOLET EXTREME 4L NIPPON PAINT', 'Paint', 'QDUCVEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU FINE SILVER EXTREME 4L NIPPON PAINT', 'Paint', 'QDUFSEXT', 0, 1485, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU GREEN EXTREME 4L NIPPON PAINT', 'Paint', 'QDUGRNEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU MAGENTA EXTREME 4L NIPPON PAINT', 'Paint', 'QDUMAGEXT', 0, 1870, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU MAROON EXTREME 4L NIPPON PAINT', 'Paint', 'QDUMAREXT', 0, 1771, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU ORANGE EXTREME 4L NIPPON PAINT', 'Paint', 'QDUORAEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU RED EXTREME 4L NIPPON PAINT', 'Paint', 'QDUREDEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU SILVER EXTREME 4L NIPPON PAINT', 'Paint', 'QDUSILEXT', 0, 1485, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU WARM YELLOW 4L NIPPON PAINT', 'Paint', 'QDUWYEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU WHITE EXTREME 4L NIPPON PAINT', 'Paint', 'QDUWHTEXT', 0, 1485, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('QDU YELLOW EXTREME 4L NIPPON PAINT', 'Paint', 'QDUYELEXT', 0, 1630, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ROBERCAR ROBBING COMPOUND 1KG ROBERLO', 'Paint', 'ROBRC-1KG', 16.5, 780, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('RUBY RED PREMILA 2K MT507 1L NAX', 'Paint', 'MT507', 1, 2955, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SHADOW GREEN PREMILA 2K MT904 1L NAX', 'Paint', 'MT904', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SOLID BASE COAT BINDER NB200 4L PREMILA', 'Paint', 'NB200', 0, 2100, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SOLVENT NAPTHA DEGREASER SOD145 4L NAX', 'Paint', 'SOD145', 5, 445, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SPARK RED PREMILA 2K MT505 1L NAX', 'Paint', 'MT505', 2, 2900, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SPARKLE SILVER QDU NAT716 1L NAX', 'Paint', 'NAT716', 2, 422, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('STRONG RED PREMILA 2K MT501 1L NAX', 'Paint', 'MT501', 1, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN GREEN PREMILA 2K MT903 1L NAX', 'Paint', 'MT903', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUN ORANGE PREMILA 2K MT405 1L NAX', 'Paint', 'MT405', 1, 1999.9952, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('THRENE RED G PREMILA 2K MT503 1L NAX', 'Paint', 'MT503', 2, 1980, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TINTING BLACK PREMILA 2K MT202 NIPPON', 'Paint', 'MT202', 1, 1125, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('ULTRA 8100T FD 2K CLEAR 1L W/HARDENER 0.5L', 'Paint', 'NP8100T', 4, 1260, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('VACANCE BLUE PREMILA 2K MT807 1L NAX', 'Paint', 'MT807', 1, 1680, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WASTE COTTON PAD', 'Paint', 'WCP', 0, 70, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE AUTOMOTIVE ENAMEL 5615 4L GLAZER', 'Paint', 'GLA-5615', 4, 855, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE EPOXY PRIMER MEG3001 4L METALGUARD W/CAT NIPPON PAINT', 'Paint', 'MEG3001-4L', 1.375, 710, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE HS PREMILA 2K MT100 1L NIPPON', 'Paint', 'MT100-1L', 2, 1090, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE LS PREMILA 2K MT103 1L NAX', 'Paint', 'MT103', 1, 1090, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE METALLIC SNOW FINE PREMILA 2K MT030 1L NAX', 'Paint', 'MT030', 1, 1840, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE PREMILA 2K MT100 4L NIPPON', 'Paint', 'MT100-4L', 3, 6000, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('WHITE TTC QUICK DRYING URETHANE NAT100 4L NAX', 'Paint', 'NAT100-4L', 6, 1545, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUPER ORANGE TTC QUICK DRYING URETHANE NAT210 1L', 'Paint', 'NAT210', 6, 1600, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('SUPER YELLOW TTC QUICK DRYING URETHANE NAT380 1L NAX', 'Paint', 'NAT380', 4, 1100, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('36 FLOOR SANDING PAPER SUPREME 1FTX150FT CUMI', 'Paint', '36FSPSUP', 141, 67.3333, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('CINQUASIA VIOLET QDU NAT158 1L NAX', 'Paint', 'NAT158', 0, 1450, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
  INSERT INTO public.inventory (product_name, category, sku, quantity, cost, price, branch_id)
  VALUES ('TACK CLOTH ROBERLO', 'Paint', 'TCROB', 2, 50, 0, b_id)
  ON CONFLICT (product_name, branch_id) DO UPDATE SET sku = EXCLUDED.sku, quantity = EXCLUDED.quantity, cost = EXCLUDED.cost, price = EXCLUDED.price;
END $$;
